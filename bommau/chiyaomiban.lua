
Ui.UI_AUTOAIM		= "UI_AUTOAIM";
local uiAutoAim		= Ui.tbWnd[Ui.UI_AUTOAIM] or {};	
uiAutoAim.UIGROUP		= Ui.UI_AUTOAIM;
Ui.tbWnd[Ui.UI_AUTOAIM] 	= uiAutoAim;

local tbSaveData 	= Ui.tbLogic.tbSaveData;
local tbAutoAim 	= Ui.tbLogic.tbAutoAimtData;
uiAutoAim.DATA_KEY	= "AutoAim";

uiAutoAim.BTN_CLOSE1	= "BtnClose1";
uiAutoAim.PAGESET_MAIN	= "PageSetMain";
uiAutoAim.PAGE_ONE		= "PageOne";
uiAutoAim.BTN_SAVE		= "BtnSaveData";

uiAutoAim.BTN_AUTOYAO	= "BtnAutoYao";
uiAutoAim.TXT_DELAY		= "TxtDelay";	
uiAutoAim.TXT_LIFE		= "TxtLife";	
uiAutoAim.TXT_MANA		= "TxtMana";	
uiAutoAim.SCROLL_DELAY	= "ScrbarDelay";
uiAutoAim.SCROLL_LIFE	= "ScrbarLife";
uiAutoAim.SCROLL_MANA	= "ScrbarMana";
local self = uiAutoAim


function uiAutoAim:Init()
	self.AutoYao = 0;
	self.YaoDelay = 0.3;
	self.LifeRet = 80;
	self.ManaRet = 5;
end

function uiAutoAim:SaveData()
	self.tbAutoAimSetting = {nYaoDelay = self.YaoDelay, nLifeRet = self.LifeRet, nManaRet = self.ManaRet, } 
	self:Save(self.DATA_KEY, self.tbAutoAimSetting);
end

function uiAutoAim:Save(szKey, tbData)
	self.m_szFilePath="\\user\\dungthuoc\\"..me.szName..".dat";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	--print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KFile.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function uiAutoAim:Load(key)
	self.m_szFilePath="\\user\\dungthuoc\\"..me.szName..".dat";
	self.m_tbData = {};
	--print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then		
			self.m_tbData = Lib:Str2Val(szData);
		else
			KFile.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	--print(self.m_tbData);
	return tbData;
end

function uiAutoAim:CheckErrorData(szDate)
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

function uiAutoAim:LoadSetting()
	local tbAutoAimSetting = self:Load(self.DATA_KEY) or {};

	if tbAutoAimSetting.nYaoDelay then
		self.YaoDelay = tbAutoAimSetting.nYaoDelay;
	end
	if tbAutoAimSetting.nLifeRet then
		self.LifeRet = tbAutoAimSetting.nLifeRet;
	end
	if tbAutoAimSetting.nManaRet then
		self.ManaRet = tbAutoAimSetting.nManaRet;
	end

	tbAutoAimSetting = { nYaoDelay = self.YaoDelay, nLifeRet = self.LifeRet, nManaRet = self.ManaRet, }
	Lib:ShowTB(tbAutoAimSetting);
	
	if self.tbAutoAimSetting then
		self.YaoDelay = tbAutoAimSetting.nYaoDelay;
		self.LifeRet = tbAutoAimSetting.nLifeRet;
		self.ManaRet = tbAutoAimSetting.nManaRet;
	end
end

function uiAutoAim:UpdateWnd()
	if Map.tbAutoAim.nYaoTimer == 0 then
		Btn_SetTxt(Ui.UI_AUTOAIM, "BtnAutoYao", "Tắt");
		Btn_Check(Ui.UI_AUTOAIM,"BtnAutoYao",0);
	else
		Btn_SetTxt(Ui.UI_AUTOAIM, "BtnAutoYao", "Bật");
		Btn_Check(Ui.UI_AUTOAIM,"BtnAutoYao",1);
	end

	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_DELAY, self.YaoDelay / 0.3);
	local szText	= string.format("<color=gold>%s<color>giây", self.YaoDelay);
	Txt_SetTxt(self.UIGROUP, self.TXT_DELAY, szText);

	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_LIFE, self.LifeRet / 5);
	local szText	= string.format("%s", self.LifeRet) .."%";
	Txt_SetTxt(self.UIGROUP, self.TXT_LIFE, szText);

	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MANA, self.ManaRet / 5);
	local szText	= string.format("%s", self.ManaRet) .."%";
	Txt_SetTxt(self.UIGROUP, self.TXT_MANA, szText);
end

function uiAutoAim:OnOpen()
	PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_ONE);
	self:LoadSetting();
	self:UpdateWnd();
end

uiAutoAim.OnButtonClick = function(self, szWnd, nParam)
	if (szWnd == self.BTN_CLOSE1) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_SAVE) then
		self:SaveData();
		self:UpdateYao();
		UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Save Settings hoàn tất!<color>")
	elseif (szWnd == self.BTN_AUTOYAO) then
		Map.tbAutoAim:FAutoYao()
	end
end

uiAutoAim.OnScorllbarPosChanged = function(self, szWnd, nParam)
	if szWnd == self.SCROLL_DELAY then
		self.YaoDelay =  nParam * 0.3
		local szText	= string.format("<color=gold>%s<color>", self.YaoDelay) .."giây";
		Txt_SetTxt(self.UIGROUP, self.TXT_DELAY, szText);
	elseif szWnd == self.SCROLL_LIFE then
		self.LifeRet = nParam * 5;
		local szText	= string.format("%s", self.LifeRet) .."%"
		Txt_SetTxt(self.UIGROUP, self.TXT_LIFE, szText);
	elseif szWnd == self.SCROLL_MANA then
		self.ManaRet = nParam * 5;
		local szText	= string.format("%s", self.ManaRet) .."%"
		Txt_SetTxt(self.UIGROUP, self.TXT_MANA, szText);
	end
end

uiAutoAim.UpdateYao = function(self)
	local tbAutoYaoCfg =
	{
		nYaoDelay	= self.YaoDelay,
		nLifeRet	= self.LifeRet,
		nManaRet	= self.ManaRet,
	};
	Map.tbAutoAim:UpdateYaoCfg(tbAutoYaoCfg)
end

uiAutoAim:Init();
Ui:RegisterNewUiWindow("UI_AUTOAIM", "AUTOAIM", {"a", 520, 220}, {"b", 520, 220}, {"c", 520, 220}, {"d", 1011, 429});
LoadUiGroup(Ui.UI_AUTOAIM, "chiyao.ini");