--- đồng hồ nâng cao - tự ăn THL, BCH, thẻ TDC ---
Ui.UI_MINICLOCK			= "UI_MINICLOCK";

local uiMiniClock		= Ui.tbWnd[Ui.UI_MINICLOCK] or {};	-- 支持重载
uiMiniClock.UIGROUP		= Ui.UI_MINICLOCK;
Ui.tbWnd[Ui.UI_MINICLOCK] = uiMiniClock;

uiMiniClock.TXX_CTRL 	= "TxtCtrl";
uiMiniClock.TXX_TIME 	= "TxtTime";
uiMiniClock.WND_MAIN 	= "Main";

Ui:RegisterNewUiWindow("UI_MINICLOCK", "miniclock", {"a", 780, 589}, {"b", 940, 707}, {"c", 1259, 786});
uiMiniClock.tbAllModeResolution	= {
	["a"]	= { 780, 589 },
	["b"]	= { 1005, 756 },
	["c"]	= { 1259, 786 },
};

uiMiniClock.tbTimeStyle	= {
	{"New Style",	"<font=16><bclr=red><color=white>%H:%M:%S"},
};

function uiMiniClock:OnEnterGame()
	if (not self.szCurStyle) then
		self:SetStyle(1);
	end
	local function fnOnTimer()
		self:OnTimer();
		self:ShowTime();
	end
	Ui.tbLogic.tbTimer:Register(Env.GAME_FPS / 2, fnOnTimer);
	UiManager:OpenWindow(self.UIGROUP);
end

function uiMiniClock:OnOpen()
	TxtEx_SetText(self.UIGROUP, self.TXX_CTRL, "");
end

function uiMiniClock:OnTimer()
	if (self.bTempText ~= 1) then
		local szText	= os.date(self.szCurStyle, GetTime());
		Wnd_SetSize(self.UIGROUP, self.TXX_TIME, 0, 0);
		TxtEx_SetText(self.UIGROUP, self.TXX_TIME, szText);
	end
	
	local nWidth, nHeight	= Wnd_GetSize(self.UIGROUP, self.TXX_TIME);
	nWidth	= nWidth + 10;
	Wnd_SetSize(self.UIGROUP, self.WND_MAIN, nWidth, nHeight);
	
	local nCurX, nCurY	= Wnd_GetPos(self.UIGROUP, self.WND_MAIN);
	local tbModeResolution	= self.tbAllModeResolution[GetUiMode()];
	local nNewX	= math.min(math.max(0, nCurX), tbModeResolution[1] - nWidth);
	local nNewY	= math.min(math.max(0, nCurY), tbModeResolution[2] - nHeight);
	Wnd_SetPos(self.UIGROUP, self.WND_MAIN, nNewX, nNewY);
	
------------------------sử dụng vật phẩm----------------------------------	
		
	if me.GetItemCountInBags(18,1,20260,1) > 0 then					-- Rương hoàng Kim năng động
		for _, tbItem in pairs(me.FindItemInBags(18,1,20260,1)) do  
			me.UseItem(tbItem.pItem);
		end
		--return SendChannelMsg("Tong", "Đủ 110 Phúc duyên rồi. Nhận rương Hoàng Kim kiếm Tiểu Du Long lệnh thôi!");
	end
	
end

function uiMiniClock:ShowTime()
Ui(Ui.UI_NHACNHO):NhacNho()
uiMiniClock:OnTimer()
if (me.GetMapTemplateId() > 1722 and me.GetMapTemplateId() < 1737) then
SendChannelMsg("NearBy", "Tưởng Nhất bình kìa <pic=94> !!!");
Ui(Ui.UI_DACDUYETPHUONG):TuongNhatBinh();
end
end

function uiMiniClock:Link_mycmd_OnClick(szWnd, szLinkData)
	local szCmd		= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szCmd		= string.sub(szLinkData, nAt + 1);
	end
	GM:DoCommand(szCmd);
end

function uiMiniClock:Link_mycmd_GetText(szWnd, szLinkData)
	local szDesc	= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szDesc		= string.sub(szLinkData, 1, nAt - 1);
	end
	return szDesc;
end

function uiMiniClock:_Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiMiniClock.EnterGame_bak(Ui);
		uiMiniClock:OnEnterGame();
	end
	print("MiniClock Loaded!");
end

function uiMiniClock:Reload()
	self.bTempText	= 0;
	
    local function fnDoScript(szFilePath)
        local szFileData    = KFile.ReadTxtFile(szFilePath);
        assert(loadstring(szFileData, szFilePath))();
    end
	fnDoScript("\\interface2\\MiniClock\\miniclock.lua")
	
	local function fnReload()
--		LoadUiGroup(self.UIGROUP, "miniclock.ini");
		UiManager:OpenWindow(self.UIGROUP);
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(1, fnReload);
end

function uiMiniClock:SetStyle(nIndex)
	self.bTempText	= 0;
	
	self.szCurStyle	= self.tbTimeStyle[nIndex][2];
end

uiMiniClock:_Init();