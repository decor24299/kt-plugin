local szLastModify	= "2010/3/8 15:44:01";
local tbSuperMapLink	= Map.tbSuperMapLink or {};
Map.tbSuperMapLink		= tbSuperMapLink;
local self = tbSuperMapLink;

local tbAutoPath		= Ui.tbLogic.tbAutoPath;

tbSuperMapLink.STR_LASTMODIFY	= szLastModify;

tbSuperMapLink.tbUserData	= tbSuperMapLink.tbUserData or {	
	bUseTalk		= 1,
	nUiSelect		= 1,
	bAutoCloseWnd		= 1,
	bHorseLock		= 1,
};

_KLuaPlayer.AutoPath		= _KLuaPlayer.AutoPath or _KLuaPlayer.StartAutoPath;	

tbAutoPath.tbname		= nil;
local nmoveTimerId2		= 0;


function tbSuperMapLink:LoadMapData()
	local tbAllMapInfo	= {};	
	self.tbAllMapInfo	= tbAllMapInfo;
	local tbFileData	= Lib:LoadTabFile("\\setting\\map\\maplist.txt");
	local nAllCount		= 0;
	for nRowNum, tbRow in ipairs(tbFileData) do
		if (nRowNum > 1) then	
			local nMapId	= tonumber(tbRow.TemplateId);
			tbAllMapInfo[nMapId]	= {
				nMapId		= nMapId,
				szMapName	= tbRow.MapName,
				szInfoFile	= tbRow.InfoFile,
				szMapType	= tbRow.MapType,
				nMapLevel	= tonumber(tbRow.MapLevel),
			};
			nAllCount	= nAllCount + 1;
		end
	end
	self:OutF("%d map loaded!", nAllCount);
end


function tbSuperMapLink:ModifyUi()
	
	local uiTaskPanel 	= Ui(Ui.UI_TASKPANEL);
	tbSuperMapLink._task_linkclick_bak	= tbSuperMapLink._task_linkclick_bak or uiTaskPanel.OnLinkClick;
	function uiTaskPanel:OnLinkClick(...)
		tbSuperMapLink.szLastClickUiGroup	= self.UIGROUP;
		tbSuperMapLink._task_linkclick_bak(self, ...);
	end


	tbSuperMapLink.OnLinkClicki_bak	= tbSuperMapLink.OnLinkClicki_bak or UiManager.OnLinkClick;
	function UiManager:OnLinkClick(szUiGroup, szWnd, szLink)
		tbSuperMapLink.szLastClickUiGroup	= szUiGroup;
		tbSuperMapLink.OnLinkClicki_bak(UiManager, szUiGroup, szWnd, szLink);
	end
	local function fnModifyLinkFunc(szType)
		local tbLink	= UiManager.tbLinkClass[szType];
		function tbLink:OnClick(szLink)
			tbSuperMapLink:StartGoto({szType = szType, szLink = szLink});
		end
	end
	fnModifyLinkFunc("npcpos");


	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	tbSuperMapLink.Say_bak	= tbSuperMapLink.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbSuperMapLink.Say_bak(uiSayPanel, tbParam);
	
		local function fnOnSay()
			tbSuperMapLink:OnSay(tbParam);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end


	tbSuperMapLink.EnterGame_bak	= tbSuperMapLink.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbSuperMapLink.EnterGame_bak(Ui);
		tbSuperMapLink:LoadUserData();
	end


	if (not self.bSceneAotoPathReged) then
		local function fnOnStartAotoPath(self)
			self:OnStartAotoPath();
		end
		UiNotify:RegistNotify(UiNotify.emCOREEVENT_START_AUTOPATH, fnOnStartAotoPath, self);
		self.bSceneAotoPathReged	= 1;
	end
end


function tbSuperMapLink:Init()
	self:LoadMapData();
	self:ModifyUi();
end


function tbSuperMapLink:OutF(...)
	print("[SuperMapLink]", string.format(unpack(arg)));
end


function tbSuperMapLink:StartGoto(tbPosInfo)
	if (self.szLastClickUiGroup and self.tbUserData.bAutoCloseWnd == 1) then	
		UiManager:CloseWindow(self.szLastClickUiGroup);
	end
	local nLastClickFrame	= self.nLastClickFrame or 0;
	local nNowFrame			= GetFrame();
	if (nNowFrame < nLastClickFrame + Env.GAME_FPS) then	
		UiManager:CloseWindow(self.szLastClickUiGroup);
		return;
	end
	self:AutoHorse()
	self.nLastClickFrame	= nNowFrame;

	local tbSplit		= Lib:SplitStr(tbPosInfo.szLink, ",");
	local tbLink	= {
		szDesc		= tbSplit[1],
		varMap		= tbSplit[2],
	};
	local tbAutoAns;
	if (tbPosInfo.szType == "pos") then		
		tbLink.nX	= tonumber(tbSplit[3]);
		tbLink.nY	= tonumber(tbSplit[4]);
		if (tbSplit[5]) then	
			tbAutoAns	= {unpack(tbSplit, 5)};
		end
	elseif (tbPosInfo.szType == "npcpos") then	
		tbLink.nNpcId	= tonumber(tbSplit[3]);
		if (tbLink.szDesc == "" and tbLink.nNpcId > 0) then
			tbLink.szDesc	= KNpc.GetNameByTemplateId(tbLink.nNpcId);
		end
		if (tbSplit[4]) then	
			tbAutoAns	= {unpack(tbSplit, 4)};	
		end
	end
	tbAutoPath:OnLinkClick(tbLink, tbAutoPath.CBNpc, tbAutoPath, tbLink.nNpcId or tbLink.szDesc, tbAutoAns);
end


function tbSuperMapLink:OnStartAotoPath()
	if (me.GetNpc().nIsRideHorse ~= 1 and self.tbUserData.bHorseLock == 1 and me.GetEquip(Item.EQUIPPOS_HORSE)) then
		-- Switch("horse");
		self:OutF("trying ridehorse...");
	end
end
function tbSuperMapLink:AutoHorse()
	if (me.GetNpc().nIsRideHorse ~= 1 and self.tbUserData.bHorseLock == 1 and me.GetEquip(Item.EQUIPPOS_HORSE)) then
		me.Msg("<color=gold>Đua nào")
		Switch("horse");
		self:OutF("trying ridehorse...");
	end
end

function tbSuperMapLink:CalcGoPos(tbMyPos, tbToPos)
	local tbMapRoute, nDistance, bNeedTrans	= tbAutoPath:CalcPosToPos(tbMyPos, tbToPos);
	local tbGoPos	= (tbMapRoute or {})[1];
	if (bNeedTrans == 1 and tbGoPos) then
		tbGoPos	= self.tbAllBaseMap[tbGoPos.nMapId];
	end
	if (not tbGoPos) then
		return nil, nil, -1, 1;	
	end
	return tbGoPos, tbMapRoute, nDistance, bNeedTrans;
end

function tbAutoPath:GoNextStep()
	local tbMyPos	= self:GetMyPos();
	local tbMapRoute, nDistance, bNeedTrans	= tbAutoPath:CalcPosToPos(tbMyPos, self.tbGotoPos);
	local tbGoPos	= (tbMapRoute or {})[1];
	if (bNeedTrans == 1 and tbGoPos) then
		tbGoPos	= self.tbAllBaseMap[tbGoPos.nMapId];
	end
	self:OutF("GoNextStep: %s rest:%d trans:%s", self:GetPosStr(tbGoPos), nDistance, bNeedTrans);
	if (not tbGoPos) then
		
		self:StopGoto("Failed");
		return;
	end
	
	self.nWaitingTrans	= 0;
	self:CloseTimer();
	self.tbCurGoPos	= tbGoPos;
	if (bNeedTrans == 1) then	
		self:UseTrans(tbGoPos.nMapId);
	elseif (nDistance <= 0) then	
		self:StartTimer("OnFinished", 1);	
	elseif (me.StartAutoPath(tbGoPos.nX, tbGoPos.nY) ~= 1) then	
		self:OutF("StartAutoPath failed! %s => %s", self:GetPosStr(tbMyPos), self:GetPosStr(tbGoPos));
		
		self:StopGoto("Failed");
	end
	if (tbSuperMapLink.tbUserData.bUseTalk == 1) then
		if self.tbname ~= nil then
			local szDesc = self.tbname;
			if not(szDesc == "ÉÌ»áÀÏ°å" or szDesc == "ÏÄºîÔªèº" or szDesc == "Ò±Á¶´óÊ¦") then
				local szMsg = self:GetRouteMapName(tbMapRoute, szDesc);
				--SendChannelMsg("Team", string.format("Đi %s bắt đầu<pic=28>", szMsg));
			end
		end
	end
	self.tbname	= nil;
end


function tbAutoPath:ParseLink(tbLink)
	local tbPos	= {
		nMapId	= tbLink.nMapId,
		nX		= tbLink.nX,
		nY		= tbLink.nY,
	};
	
	if (not tbPos.nMapId) then
		tbPos.nMapId	= self:GetMapId(tbLink.varMap);
	end
	
	if (not tbPos.nX) then
		local nMapId	= (tbPos.nMapId > 0 and tbPos.nMapId) or me.GetMapTemplateId();
		local nX, nY	= KNpc.ClientGetNpcPos(nMapId, tbLink.nNpcId or 0);
		if (nX > 0 and nY > 0) then	
			tbPos.nMapId	= nMapId;
			tbPos.nX		= nX;
			tbPos.nY		= nY;
		end
	end
	if (tbPos.nMapId <= 0) then
		self:OutF("UnkownMap:%s", tbLink.varMap or "nil");
		return nil, "Ðè×ÔÐÐÇ°ÍùÌØ¶¨µØÍ¼¡£";
	end
	self.tbname	=  tbLink.szDesc;
	return tbPos, tbLink.szDesc;
end

function tbAutoPath:CBNpc(varNpc, tbAutoAns)
	local self	= tbSuperMapLink;
	self:OutF("CBNpc(%s,%s)", varNpc, tostring(tbAutoAns));

	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 80);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == varNpc or pNpc.szName == varNpc) then	
			self:OutF("find npc: %s(%d)", pNpc.szName, pNpc.nKind);
			if (pNpc.nKind == 0) then	
				self:AutoFight(1);
			elseif (tbAutoAns) then
				tbAutoAns.nStartTime	= GetTime();
				self.tbAutoAns	= tbAutoAns;
			end
			AutoAi.SetTargetIndex(pNpc.nIndex);
			return;
		end
	end
	self:OutF("can not find npc: %s", tostring(varNpc));
end

function tbAutoPath:UseTrans(nMapId,bSure)
	if (bSure ~= 1 and self.nTransferMsg == 1) then
		tbAutoPath:UseTrans(nMapId, 1);
		return;
	end
	me.CallServerScript({"UseUnlimitedTrans", nMapId});
	self.nWaitingTrans        = 1;
	self:StartTimer("OnTimer_TransTimeOut", Env.GAME_FPS * 8);
end


function tbAutoPath:OnFinished()
	me.Msg("Đã đến");
	local tbCallBack	= self.tbCallBack;
	self:StopGoto("Finish");
	if (tbCallBack and tbCallBack[1]) then
		Lib:CallBack(tbCallBack);
	end
end


function tbSuperMapLink:OnSay(tbParam)
	local tbAutoAns	= self.tbAutoAns;
	if (not tbAutoAns) then
		return;
	end
	local nStartTime	= tbAutoAns.nStartTime;
	if (GetTime() - nStartTime > 3) then	
		return;
	end
	local nAnsIndex	= tonumber(tbAutoAns[1]);
	if (not nAnsIndex) then
		nAnsIndex	= 0;
		for i, szAns in ipairs(tbParam[2]) do
			if (szAns == tbAutoAns[1]) then
				nAnsIndex	= i;
				break;
			end
		end
	end
	self:OutF("AutoAns %d,%s", nAnsIndex, tbParam[2][nAnsIndex] or "nil");
	if (tbParam[2][nAnsIndex]) then
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nAnsIndex);
	end
	if (tbAutoAns[2]) then	
		self.tbAutoAns	= {nStartTime = nStartTime; unpack(tbAutoAns, 2)};
	else
		self.tbAutoAns	= nil;
	end
end


function tbSuperMapLink:LoadUserData()
	self.szUserFilePath	= GetPlayerPrivatePath().."supermaplink.dat";
	local szData		= KFile.ReadTxtFile(self.szUserFilePath);
	if (not szData) then
		return;
	end

	local tbMyData	= Lib:Str2Val(szData);
	for k, v in pairs(tbMyData) do
		self.tbUserData[k]	= v;
	end
end


function tbSuperMapLink:SaveUserData()
	local szData	= Lib:Val2Str(self.tbUserData);
	KFile.WriteFile(self.szUserFilePath, szData);
end


function tbSuperMapLink:SwitchTalk()
	local bUseTalk	= 1 - (self.tbUserData.bUseTalk or 0);
	self.tbUserData.bUseTalk	= bUseTalk;
	if (bUseTalk == 1) then
		me.Msg("Mở Tự động tìm đường");
	else
		me.Msg("Đóng Tự Động tìm đường");
	end
	self:SaveUserData();
end

function tbSuperMapLink:SwitchAutoCloseWnd()
	local bAutoCloseWnd	= 1 - (self.tbUserData.bAutoCloseWnd or 0);
	self.tbUserData.bAutoCloseWnd	= bAutoCloseWnd;
	if (bAutoCloseWnd == 1) then
		me.Msg("Mở tự động đóng cửa sổ");
	else
		me.Msg("Đóng tự động đóng cửa sổ");
	end
	self:SaveUserData();
end

function tbSuperMapLink:nSwitch()
	local bHorseLock	= 1 - (self.tbUserData.bHorseLock or 0);
	self.tbUserData.bHorseLock	= bHorseLock;
	if (bHorseLock == 1) then
		me.Msg("Mở tự lên ngựa");
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>¡ùÎÞºÛ¡ùÌáÊ¾:¿ªÆôÑ°Â·×Ô¶¯ÉÏÂí<color>");
	else
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>¡ùÎÞºÛ¡ùÌáÊ¾:¹Ø±ÕÑ°Â·×Ô¶¯ÉÏÂí<color>");
		me.Msg("Đóng tự lên ngựa");
	end
end


function tbSuperMapLink:AutoFight(nAutoFight)
	local tbAutoFightData	= Ui.tbLogic.tbAutoFightData;
	tbAutoFightData:Load();
	if (tbAutoFightData.LoadData.nAutoFight	~= nAutoFight) then	
		tbAutoFightData.LoadData.nAutoFight	= nAutoFight;
		AutoAi:UpdateCfg(tbAutoFightData.LoadData);
	end
	if (nAutoFight == 1) then
		local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	
			Switch("horse");	
		end
	else
		AutoAi.SetTargetIndex(0);	
	end
end


function tbSuperMapLink:move(x,y)
	local njlX=0
	local njlY=0
	local nltimes=0
	local nli=0
	local _,myx, myy = me.GetWorldPos();
	njlX=x - myx
	njlY=y - myy
	if njlX==0 and njlY==0 then
		return
	end
	nltimes=1
	if nmoveTimerId2>0 then
		Ui.tbLogic.tbTimer:Close(nmoveTimerId2);
	end
	local function movetime2()
		local ax,ay=0,0
		if math.abs(njlX)<math.abs(njlY) then
			nli=math.abs(njlX)/math.abs(njlY)
			if njlX<0 then
				ax=math.floor((myx-nli*nltimes)*32)
			else
				ax=math.floor((myx+nli*nltimes)*32)
			end
			if njlY<0 then
				ay=(myy-nltimes)*32
			else
				ay=(myy+nltimes)*32
			end
			AutoAi.AiAutoMoveTo(ax,ay)			
			if nltimes==math.abs(njlY) then
				return 0
			end
		else
			nli=math.abs(njlY)/math.abs(njlX)
			if njlX<0 then
				ax=(myx-nltimes)*32
			else
				ax=(myx+nltimes)*32
			end
			if njlY<0 then
				ay=math.floor((myy-nli*nltimes)*32)
			else
				ay=math.floor((myy+nli*nltimes)*32)
			end
			AutoAi.AiAutoMoveTo(ax,ay)			
			if nltimes==math.abs(njlX) then
				return 0
			end
		end
		nltimes=nltimes+1
	end
	nmoveTimerId2 = Ui.tbLogic.tbTimer:Register(3,movetime2);
end
function tbSuperMapLink:CloseGo()
	if nmoveTimerId2>0 then
		Ui.tbLogic.tbTimer:Close(nmoveTimerId2);
	end
end


function tbSuperMapLink:Reload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, "@" .. szFilePath))();
	end
	fnDoScript("\\ui\\script\\logic\\autopath.lua");
	me.Msg("SML Reloaded!! " .. GetLocalDate("%Y%m%d %H:%M:%S"));
end

tbSuperMapLink:Init();

--------------------Trả - Nhận NV Nhanh--------------------

function tbSuperMapLink:CloseDBWindow()
       local uiGutAward = Ui(Ui.UI_GUTAWARD);
       if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
               uiGutAward:OnButtonClick("zBtnAccept");
               Ui.tbLogic.tbTimer:Close(nRoseTimerId);
       end 
end

--------------------NPC--------------------
function tbSuperMapLink:HieuThuoc() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3564"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3564"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:TapHoa() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3565"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3565"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:TuuLau() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3566"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3566"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:DaLuyenDaiSu() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3574"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3574"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:ThuKho() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2599"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,2599"});
	  end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:XaPhu() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2597"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,2597"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------
function tbSuperMapLink:ChieuMoSuTong() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2607"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,2607"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:ChieuMoSuKim() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2608"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",27,2608"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------
function tbSuperMapLink:BachHoDuong() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2654"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",28,2654"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------
function tbSuperMapLink:LienDauSo() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3384"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",28,3384"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:LienDauCao() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3385"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",27,3385"});
	end
	    nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------
function tbSuperMapLink:BoDauHinhBo() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2994"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",26,2994"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:TieuDaoCoc1() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,1"});
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:TieuDaoCoc() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,2"});
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:BaoThach() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7396"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,7396"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:ThuongHoi() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2965"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",28,2965,"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:VAGT() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2955,1,1"});
		Map.tbAutoQuanDoanh:AutoPick()
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,2955,1,1"});
		Map.tbAutoQuanDoanh:AutoPick()
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:LeQuan() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2601"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",26,2601"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------

-----------------------===============================================================-----------------------
function tbSuperMapLink:ThanhLong() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <26 and nMyMapId >23) or (nMyMapId <30 and nMyMapId >28) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4037,1"});
	else
		me.CallServerScript({"UseUnlimitedTrans", 29}); --LamAn
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4037,1"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
-----------------------===============================================================-----------------------
function tbSuperMapLink:TanLang() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
         end
    end
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,2441,1"});
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

--////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
function tbSuperMapLink:QuanLanhTho() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,3406"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:BaoVanDong() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3573"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3573"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:MaXuyenSon() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2955"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",25,2955"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:HiepKhach() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7346"});
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:TienTrang() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3567"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3567"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:SuGiaHoatDong() 
    if (me.IsDead() == 1) then
        me.SendClientCmdRevive(0);
        if me.nAutoFightState == 1 then
            AutoAi.ProcessHandCommand("auto_fight", 0);
            Ui(Ui.UI_SYSTEM):UpdateOnlineState();
        end
    end
	local nMyMapId	= me.GetMapTemplateId();
	if nMyMapId <9 and nMyMapId >0 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3601"});
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3601"});
	end
		nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

--////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function tbSuperMapLink:Reload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\supermaplink\\supermaplink.lua");
	me.Msg("<bclr=0,0,200><color=white>SuperMapLink Main Reload xong " .. GetLocalDate("%H:%M %d/%m/%Y"))
	fnDoScript("\\interface2\\supermaplink\\maplink_ui.lua");
	me.Msg("<bclr=0,0,200><color=white>SuperMapLink_Ui Reload xong " .. GetLocalDate("%H:%M %d/%m/%Y"))
end

tbSuperMapLink:Init();
Map.tbanbingmove={};
local tbanbingmove=Map.tbanbingmove

function tbanbingmove:Init()
	self.nmoveTimerId2=0;
end

function tbanbingmove:CloseGo()
	if self.nmoveTimerId2>0 then
		Ui.tbLogic.tbTimer:Close(self.nmoveTimerId2);
	end
end


function tbanbingmove:move(x,y)
	local njlX=0
	local njlY=0
	local nltimes=0
	local nli=0
	local _,myx, myy = me.GetWorldPos();

	njlX=x - myx
	njlY=y - myy

	if njlX==0 and njlY==0 then
		return
	end

	nltimes=1

	if self.nmoveTimerId2>0 then
		Ui.tbLogic.tbTimer:Close(self.nmoveTimerId2);
	end

	local function movetime2()
		if (me.nTemplateMapId == 1536 or (me.nTemplateMapId == 560 and myy > 3100)) and me.nFightState == 1 then --皇陵1和百蛮安全区附近不能寻路
			Ui.tbLogic.tbTimer:Close(self.nmoveTimerId2);
			return 0
		end
		local ax,ay=0,0
		if math.abs(njlX)<math.abs(njlY) then
			nli=math.abs(njlX)/math.abs(njlY)
			if njlX<0 then
				ax=math.floor((myx-nli*nltimes)*32)
			else
				ax=math.floor((myx+nli*nltimes)*32)
			end

			if njlY<0 then
				ay=(myy-nltimes)*32
			else
				ay=(myy+nltimes)*32
			end

			AutoAi.AiAutoMoveTo(ax,ay)			
			if nltimes==math.abs(njlY) then
				return 0
			end
		else
			nli=math.abs(njlY)/math.abs(njlX)

			if njlX<0 then
				ax=(myx-nltimes)*32
			else
				ax=(myx+nltimes)*32
			end

			if njlY<0 then
				ay=math.floor((myy-nli*nltimes)*32)
			else
				ay=math.floor((myy+nli*nltimes)*32)
			end

			AutoAi.AiAutoMoveTo(ax,ay)			

			if nltimes==math.abs(njlX) then
				return 0
			end
		end

		nltimes=nltimes+1
	end
	self.nmoveTimerId2 = Ui.tbLogic.tbTimer:Register(3,movetime2);
end

tbanbingmove:Init()