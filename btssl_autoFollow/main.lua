--cyberdemon--
Ui.UI_AUTOAIM_UI		= "UI_AUTOAIM_UI";
local uiAutoAimUi		= Ui.tbWnd[Ui.UI_AUTOAIM_UI] or {};
uiAutoAimUi.UIGROUP		= Ui.UI_AUTOAIM_UI;
Ui.tbWnd[Ui.UI_AUTOAIM_UI] 	= uiAutoAimUi;

local KeyDefCfg = {
		[1] 	= {name="Theo Sau Hộ Tống", key="Ctrl+Q"},
		}

function uiAutoAimUi:Init()
	self.HealDelay = 0.5;
	self:LoadSetting();
	self:LoadKeyData();
	self:KeyUpDate();
	self:UpdateAimCfg();
end

function uiAutoAimUi:LoadKeyData()
	self.KEY_CFG	= {};
	local szKey		= KFile.ReadTxtFile(self.UserFile);
	if (not szKey) then
		for i=1,#KeyDefCfg do
			self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
		end
	else
		local tbMyKeyData	= Lib:Str2Val(szKey);
		for k, v in pairs(tbMyKeyData) do
			self.KEY_CFG[k] = {name=tbMyKeyData[k].nName,key=tbMyKeyData[k].nKey};
		end
	end
end

function uiAutoAimUi:SaveKeyData()
	self.tbUserKeyData ={}
	for i = 1,#KeyDefCfg do
		self.tbUserKeyData[i] = {nName=self.KEY_CFG[i].name,nKey=self.KEY_CFG[i].key};	
	end
	local szKey	= Lib:Val2Str(self.tbUserKeyData);
	KFile.WriteFile(self.UserFile, szKey);
end

function uiAutoAimUi:LoadKeyDefault()
	for i = 1,#KeyDefCfg do
		self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
	end
	self:SaveKeyData()
end

function uiAutoAimUi:SaveUserData()
	local LocalFile = GetPlayerPrivatePath().."aimset.dat";
	self.YaoDelay = Edt_GetTxt(self.UIGROUP, self.TXT_YAODELAY);
	self.LifeRet = Edt_GetTxt(self.UIGROUP, self.TXT_LIFE);
	self.ManaRet = Edt_GetTxt(self.UIGROUP, self.TXT_MANA);
	self.HealDelay = Edt_GetTxt(self.UIGROUP, self.TXT_HEALDELAY);
	self.tbAutoAimSetting = {nYaoDelay=self.YaoDelay, nLifeRet=self.LifeRet, nManaRet=self.ManaRet, nHealDelay=self.HealDelay, nAutoEat=self.AutoEat,}
	local szKey	= Lib:Val2Str(self.tbAutoAimSetting);
	KFile.WriteFile(LocalFile, szKey);
end

function uiAutoAimUi:LoadSetting()
	local LocalFile = GetPlayerPrivatePath().."aimset.dat";
	local szSet = KFile.ReadTxtFile(LocalFile);
	if (szSet) then
		local UserSetting = Lib:Str2Val(szSet);
		
		if UserSetting.nYaoDelay then
			self.YaoDelay = UserSetting.nYaoDelay;
		end
		if UserSetting.nLifeRet then
			self.LifeRet = UserSetting.nLifeRet;
		end
		if UserSetting.nManaRet then
			self.ManaRet = UserSetting.nManaRet;
		end
		
		if UserSetting.nHealDelay then
			self.HealDelay = UserSetting.nHealDelay;
		end
		if UserSetting.nAutoEat then
			self.AutoEat = UserSetting.nAutoEat;
		end
	end
end

uiAutoAimUi.UpdateAimCfg = function(self)
	local AimCfg =
	{
		nYaoDelay	= self.YaoDelay,
		nLifeRet	= self.LifeRet,
		nManaRet	= self.ManaRet,
		nHealDelay	= self.HealDelay,
		nAutoEat	= self.AutoEat,
	};
	Map.tbAutoAim:UpdateSetting(AimCfg)
end

function uiAutoAimUi:OnOpen()
	PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_ONE);
	self:LoadSetting();
	self:UpdateWnd();
end

uiAutoAimUi.OnScorllbarPosChanged = function(self, szWnd, nParam)
	if szWnd == self.SCROLL_DELAY then
		self.YaoDelay = nParam / 2 + 0.5;
	elseif szWnd == self.SCROLL_LIFE then
		self.LifeRet = nParam * 5;
	elseif szWnd == self.SCROLL_MANA then
		self.ManaRet = nParam * 5;
	end
	self:UpdateWnd();
end

function uiAutoAimUi:UpdateWnd()
	if Map.tbAutoAim.nfireState == 1 then
		local szText	= "<color=red>Fire in the ...<color>";
		Txt_SetTxt(self.UIGROUP, self.TXT_FIRE, szText);
	else
		local szText	= " ";
		Txt_SetTxt(self.UIGROUP, self.TXT_FIRE, szText);
	end

	if Map.tbAutoAim.nFollowState == 1 then
		if Map.tbAutoAim.nszName then
			local szText	= Map.tbAutoAim.nszName;
			Txt_SetTxt(self.UIGROUP, self.TXT_FOLLOW, szText);		
		end
	end

	local tbMember = me.GetTeamMemberInfo();	
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].nPlayerID then
			local szBuf = tbMember[i].szName;
			local szFaction = Player:GetFactionRouteName(tbMember[i].nFaction);
			local szMap = GetMapNameFormId(tbMember[i].nMapId)
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 0, szBuf);
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 1, szFaction);
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 2, szMap);
			Lst_SetLineData(self.UIGROUP, self.TEAM_MEMBER_LIST, i, tbMember[i].nPlayerID);
		end			
	end

	Edt_SetTxt(self.UIGROUP, self.TXT_HEALDELAY, self.HealDelay);

	for i = 1,#KeyDefCfg do 
		local szText1 = "<color=130,130,240>"..self.KEY_CFG[i].name.."<color>";
		local szText2 = "<color=130,130,220>"..self.KEY_CFG[i].key.."<color>";
		Txt_SetTxt(self.UIGROUP, self.TXT1_KEY[i], szText1);
		Txt_SetTxt(self.UIGROUP, self.TXT2_KEY[i], szText2);
		Edt_SetTxt(self.UIGROUP, self.KEY_CFGSET[i], self.KEY_CFG[i].key);
	end

	self:UpdateAimCfg();
end


function uiAutoAimUi:UpdateFollow(nIndex)
	local szName = Lst_GetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex, 0);
	local nItemData = Lst_GetLineData(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex);
	Map.tbAutoAim:FollowData(szName,nItemData)
end

function uiAutoAimUi:KeyLoad()
	for i=1,#KeyDefCfg do
		local nMsg = Edt_GetTxt(self.UIGROUP, self.KEY_CFGSET[i]);
		self.KEY_CFG[i].key = nMsg;
	end
	self:SaveKeyData()
end

function uiAutoAimUi:KeyUpDate()
	local tCmd = { "Map.tbAutoAim:AutoFollow();", "AutoFollow", "", self.KEY_CFG[1].key, self.KEY_CFG[1].key, "AutoFollow" };
	AddCommand(self.KEY_CFG[1].key, self.KEY_CFG[1].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
end

uiAutoAimUi:Init();
LoadUiGroup(Ui.UI_AUTOAIM_UI, "autoFollow.ini");
