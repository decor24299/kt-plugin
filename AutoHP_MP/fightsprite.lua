local uiFightSprite		= Ui:GetClass("fightsprite");
local tbTimer = Ui.tbLogic.tbTimer;

uiFightSprite.WND_MAIN		= "Main";
uiFightSprite.STATE_MAIN	= "StateMain";

uiFightSprite.PRG_LIFE		= {
	[1]	= {30, "ImgPartLife_Red"},
	[2]	= {50, "ImgPartLife_Yellow"},
	[3]	= {100, "ImgPartLife_Green"},
}

uiFightSprite.PRG_MANA		= "ImgPartMana";
uiFightSprite.TXT_LIFE		= "TxtLife";
uiFightSprite.TXT_MANA		= "TxtMana";

uiFightSprite.tbAllModeResolution	= {
	["a"]	= { 279, 305 },
	["b"]	= { 200, 80 },
	["c"]	= { 513, 466 },
};


uiFightSprite.nCounter	 	= 0;
uiFightSprite.eat_life_time = 0;

uiFightSprite.nTimerId		= 0;
uiFightSprite.TIMER_FRAME	= Env.GAME_FPS / 6; 	
uiFightSprite.EAT_SLEEP 	= 3;					

uiFightSprite.nShowLife		= 0;
uiFightSprite.life_left		= 50;

function uiFightSprite:_Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiFightSprite.EnterGame_bak(Ui);
		uiFightSprite:OnEnterGame();
	end
	self.UIGROUP	= Ui.UI_FIGHTSPRITE;
	self:RegisterEvent();
	
	print("FightSprite Loaded!");
end

function uiFightSprite:OnOpen()
	self:UpdateAll()
end

function uiFightSprite:UpdateAll()
	
	local tbSaveData 		= Ui.tbLogic.tbSaveData;
	local tbPlus_Setting = Ui:GetClass("peresplus_setting");
	local tbSetting = tbPlus_Setting:Load(tbPlus_Setting.DATA_KEY) or {};
	self.nShowLife	= tbSetting.nShowLife or 0;
	print("self.nShowLife", self.nShowLife);
	
	self.nAutoEat	= tbSetting.nAutoEat or 0;
	
	self.nAutoEatBlue	= tbSetting.nAutoEatBlue or 0;
	
	self.nAutoRefuse	= tbSetting.nAutoRefuse or 0;
	print("self.nAutoRefuse", self.nAutoRefuse);
	
	self.life_left 			= AutoAi.tbAutoAiCfg.nLifeRet;
	print("AutoAi.nLifeRet: ", self.life_left);
	
	if self.nShowLife ~= 1 then
		Wnd_Hide(self.UIGROUP, self.STATE_MAIN);
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫¥÷—™Ãıπÿ±’£°<color>");
	else
		Wnd_Show(self.UIGROUP, self.STATE_MAIN);
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫¥÷—™Ãıø™∆Ù£°<color>");
	end
	
	if self.nAutoEat == 1 then
		-- self:StartTimer();
		AutoAi:AutoEatRed(1,tbSetting.nLifeRet,tbSetting.nPkModel,tbSetting.nSeriesRed,tbSetting.nAutoSelect); -- JUN
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫◊‘∂Ø∫»∫Ïø™∆Ù£°<color>");
	else
		-- self:StopTimer();
		AutoAi:AutoEatRed(0); -- JUN
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫◊‘∂Ø∫»∫Ïπÿ±’£°<color>");
	end
	
	if self.nAutoEatBlue == 1 then  -- JUN
		AutoAi:AutoEatBlue(1,tbSetting.nManaRet,tbSetting.nPkModel,tbSetting.nPkSeriesBlue,tbSetting.nAutoSelect);
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫◊‘∂Ø∫»¿∂ø™∆Ù£°<color>");
	else
		AutoAi:AutoEatBlue(0);
		-- me.Msg("<color=yellow>[AutoHP_MP]£∫◊‘∂Ø∫»¿∂πÿ±’£°<color>");
	end
	
	Ui.tbLogic.tbConfirm.nAutoRefuse = self.nAutoRefuse;
	-- me.Msg("<color=yellow>[AutoHP_MP]£∫◊‘∂Øæ‹æ¯…Í«Î…Ë÷√ <color>"..self.nAutoRefuse);
	
	self:UpdateLife();
	self:UpdateMana();
end

function uiFightSprite:OnClose()
	self:StopTimer();
end

function uiFightSprite:UpdateLife()
	Txt_SetTxt(self.UIGROUP, self.TXT_LIFE, me.nCurLife.."/"..me.nMaxLife);

	for i=1, 3 do
		Wnd_Hide(self.UIGROUP, self.PRG_LIFE[i][2]);
	end

	for i=1, 3 do
		if (me.nCurLife / me.nMaxLife)*100 <= self.PRG_LIFE[i][1] then
			Prg_SetPos(self.UIGROUP, self.PRG_LIFE[i][2], me.nCurLife / me.nMaxLife * 1000);
			Wnd_Show(self.UIGROUP, self.PRG_LIFE[i][2]);
			break
		end
	end
end

function uiFightSprite:UpdateMana()
	print("uiFightSprite:UpdateMana", me.nCurMana, me.nMaxMana);
	Prg_SetPos(self.UIGROUP, self.PRG_MANA, me.nCurMana / me.nMaxMana * 1000);
	Txt_SetTxt(self.UIGROUP, self.TXT_MANA, me.nCurMana.."/"..me.nMaxMana);
end

function uiFightSprite:OnEnterGame()

--	LoadUiGroup(Ui.UI_FIGHTSPRITE, "fightsprite.ini");
		
	UiManager:OpenWindow(self.UIGROUP);
	
--	self:StartTimer();

end

function uiFightSprite:StartTimer()
	if self.nTimerId == 0 then
		print("uiFightSprite:StartTimer()");
		self.nTimerId = tbTimer:Register(self.TIMER_FRAME, self.OnTimer, self);
	end
end

function uiFightSprite:StopTimer()
	if self.nTimerId~=0 then
		print("uiFightSprite:StopTimer()");
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
	end
end

function uiFightSprite:OnTimer()
--	if self.nAutoEat ~= 1 then return; end
	
	self.nCounter = self.nCounter + 1;
	
	if (me.nCurLife * 100 / me.nMaxLife < self.life_left) then 
		if (self.nCounter - self.eat_life_time > self.EAT_SLEEP) then
			if (AutoAi.Eat(1) == 0) then
				print("Kh√¥ng c√≥ thu·ªëc HP trong...");
			else
				AutoAi.Eat(1);
				print("D√πng thu·ªëc HP.");
			end
			self.eat_life_time = self.nCounter;
		end
	end
	
end

function uiFightSprite:RegisterEvent()
	print("uiFightSprite:RegisterEvent");
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_SYNC_LIFE,		self.UpdateLife },	
		{ UiNotify.emCOREEVENT_SYNC_MANA,		self.UpdateMana },
	};
	
	for _, tbEvent in pairs(tbRegEvent) do
		UiNotify:RegistNotify(tbEvent[1], tbEvent[2], self);
	end	
--	return tbRegEvent;
end

Ui:RegisterNewUiWindow("UI_FIGHTSPRITE", "fightsprite", {"a", 279, 305}, {"b", 200, 80}, {"c", 513, 466}, {"d", 500, 360});

uiFightSprite:_Init();


local tbConfirm = Ui.tbLogic.tbConfirm;

local OnTeamReceiveInvite_Bak		= tbConfirm.OnTeamReceiveInvite;
local OnTeamApplyAdd_Bak			= tbConfirm.OnTeamApplyAdd;
local OnTradeReceiveRequest_Bak		= tbConfirm.OnTradeReceiveRequest;
local OnRelationTmpFriend_Bak		= tbConfirm.OnRelationTmpFriend;

tbConfirm.OnTeamReceiveInvite = function(self, szKey, szPlayer, nPlayerId)
	if tbConfirm.nAutoRefuse == 1 then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> [m·ªùi b·∫°n v√†o nh√≥m]<color><color=yellow> ƒë√£ b·ª?<color><color=pink> h·ª?th·ªëng t·ª?ƒë·ªông t·ª?ch·ªëi!<color>");
	else
		OnTeamReceiveInvite_Bak(self, szKey, szPlayer, nPlayerId);
	end
end

tbConfirm.OnTeamApplyAdd = function(self, szKey, szPlayer, nPlayerId)
	if tbConfirm.nAutoRefuse == 1 then
		me.Msg("<color=green>"..szPlayer.."<color><color=yellow> [xin v√†o nh√≥m]  <color><color=yellow>c·ªßa b·∫°n ƒë√£ b·ª?<color><color=pink> h·ª?th·ªëng t·ª?ƒë·ªông t·ª?ch·ªëi!<color>");
	else
		OnTeamApplyAdd_Bak(self, szKey, szPlayer, nPlayerId);
	end
end

tbConfirm.OnTradeReceiveRequest = function(self, szKey, szPlayer)
	if tbConfirm.nAutoRefuse == 1 then
		me.Msg("<color=green>"..szPlayer.."<color><color=white> [m·ªùi b·∫°n giao d·ªãch] <color><color=yellow>ƒë√£ b·ª?color><color=pink> h·ª?th·ªëng t·ª?ƒë·ªông t·ª?ch·ªëi!<color>");
		-- me.Msg("<color=yellow>ø…µ„ø™GM≈‘±ﬂµƒ∞¥≈•∞—∆¡±Œ…Í«Î—°œÓ»°œ˚°£<color>")
	-- elseif szPlayer == "∑ÁÏ·◊”—Û" then
		-- me.Msg("<color=yellow>¥À»À «∆≠◊”£¨≤ªƒ‹”Î÷ÆΩª“◊£°<color>")
	else
		OnTradeReceiveRequest_Bak(self, szKey, szPlayer);
	end
end

tbConfirm.OnRelationTmpFriend = function(szKey, szPlayer)
	if tbConfirm.nAutoRefuse == 1 then
		me.Msg("<color=green>"..szPlayer.."<color><color=white> [m·ªùi b·∫°n l√†m h·∫£o h·ªØu]<color><color=yellow> ƒë√£ b·ª?color><color=pink>  h·ª?th·ªëng t·ª?ƒë·ªông t·ª?ch·ªëi!<color>");
	else
		OnRelationTmpFriend_Bak(szKey, szPlayer);
	end
end

local tbPlus_Setting			     = Ui:GetClass("peresplus_setting");
local tbSaveData 				       = Ui.tbLogic.tbSaveData;

tbPlus_Setting.BTN_CLOSE	= "BtnClose";
tbPlus_Setting.BTN_SAVE         = "BtnSave";
tbPlus_Setting.BTN_EXIT         = "BtnExit"; 
tbPlus_Setting.BTN_SHOWLIFE		  = "BtnShowLife";
tbPlus_Setting.BTN_AUTOSELECT   = "BtnAutoSelect";
tbPlus_Setting.BTN_PKMODEL      = "BtnPkModel";
tbPlus_Setting.BTN_AUTOEAT		  = "BtnAutoEat"; 
tbPlus_Setting.BTN_AUTOEATBLUE  = "BtnAutoEatBlue";
tbPlus_Setting.BTN_PKSERIESRED  = "BtnSeriesRed"; 
tbPlus_Setting.BTN_PKSERIESBLUE = "BtnSeriesBlue";
tbPlus_Setting.BTN_AUTOREFUSE	  = "BtnAutoRefuse";
tbPlus_Setting.SCROLL_LIFE		  = "ScrbarLife"; 
tbPlus_Setting.SCROLL_MANA		  = "ScrbarMana"; 
tbPlus_Setting.TXT_LIFE				  = "TxtLife"; 
tbPlus_Setting.TXT_MANA				  = "TxtMana";  

tbPlus_Setting.DATA_KEY			= "FightSprite";
tbPlus_Setting.tbSetting		= {};

function tbPlus_Setting:OnOpen()
	self.tbSetting	= tbPlus_Setting:Load(self.DATA_KEY) or {};
	
	if not self.tbSetting.nShowLife then
		self.tbSetting.nShowLife = 0;
	end
	
	if not self.tbSetting.nAutoEat then
		self.tbSetting.nAutoEat = 0;
	end	
	
	if not self.tbSetting.nAutoEatBlue then
		self.tbSetting.nAutoEatBlue = 0; 
	end	
	
	if not self.tbSetting.nAutoRefuse then
		self.tbSetting.nAutoRefuse = 0;
	end
	
	if not self.tbSetting.nLifeRet then
		self.tbSetting.nLifeRet = 0; 
	end
	
	if not self.tbSetting.nManaRet then
		self.tbSetting.nManaRet = 0; 
	end
	
	if not self.tbSetting.nAutoSelect then
		self.tbSetting.nAutoSelect = 0;
	end
	
	if not self.tbSetting.nPkModel then
		self.tbSetting.nPkModel = 0;
	end
	
	if not self.tbSetting.nSeriesRed then
		self.tbSetting.nSeriesRed = 0;
	end
	
	if not self.tbSetting.nSeriesBlue then
		self.tbSetting.nSeriesBlue = 0;
	end
	
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_SHOWLIFE, self.tbSetting.nShowLife);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_AUTOEAT, self.tbSetting.nAutoEat);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_AUTOEATBLUE, self.tbSetting.nAutoEatBlue); -- JUN
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_AUTOREFUSE, self.tbSetting.nAutoRefuse);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_AUTOSELECT, self.tbSetting.nAutoSelect);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_PKMODEL, self.tbSetting.nPkModel);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_PKSERIESRED, self.tbSetting.nSeriesRed);
	Btn_Check("UI_PERESPLUS_SETTING", self.BTN_PKSERIESBLUE, self.tbSetting.nSeriesBlue);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_LIFE, self.tbSetting.nLifeRet / 5); -- JUN
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MANA, self.tbSetting.nManaRet / 5); -- JUN
	
	self:UpdateLable(); 
end

function tbPlus_Setting:OnClose()
	-- self:SaveSetting();	
	-- Ui:GetClass("fightsprite"):UpdateAll();
end

function tbPlus_Setting:SaveSetting()
	tbPlus_Setting:Save(self.DATA_KEY, self.tbSetting);
end

function tbPlus_Setting:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_CLOSE or szWnd == self.BTN_EXIT then
		UiManager:CloseWindow("UI_PERESPLUS_SETTING");
	elseif szWnd == self.BTN_SAVE then
		self:SaveSetting();
		Ui:GetClass("fightsprite"):UpdateAll();
		UiManager:CloseWindow("UI_PERESPLUS_SETTING");
	elseif szWnd == self.BTN_SHOWLIFE then
		self.tbSetting.nShowLife = nParam;
	elseif szWnd == self.BTN_AUTOEAT then
		self.tbSetting.nAutoEat = nParam;
	elseif szWnd == self.BTN_AUTOEATBLUE then
		self.tbSetting.nAutoEatBlue = nParam;
	elseif szWnd == self.BTN_AUTOREFUSE then
		self.tbSetting.nAutoRefuse = nParam;
		if nParam == 1 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Ch·∫∑n nh·ªØng l·ªùi m·ªùi g√¢y r·ªëi trong khi ƒëang chi·∫øn ƒë·∫•u<color>")
		end
	elseif szWnd == self.BTN_AUTOSELECT then
		self.tbSetting.nAutoSelect = nParam;
	elseif szWnd == self.BTN_PKMODEL then
		self.tbSetting.nPkModel = nParam;
	elseif szWnd == self.BTN_PKSERIESRED then
		self.tbSetting.nSeriesRed = nParam;
	elseif szWnd == self.BTN_PKSERIESBLUE then
		self.tbSetting.nSeriesBlue = nParam;
	end
end


function tbPlus_Setting:OnScorllbarPosChanged(szWnd, nParam)	
	if szWnd == tbPlus_Setting.SCROLL_LIFE then
		local nLifeRet = nParam * 5;
		self.tbSetting.nLifeRet = nLifeRet;
	elseif szWnd == tbPlus_Setting.SCROLL_MANA then
		local nManaRet = nParam * 5;
		self.tbSetting.nManaRet = nManaRet;
	end
	self:UpdateLable();
end

function tbPlus_Setting:UpdateLable()
	Txt_SetTxt(self.UIGROUP, tbPlus_Setting.TXT_LIFE, "M√°u d∆∞·ªõi   "..self.tbSetting.nLifeRet.."%   B√∫ m√°u");
	Txt_SetTxt(self.UIGROUP, tbPlus_Setting.TXT_MANA, "Mana d∆∞·ªõi  "..self.tbSetting.nManaRet.."%  B√∫ mana");
end

Ui:RegisterNewUiWindow("UI_PERESPLUS_SETTING", "peresplus_setting", {"a", 100, 66}, {"b", 270, 120}, {"c", 200, 66}, {"d", 658, 253});



function tbPlus_Setting:Save(szKey, tbData)
	self.m_szFilePath="\\user\\AutoHP_MP\\"..me.szName..tostring(me.nFaction).."_setting.txt";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function tbPlus_Setting:Load(key)
	self.m_szFilePath="\\user\\AutoHP_MP\\"..me.szName..tostring(me.nFaction).."_setting.txt";
	self.m_tbData = {};
	print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then
			self.m_tbData = Lib:Str2Val(szData);---
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
	print(self.m_tbData);
	return tbData;
end

function tbPlus_Setting:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	
			return 0;
		end
	end
	return 1;
end

-- UiManager:SwitchWindow("UI_PERESPLUS_SETTING");