--cyberdemon--
local tbAutoAim	= Map.tbAutoAim or {};
Map.tbAutoAim	= tbAutoAim;
local tbTimer = Ui.tbLogic.tbTimer;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local tbSelectNpc    = Ui(Ui.UI_SELECTNPC);

local SELF_EQUIPMENT =
{
	{ Item.EQUIPPOS_HEAD,		"ObjHead",		"ImgHead"		},
	{ Item.EQUIPPOS_BODY,		"ObjBody",		"ImgBody"		},
	{ Item.EQUIPPOS_BELT,		"ObjBelt",		"ImgBelt"		},
	{ Item.EQUIPPOS_WEAPON,		"ObjWeapon",	"ImgWeapon"		},
	{ Item.EQUIPPOS_FOOT,		"ObjFoot",		"ImgFoot"		},
	{ Item.EQUIPPOS_CUFF,		"ObjCuff",		"ImgCuff"		},
	{ Item.EQUIPPOS_AMULET,		"ObjAmulet",	"ImgAmulet"		},
	{ Item.EQUIPPOS_RING,		"ObjRing",		"ImgRing"		},
	{ Item.EQUIPPOS_NECKLACE,	"ObjNecklace",	"ImgNecklace"	},
	{ Item.EQUIPPOS_PENDANT,	"ObjPendant",	"ImgPendant"	},
	{ Item.EQUIPPOS_HORSE,		"ObjHorse",		"ImgHorse"		},
	{ Item.EQUIPPOS_MASK,		"ObjMask",		"ImgMask"		},
	{ Item.EQUIPPOS_BOOK,		"ObjBook",		"ImgBook"		},
	{ Item.EQUIPPOS_ZHEN,		"ObjZhen",		"ImgZhen"		},
	{ Item.EQUIPPOS_SIGNET, 	"ObjSignet", 	"ImgSignet"		},
	{ Item.EQUIPPOS_MANTLE,		"ObjMantle",	"ImgMantle"		},
	{ Item.EQUIPPOS_CHOP,		"ObjChop", 		"ImgChop"		},
};

function tbAutoAim:Init()
	self:ModifyUi();
	self.nYaoState 		= 0;
	self.nPickState 	= 0;
	self.nfireState 	= 0;
	self.nFollowTime    	= 0.1;
	self.nFollowState 	= 0;
	self.nPID 		= 0;
	self.nPlayerID		= 0;  
	self.nszName		= nil;
	self.nFRange		= 0.4;
	self.nEmFRange		= 0.4;
	self.EatFood 		= 80;
	self.DelayStat 		= 0;
	self.nAttackMonsterState = 0;
	self.nRepairItemState = 0;
	self.nRideRange = 3;
	self.TimeStartFollow = 0;
	self.MaxTimeRepairItem = 3600;
	self.LastRepairTime = 0;
	self.nVuaSua = 0;
	self.nOnOffTrainAfk = 0;
	self.MapidTrain = 132;
	self.PosXTrain = 1682;
	self.PosYTrain = 3481;
	self.OldPosX = 0;
	self.OldPosY = 0;
	self.OldTime = 0;
	self.MaxOldTime1 = 300;
	self.MaxOldTime = 900;
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
end

function tbAutoAim:UpdateSetting(AimCfg)
	self.EMHealDelay = AimCfg.nHealDelay;
end

function tbAutoAim:ModifyUi()
	tbAutoAim.Say_bak	= tbAutoAim.Say_bak or UiCallback.OnMsgArrival
	function UiCallback:OnMsgArrival(nChannelID, szSendName, szMsg)
		tbAutoAim.Say_bak(UiCallback, nChannelID, szSendName, szMsg);
		local function fnOnSay()
			tbAutoAim:OnSay(nChannelID, szSendName, szMsg);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

function tbAutoAim:OnSay(nChannelID, szSendName, szMsg)
	local stype
	if nChannelID==3 then
		stype="Đồng Đội"
	end      
	function tbAutoAim:Split(szFullString, szSeparator)
		local nFindStartIndex = 1
		local nSplitIndex = 1
		local nSplitArray = {}
		while true do
		   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		   if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
	 	  end
	  	 nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   	nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	  	 nSplitIndex = nSplitIndex + 1
		end
		return nSplitArray
	end
end

function tbAutoAim:FollowData(szName,nItemData)
	self.nTrainDcChua = 0;
	self.nBatAutoFight = 0;
	if (nItemData >0) then
		self.nPID = 1;
		self.nPlayerID = nItemData;
		local tbSplit	= Lib:SplitStr(szName, " ");
		self.nszName = tbSplit[1];
		self.nPType = 1;
	else
		self.nPID = 0;
	end
	self:AutoFollow()
end

function tbAutoAim:AutoFollow()
	if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
		self.nRange = self.nEmFRange; 
	else
		self.nRange = self.nFRange; 
	end
	if self.nFollowState == 0 then
		self.nFollowState = 1;
		if self.nPID == 0 then
			local playerInfo = tbSelectNpc.pPlayerInfo;
			if playerInfo then
				self.nPlayerID = tbSelectNpc.pPlayerInfo.dwId;
				self.nszName = tbSelectNpc.pPlayerInfo.szName;
				self.nPType = 2;
			else
				local nAllotModel, tbMemberList = me.GetTeamInfo();
				if nAllotModel and tbMemberList then
    					local tLeader = tbMemberList[1];
					if tLeader.szName == me.szName then
						me.Msg("<color=green>Không có mục tiêu chính xác");
						return;
					else
						self.nPlayerID = tLeader.nPlayerID;
						self.nszName = tLeader.szName;
						self.nPType = 3;
					end
				end
			end
		end
		if (self.nPlayerID == 0) then
				me.Msg("<color=green>Không có mục tiêu chính xác");
			self.nFollowState = 0;
			return;
		end
		Ui(Ui.UI_TASKTIPS):Begin("Bật tự theo sau hộ tống [Ctrl+Q]");		
		me.Msg("<color=green>Đang theo sau: <color=Yellow>"..self.nszName.."");
		nFTimer1 = Timer:Register(self.nFollowTime * Env.GAME_FPS, self.OnFollow1, self);
	else
		self.nFollowState = 0;
		Timer:Close(nFTimer1);
		Ui(Ui.UI_TASKTIPS):Begin("Tắt tự theo sau hộ tống [Ctrl+Q]");
		self.nPID = 0;
		self.nPosX = 0;
		self.nPosY = 0;
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
	end
end

function tbAutoAim:AutoFollowStart()
	if self.nFollowState == 0 then
		tbAutoAim:AutoFollow();
	end
end

function tbAutoAim:AutoFollowStop()
	if self.nFollowState == 1 then
		tbAutoAim:AutoFollow();
	end
end

function tbAutoAim:OnFollow1()
	if (me.IsDead() == 1) then			
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);			
		end		
		self.nBatAutoFight = 0;
	end
	if self.nTrainDcChua == 0 then
	if (GetTime() - self.TimeStartFollow > 1) and (self.nVuaSua == 1) then
		UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);	
		self.nVuaSua = 0;
	end
	if (GetTime() - self.TimeStartFollow > self.MaxTimeRepairItem) and ( self.nRepairItemState == 1 ) then
		self:RepairItemAll();
		self:RepairItemAll();
		if (UiManager:WindowVisible(Ui.UI_PLAYERPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_PLAYERPANEL);
		end
		self.TimeStartFollow = GetTime();
		self.nVuaSua		 = 1;		
	end
	if self.bAutoEat == 1 and ((me.nCurLife*100/me.nMaxLife < self.EatFood) or (me.nCurMana*100/me.nMaxMana < self.EatFood)) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then
			local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				if 0 == AutoAi.Eat(4) then
					print("AutoAi- No Food...");
				end
			end
		end
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if self.nFollowState == 0 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		return 0;
	end
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nMMap = nMyMap
	self.nMyPosX = nMyX / 8;
	self.nMyPosY = nMyY / 16;
	local tbMember = me.GetTeamMemberInfo();
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].szName == self.nszName then
			self.nPMap = tbMember[i].nMapId;
		end
	end
	if self.nMMap == 344 then
		self.nPMap = 344;
	elseif self.nMMap == 273 then
		self.nPMap = 273;
	elseif self.nMMap == 287 then
		self.nPMap = 287;
	elseif self.nMMap == 254 then
		self.nPMap = 254;
	elseif self.nMMap == 272 then
		self.nPMap = 272;
	elseif self.nMMap == 557 then
		self.nPMap = 557;
	elseif self.nMMap == 560 then
		self.nPMap = 560;
	elseif self.nMMap == 493 then
		self.nPMap = 493;
	end
	if self.nPType == 2 then
		self:FLFight();
	elseif self.nPMap == self.nMMap then
		self:FLFight();
	else
		if self.nPMap == 90 then
			self.PlayX = "1900";
			self.PlayY = "3900";
		elseif self.nPMap == 97 and self.nMMap ~=90 then
			self.PlayX = "1920";
			self.PlayY = "3620";
		else
			self.PlayX = "1500";
			self.PlayY = "3000";
		end
		self:GotoPmap(self.PlayX,self.PlayY);
	end
	else
		if self.nFollowState == 0 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			return 0;
		end
		self:FLFight();
	end
end

function tbAutoAim:GotoPmap(PlayX,PlayY)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local sznMap = GetMapNameFormId(self.nPMap)
	me.Msg("<color=green>Bản đồ: <color=Blue>["..sznMap.."] - Theo sau: <color=Yellow>"..self.nszName.."")
	local nPlayPosInfo ={}
	nPlayPosInfo.szType = "pos"
	nPlayPosInfo.szLink = sznMap..","..self.nPMap..","..PlayX..","..PlayY;
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,nPlayPosInfo);
	me.Msg(nPlayPosInfo.szLink)
end
function tbAutoAim:FLFight()
	local bChecked = me.GetNpc().IsRideHorse();
	if self.nTrainDcChua == 0 then
	if self.nPType == 2 then
		me.Msg("<color=green>Theo sau: <color=yellow>"..self.nszName.."<color>")
		me.Msg(self.nFollowState)
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.szName == self.nszName) then
				local _, nNpcX, nNpcY	= pNpc.GetWorldPos();
				self.nPosX = nNpcX/8;
				self.nPosY = nNpcY/16;
			end
		end
	else
		local tbNpc = SyncNpcInfo();	
		if tbNpc then
			for _, tbNpcInfo in ipairs(tbNpc) do
				if tbNpcInfo.szName == self.nszName then
					self.nPosX = tbNpcInfo.nX/16;
					self.nPosY = tbNpcInfo.nY/16;
				end
			end
		end
	end
	else
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		if (nMapId == self.MapidTrain) and (nCurWorldPosX == self.PosXTrain) and (nCurWorldPosY == self.PosYTrain) then
			
 if (me.nAutoFightState ~= 1 and me.nFightState == 1 and me.IsDead() == 0) then
     AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				end	
				self.nBatAutoFight = 1;
		elseif (self.nBatAutoFight == 0) then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = ","..self.MapidTrain..","..self.PosXTrain..","..self.PosYTrain
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);			
		end
		end
	end
	if (self.nTrainDcChua == 0) then
	local TargetDis = math.sqrt((self.nMyPosX-self.nPosX)^2 + (self.nMyPosY-self.nPosY)^2);
		if (TargetDis < self.nRange) then
			if (self.OldPosX ~= self.nPosX) or (self.OldPosY ~= self.nPosY) then
				self.OldTime = GetTime();
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime1 < GetTime()) and (self.nOnOffTrainAfk == 1) then
			end
			if (self.OldPosX == self.nPosX) and (self.OldPosY == self.nPosY) and (self.OldTime + self.MaxOldTime < GetTime()) and (self.nOnOffTrainAfk == 1) then
				self.nTrainDcChua = 1;
			else
			self.OldPosX = self.nPosX;
			self.OldPosY = self.nPosY;
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then
				if self.DelayStat == 0 then
					UseSkill(98,GetCursorPos());
					self:MyDelay(self.EMHealDelay);
				else
					return;
				end
			else
				if (self:IsDangerous() == 1) then
					me.Msg("Nguy hiểm có địch!");
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				else
					local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
					if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
						Switch("horse");
					end
 if (me.nAutoFightState ~= 1 and me.nFightState == 1 and me.IsDead() == 0) then
     AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());

					end
				end
			end
			end
		else			
			if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and self.nAttackMonsterState ~= 1) then
				if (me.nAutoFightState == 1) then
					AutoAi.ProcessHandCommand("auto_fight", 0);
					AutoAi.SetTargetIndex(0);
				end
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				if (TargetDis > self.nRideRange and bChecked ~= 1) then					
					Switch([[horse]])					
				end
				self:StopFight();
			end
		end
	end
end

function tbAutoAim:StopFight()
	if (self.nMMap < 298 or self.nMMap > 332) or self.nPType == 2 then
		if (me.nAutoFightState == 1) then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			AutoAi.SetTargetIndex(0);
		end
		me.AutoPath(self.nPosX*8, self.nPosY*16);
	else
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 10);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind == 0) then
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("Tọa độ: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			else
				me.Msg("");
				AutoAi.ProcessHandCommand("auto_fight", 0);
				AutoAi.SetTargetIndex(0);
				local nX = math.floor(self.nPosX);
				local nY = math.floor(self.nPosY);
				me.Msg("Tọa độ: <color=Blue>"..nX.."/"..nY.."<color>");
				me.AutoPath(self.nPosX*8, self.nPosY*16);
			end
		end
	end
end
function tbAutoAim:IsDangerous()
	local isDangerous = 0;
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 40);
	for _, pNpc in ipairs(tbAroundNpc) do		
		local id = pNpc.nTemplateId;
		if (id == 3146 or id == 3149 or id == 3152 or id == 3157 or id == 3177 or id == 3193 or id == 3277 ) then
			isDangerous = 1;
			break;
		end
	end
	return isDangerous;
end
function tbAutoAim:MyDelay(DelayTime)
	self.nTest = 0;
	self.nDtime = DelayTime;
	self.DelayStat = 1;
	local DelayStart = tbTimer:Register(0.2 * Env.GAME_FPS, self.DelayClock, self);
end
function tbAutoAim:DelayClock()
	local nDelay = self.nDtime*5;
	self.nTest = self.nTest + 1;
	if self.nTest >= nDelay+5 then
		self.DelayStat = 0;
		return 0;
	end
end

tbAutoAim:Init();
