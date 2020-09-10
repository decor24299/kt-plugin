local tbTimer = Ui.tbLogic.tbTimer;
local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);

local INTERVAl_RED	  = Env.GAME_FPS / 3;    -- 1/3√ÎºÏ≤È“ª¥Œ—™¡ø
local INTERVAl_BLUE   = Env.GAME_FPS / 3;    -- 1/3√ÎºÏ≤È“ª¥Œƒ⁄¡¶
local nLifeRet        = 0;                   
local nManaLeft       = 30;                  -- ƒ⁄ £œ¬∂‡…ŸæÕ≤πƒ⁄£®∞Ÿ∑÷±»£©
local blife           = 0;
local bmana           = 0;
local bfood           = 1;                   --  «∑Ò◊‘∂Ø≥‘≤À
local nFoodLifeRet    = 0.6;                 -- —™ £œ¬∂‡…ŸæÕ≥‘≤À£®º¥60%£©
local nFoodManaRet    = 0.3;                 -- ƒ⁄ £œ¬∂‡…ŸæÕ≥‘≤À£®º¥20%£©
local nEatRedTimerId  = 0;
local nEatBlueTimerId = 0;
local nAutoSelect     = 0;                   --  «∑Ò◊‘∂Ø—°‘ÒPK≥‘“©ƒ£ Ω,Œ™1 ±°∞PK≥‘“©ƒ£ Ω°±°∞PK¡¨–¯≥‘∫Ï°±°∞PK¡¨–¯≥‘¿∂°±π¥—°Œﬁ–ß
local TimeLastEatRed  = 0;                   -- …œ¥Œ≥‘∫Ï ±º‰
local TimeLastEatBlue = 0;                   -- …œ¥Œ≥‘¿∂ ±º‰
local nPkModel        = 0;                   -- PK≥‘“©ƒ£ Ω 1Œ™PKƒ£ Ω 0Œ™∆Ω≥£ƒ£ Ω
local nSeriesRed      = 0;                   -- PK¡¨–¯≥‘∫Ï
local nSeriesBlue     = 0;                   -- PK¡¨–¯≥‘¿∂
local INTERVAl_PK 	  = 2;                   -- PK ±≥‘“©º‰∏Ù(√Î)
local NUMBER_EAT	    = 3;                   -- PK ±¡¨–¯≥‘“© ˝¡ø
local INTERVAl_NORMAL	= 0.34;                 -- ∆Ω ±≥‘“©º‰∏Ù(√Î)
local nCurMapId       = 0;                   -- º«¬ºµ±«∞µÿÕºID
local nDomainFight    = 0;                   -- º«¬ºµ±«∞’˜’Ω◊¥Ã¨
local nRedTimes       = 0;                   -- º«¬º“—¡¨–¯≥‘∫Ï“© ˝¡ø
local nBlueTimes      = 0;                   -- º«¬º“—¡¨–¯≥‘¿∂“© ˝¡ø
local nMsgSwitch      = 0;                   --  ‰≥ˆ°∞≥‘∫Ïº‰∏Ùªπ £3√Î°±÷Æ¿‡µƒø™πÿ(≥‘“©º‰∏Ù ±º‰1√Î“‘…œ≤≈ ‰≥ˆ)
local num1 = 0;
local num2 = 0;
local RED  = {};
local BLUE = {};

-- ∫Ï“©(∞¸¿®À´ªÿ“©)
local MEDICINE_RED = {
	{17,1,1,6},--¡È÷•–¯√¸ÕË
	{17,1,1,5},--æ≈◊™ªπªÍµ§
	{17,1,1,4},--ªÿÃÏµ§
	{17,1,1,3},--Ω¥¥“©¥Û
	{17,1,1,2},--Ω¥¥“©÷–
	{17,1,1,1},--Ω¥¥“©–°
	
	{17,3,1,6},--—˛≥ÿ¥Ûªπµ§	
	{17,3,1,5},--ŒÂª®”Ò¬∂ÕË
	{17,3,1,4},--∆ﬂ«…≤π–ƒµ§
	{17,3,1,3},--≥–œ…√€£®¥Û£©
	{17,3,1,2},--≥–œ…√€£®÷–£©	
	{17,3,1,1},--≥–œ…√€£®–°£©

	{17,9,1,5},--øÁ∑˛¡™»¸æ≈◊™ªπªÍµ§
	{17,9,1,6},--¡È÷•–¯√¸ÕË
	{17,9,3,5},--ŒÂª®”Ò¬∂ÕË
	{17,9,3,6},--—˛≥ÿ¥Ûªπµ§

	{17,10,1,1},--øÁ∑˛≥«’ΩŒÂª®”Ò¬∂ÕË£¨’‚”¶∏√≤ªƒ‹≥‘

	{17,11,1,1},--≤… ØÌ∂ªÿ—™µ§(–°)
	{17,11,1,2},--≤… ØÌ∂ªÿ—™µ§(÷–)
	{17,11,1,3},--≤… ØÌ∂ªÿ—™µ§(¥Û)
	{17,11,3,1},--≤… ØÌ∂«¨¿§‘ÏªØÕË(–°)
	{17,11,3,2},--≤… ØÌ∂«¨¿§‘ÏªØÕË(÷–)
	{17,11,3,3},--≤… ØÌ∂«¨¿§‘ÏªØÕË(¥Û)

	{17,13,1,1},--∏£¿˚
	{17,13,1,2},
	{17,13,1,3},
	{17,13,1,4},
	{17,13,1,5},
	{17,13,3,1},
	{17,13,3,2},
	{17,13,3,3},
	{17,13,3,4},
	{17,13,3,5},
};

-- ¿∂“©(∞¸¿®À´ªÿ“©)
local MEDICINE_BLUE = {
	{17,2,1,6},--—©≤Œ∑µ∆¯ÕË	
	{17,2,1,5},-- ◊Œ⁄ªπ…Òµ§
	{17,2,1,4},--¥Û≤π…¢
	{17,2,1,3},--ƒ˝…Òµ§£®¥Û£©
	{17,2,1,2},--ƒ˝…Òµ§£®÷–£©
	{17,2,1,1},--ƒ˝…Òµ§£®–°£©
		
	{17,3,1,6},--—˛≥ÿ¥Ûªπµ§	
	{17,3,1,5},--ŒÂª®”Ò¬∂ÕË
	{17,3,1,4},--∆ﬂ«…≤π–ƒµ§
	{17,3,1,3},--≥–œ…√€£®¥Û£©
	{17,3,1,2},--≥–œ…√€£®÷–£©	
	{17,3,1,1},--≥–œ…√€£®–°£©

	{17,9,2,5},--øÁ∑˛¡™»¸ ◊Œ⁄ªπ…Òµ§
	{17,9,2,6},--—©≤Œ∑µ∆¯ÕË	

	{17,10,1,1},--øÁ∑˛≥«’ΩŒÂª®”Ò¬∂ÕË£¨’‚”¶∏√≤ªƒ‹≥‘

	{17,11,2,1},--≤… ØÌ∂ªÿƒ⁄µ§(–°)
	{17,11,2,2},--≤… ØÌ∂ªÿƒ⁄µ§(÷–)
	{17,11,2,3},--≤… ØÌ∂ªÿƒ⁄µ§(¥Û)
	{17,11,3,1},--≤… ØÌ∂«¨¿§‘ÏªØÕË(–°)
	{17,11,3,2},--≤… ØÌ∂«¨¿§‘ÏªØÕË(÷–)
	{17,11,3,3},--≤… ØÌ∂«¨¿§‘ÏªØÕË(¥Û)

	{17,13,2,1},--∏£¿˚
	{17,13,2,2},
	{17,13,2,3},
	{17,13,2,4},
	{17,13,2,5},
	{17,13,3,1},
	{17,13,3,2},
	{17,13,3,3},
	{17,13,3,4},
	{17,13,3,5},
};

function AutoAi:AutoEatRed(nSwitch,nLifeValue,nMyPkModel,nPkSeriesRed,nMyAutoSelect)
	if nSwitch then
		blife = nSwitch;
	elseif (blife == 1) then
		blife = 0;
	else
		blife = 1;
	end
	if blife == 1 then	
		if (nEatRedTimerId > 0) then
			tbTimer:Close(nEatRedTimerId);
		end
		nEatRedTimerId  = 0;
		TimeLastEatRed  = 0;	
		nRedTimes = 0;	
		local tbPlus_Setting = Ui:GetClass("peresplus_setting");
		local tbSetting = {}; 
		if Lib:CountTB(tbPlus_Setting) > 0 then
			tbSetting = tbPlus_Setting:Load(tbPlus_Setting.DATA_KEY) or {};		
			nLifeRet = tbSetting.nLifeRet or 0;
			nPkModel = tbSetting.nPkModel or 0;
			nSeriesRed = tbSetting.nSeriesRed or 0;
			nAutoSelect = tbSetting.nAutoSelect or 0;
		end
		if nLifeValue then
			nLifeRet = nLifeValue;
		elseif (nLifeRet == 0) then
			uiAutoFight:LoadSetting();
			nLifeRet = uiAutoFight.nLifeRet;
		end		
		if nMyPkModel then
			nPkModel = nMyPkModel;
		end	
		if nPkSeriesRed then
			nSeriesRed = nPkSeriesRed;
		end	
		if nMyAutoSelect then
			nAutoSelect = nMyAutoSelect;
		end
		if (nAutoSelect == 1) then
			if me.nPkModel == Player.emKPK_STATE_PRACTISE then
				nPkModel = 0; 
			else
				nPkModel = 1; 
				nSeriesRed = 1;
			end
		end
		RED = AutoAi:GetRedSuitable();
		nCurMapId = me.GetMapTemplateId();
		nDomainFight = me.GetNpc().GetRangeDamageFlag();
		me.Msg("<color=yellow>K√≠ch ho·∫°t t√≠nh nƒÉng t·ª± d√πng HP<color>");
		me.Msg("<color=lightblue>B√∫ M√°u khi c√≤n <color=gold>"..nLifeRet.." % Sinh Kh√≠");
		if (nPkModel == 1) then
			me.Msg("<color=yellow>L·ª±a chu·∫ø ƒë·ªô PK<color>");
		else
			me.Msg("<color=yellow>L·ª±a chu·∫ø ƒë·ªô th∆∞·ªùng<color>");
		end
		if (nEatRedTimerId == 0) then
			nEatRedTimerId = tbTimer:Register(INTERVAl_RED, self.OnEatRedTimer, self);
		end		
	else
		if (nEatRedTimerId > 0) then
			tbTimer:Close(nEatRedTimerId);
		end
		nEatRedTimerId  = 0;
		TimeLastEatRed  = 0;	
		nRedTimes = 0;
		RED = {};
		BLUE = {};
		me.Msg("<color=green>Kh√¥ng t·ª± ƒë·ªông B√∫ HP<color>");
	end
end

function AutoAi:AutoEatBlue(nSwitch,nManaValue,nMyPkModel,nPkSeriesBlue,nMyAutoSelect)
	if nSwitch then
		bmana = nSwitch;
	elseif (bmana == 1) then
		bmana = 0;
	else
		bmana = 1;
	end
	if bmana == 1 then
		if (nEatBlueTimerId > 0) then
			tbTimer:Close(nEatBlueTimerId);
		end
		nEatBlueTimerId = 0;
		TimeLastEatBlue = 0; 		
		nBlueTimes = 0;
		local tbPlus_Setting = Ui:GetClass("peresplus_setting");
		local tbSetting = {}; 
		if Lib:CountTB(tbPlus_Setting) > 0 then
			tbSetting = tbPlus_Setting:Load(tbPlus_Setting.DATA_KEY) or {};		
			nManaLeft = tbSetting.nManaRet or 0;
			nPkModel = tbSetting.nPkModel or 0;
			nSeriesBlue = tbSetting.nSeriesBlue or 0;
			nAutoSelect = tbSetting.nAutoSelect or 0;
		end
		if nManaValue then
			nManaLeft = nManaValue;
		end		
		if nMyPkModel then
			nPkModel = nMyPkModel;
		end	
		if nPkSeriesBlue then
			nSeriesBlue = nPkSeriesBlue;
		end	
		if nMyAutoSelect then
			nAutoSelect = nMyAutoSelect;
		end
		if (nAutoSelect == 1) then
			if me.nPkModel == Player.emKPK_STATE_PRACTISE then
				nPkModel = 0;
			else
				nPkModel = 1;
				nSeriesRed = 1;
			end
		end
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = me.GetMapTemplateId();
		nDomainFight = me.GetNpc().GetRangeDamageFlag();
		me.Msg("<color=yellow>K√≠ch ho·∫°t t√≠nh nƒÉng t·ª± d√πng MP<color>");
		me.Msg("<color=lightblue>B√∫ Mana khi c√≤n <color=gold>"..nManaLeft.." % C√¥ng L·ª±c");
		if (nPkModel == 1) then
			me.Msg("<color=yellow>L·ª±a chu·∫ø ƒë·ªô PK<color>");
		else
			me.Msg("<color=yellow>L·ª±a chu·∫ø ƒë·ªô th∆∞·ªùng<color>");
		end		
		if (nEatBlueTimerId == 0) then
			nEatBlueTimerId = tbTimer:Register(INTERVAl_BLUE, self.OnEatBlueTimer, self);
		end
	else
		if (nEatBlueTimerId > 0) then
			tbTimer:Close(nEatBlueTimerId);
		end
		nEatBlueTimerId = 0;
		TimeLastEatBlue = 0; 		
		nBlueTimes = 0;
		RED = {};
		BLUE = {};
		me.Msg("<color=green>Kh√¥ng t·ª± ƒë·ªông B√∫ MP<color>");
	end
end

function AutoAi:OnEatRedTimer()
	if me.nFightState ~= 1 then
		return
	end
	if (nAutoSelect == 1) then
		if me.nPkModel == Player.emKPK_STATE_PRACTISE then
			nPkModel = 0;  
		else
			nPkModel = 1;  
			nSeriesRed = 1;
		end
	end
	local nMyMapId = me.GetMapTemplateId();
	local nDomain = me.GetNpc().GetRangeDamageFlag();
	if (Lib:CountTB(RED) == 0 or Lib:CountTB(BLUE) == 0 or nMyMapId ~= nCurMapId or nDomain ~= nDomainFight) then
		RED = AutoAi:GetRedSuitable();
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = nMyMapId;
		nDomainFight = nDomain;
	end	
	if bfood == 1 and (me.nCurLife / me.nMaxLife < nFoodLifeRet or me.nCurMana / me.nMaxMana < nFoodManaRet) then
		AutoAi:AutoEatFood();
	end
	local nInterval = 0;
	local nNumberEat = 0;
	if (nPkModel == 1) then
		nInterval = INTERVAl_PK;
	else
		nInterval = INTERVAl_NORMAL;
	end
	if (nPkModel == 1 and nSeriesRed == 1) then
		nNumberEat = NUMBER_EAT;
	else
		nNumberEat = 1;
	end

	if (TimeLastEatRed + nInterval > GetTime()) and (nRedTimes == nNumberEat) then
		num1 = num1 + 1;
		for i = 1, nInterval do
			if (nMsgSwitch == 1 and nInterval > 1 and TimeLastEatRed + i == GetTime() and num1 % 3 == 0) then
				local nRest = nInterval - i;
				me.Msg("<color=lightblue>B√∫ M√°u khi c√≤n <color=gold>"..nRest.." % Sinh Kh√≠");				
			end
		end
		return;		       
	elseif TimeLastEatRed > 0 and TimeLastEatRed + nInterval <= GetTime() then
		nRedTimes = 0; 
		TimeLastEatRed = 0;
		num1 = 0;
	end	
	if (me.nCurLife * 100 / me.nMaxLife < nLifeRet) or (TimeLastEatRed > 0 and nRedTimes < nNumberEat) then	
		for i,tbYAO in pairs(RED) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				TimeLastEatRed = GetTime();
				nRedTimes = nRedTimes + 1;
				return;
			end
		end
	end
end

function AutoAi:OnEatBlueTimer()
	if me.nFightState ~= 1 then
		return
	end
	if (nAutoSelect == 1) then
		if me.nPkModel == Player.emKPK_STATE_PRACTISE then
			nPkModel = 0; 
		else
			nPkModel = 1; 
			nSeriesRed = 1;
		end
	end
	local nMyMapId = me.GetMapTemplateId();
	local nDomain = me.GetNpc().GetRangeDamageFlag();
	if (Lib:CountTB(RED) == 0 or Lib:CountTB(BLUE) == 0 or nMyMapId ~= nCurMapId or nDomain ~= nDomainFight) then
		RED = AutoAi:GetRedSuitable();
		BLUE = AutoAi:GetBlueSuitable();
		nCurMapId = nMyMapId;
		nDomainFight = nDomain;
	end
	if bfood == 1 and (me.nCurLife / me.nMaxLife < nFoodLifeRet or me.nCurMana / me.nMaxMana < nFoodManaRet) then
		AutoAi:AutoEatFood(); 
	end
	local nInterval = 0;
	local nNumberEat = 0;
	if (nPkModel == 1) then
		nInterval = INTERVAl_PK;
	else
		nInterval = INTERVAl_NORMAL;
	end
	if (nPkModel == 1 and nSeriesBlue == 1) then
		nNumberEat = NUMBER_EAT;
	else
		nNumberEat = 1;
	end
	if (TimeLastEatBlue + nInterval > GetTime()) and (nBlueTimes == nNumberEat) then
		num2 = num2 + 1;
		for i = 1, nInterval do
			if (nMsgSwitch == 1 and nInterval > 1 and TimeLastEatRed + i == GetTime() and num2 % 3 == 0) then
				local nRest = nInterval - i;
				me.Msg("<color=lightblue>B√∫ Mana khi c√≤n <color=gold>"..nRest.." % C√¥ng L·ª±c");
			end
		end
		return;		       
	elseif TimeLastEatBlue > 0 and TimeLastEatBlue + nInterval <= GetTime() then
		nBlueTimes = 0;   
		TimeLastEatBlue = 0;
		num2 = 0;
	end	
	if (me.nCurMana * 100 / me.nMaxMana < nManaLeft) or (TimeLastEatBlue > 0 and nBlueTimes < nNumberEat) then			
		for i,tbYAO in pairs(BLUE) do
			local tbFind = me.FindItemInBags(unpack(tbYAO));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				TimeLastEatBlue = GetTime();
				nBlueTimes = nBlueTimes + 1;
				return;
			end
		end
	end
end

function AutoAi:AutoEatFood()
	if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	
		local nLevel, nState, nTime = me.GetSkillState(476); 
		if (not nTime or nTime < 36) then
			AutoAi.nLastFood = nCurTime;
			if 0 == AutoAi.Eat(4) then 
				-- me.Msg("√ª”–≤À≥‘¡À!");
			end
		end
	end
end

function AutoAi:GetRedSuitable()
	local nMyMapId =me.nTemplateMapId;
	local szMapType = AutoAi:GetMapTypeByMapId(nMyMapId);
	local nMapId = me.GetMapTemplateId();
	local szMapName, szMapPath = GetMapPath(nMapId);
	local RED_TEMP = {};
	if (me.GetNpc().GetRangeDamageFlag() == 1) then
		RED_TEMP  = self:GetRedByType(13); 
	elseif (szMapType == "xoyogame") then
		RED_TEMP  = self:GetRedByType(13); 
	elseif (szMapType == "battle") and not (string.find(szMapName,"ƒêo√†n Th·ªÉ")) then
		RED_TEMP  = self:GetRedByType(13);  
	elseif (string.find(szMapName,"øÁ∑˛¡™»¸")) or (string.find(szMapName,"Ã˙∏°≥«")) then
		RED_TEMP  = self:GetRedByType(9); 
	elseif (string.find(szMapName,"ƒêo√†n Th·ªÉ")) then
		RED_TEMP  = self:GetRedByType(11); 
	elseif (szMapType == "kingame_new") then   
		RED_TEMP = self:GetRedByType(13);
	elseif (szMapType == "taskarmy_fb") then  
		RED_TEMP = self:GetRedByType(13);
	elseif (szMapType == "cangbaotu_fb") then 
		RED_TEMP = self:GetRedByType(13);
	else
		RED_TEMP  = self:GetRedByType(0);  
	end
	return RED_TEMP;
end

function AutoAi:GetBlueSuitable()
	local nMyMapId = me.nTemplateMapId;
	local szMapType = AutoAi:GetMapTypeByMapId(nMyMapId);
	local nMapId = me.GetMapTemplateId();
	local szMapName, szMapPath = GetMapPath(nMapId);
	
	local BLUE_TEMP = {};
	if (me.GetNpc().GetRangeDamageFlag() == 1) then
		BLUE_TEMP = self:GetBlueByType(13);
	elseif (szMapType == "xoyogame") then
		BLUE_TEMP = self:GetBlueByType(13);
	elseif (szMapType == "battle") and not (string.find(szMapName,"ƒêo√†n Th·ªÉ")) then
		BLUE_TEMP = self:GetBlueByType(13);
	elseif (string.find(szMapName,"øÁ∑˛¡™»¸")) or (string.find(szMapName,"Ã˙∏°≥«")) then
		BLUE_TEMP = self:GetBlueByType(9);
	elseif (string.find(szMapName,"ƒêo√†n Th·ªÉ")) then
		BLUE_TEMP  = self:GetBlueByType(11); 
	elseif (szMapType == "kingame_new") then
		BLUE_TEMP = self:GetBlueByType(13);
	elseif (szMapType == "taskarmy_fb") then 
		BLUE_TEMP = self:GetBlueByType(13);
	elseif (szMapType == "cangbaotu_fb") then 
		BLUE_TEMP = self:GetBlueByType(13);
	else
		BLUE_TEMP = self:GetBlueByType(0);
	end
	return BLUE_TEMP;
end

function AutoAi:GetRedByType(nType)
	local j = 0;
	local TEMP = {};
	for i,tbYAO in pairs(MEDICINE_RED) do
		local g = tbYAO[1];
		local d = tbYAO[2];
		local p = tbYAO[3];
		local l = tbYAO[4];
		if (d == nType and (p == 1 or p == 3)) or d == 1 or d == 3 or d == 9 then
			j = j + 1;
			TEMP[j] = tbYAO;
		end
	end
	return TEMP;
end

function AutoAi:GetBlueByType(nType)
	local j = 0;
	local TEMP = {};
	for i,tbYAO in pairs(MEDICINE_BLUE) do
		local g = tbYAO[1];
		local d = tbYAO[2];
		local p = tbYAO[3];
		local l = tbYAO[4];
		if (d == nType and (p == 2 or p == 3)) or d == 2 or d == 3 or d == 9 then
			j = j + 1;
			TEMP[j] = tbYAO;
		end
	end
	return TEMP;
end

function AutoAi:GetMapTypeByMapId(nMyMapId)
	local szMapType = "";
	local pTabFile = KIo.OpenTabFile("\\setting\\map\\maplist.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local nMapId = pTabFile.GetInt(i, 2);
		if nMapId == nMyMapId then
			szMapType = pTabFile.GetStr(i, 5);
			break;
		end
	end
	KIo.CloseTabFile(pTabFile);
	return szMapType;
end
