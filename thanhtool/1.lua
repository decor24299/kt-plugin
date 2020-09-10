--- Thanh TCTBAR - di chuyển nhanh ---
Ui.UI_TCTBAR		= "UI_TCTBAR";
local uiTCTBAR			= Ui.tbWnd[Ui.UI_TCTBAR] or {};	
uiTCTBAR.UIGROUP		= Ui.UI_TCTBAR;
Ui.tbWnd[Ui.UI_TCTBAR] = uiTCTBAR
--------Các Menu

uiTCTBAR.BTN_Menu1		="BtnMenu1"
--------------------
local tbTimer 				= Ui.tbLogic.tbTimer;
local self					= uiTCTBAR;

Ui:RegisterNewUiWindow("UI_TCTBAR", "1", {"a", 598, 570}, {"b", 355, 630}, {"c", 392, 32});
	
uiTCTBAR.tbAllModeResolution	= {
	["a"]	= { 210, 54 },
	["b"]	= { 430, 5 },
	["c"]	= { 392, 32 },
};

uiTCTBAR.Chon =
{ 
	{" Boss 95-TL "},
	{" Thanh Tool "},
	{" Thanh Tổ đội "},
	
};

self.tbOptionSetting = {};

uiTCTBAR.OnButtonClick_Bak = uiTCTBAR.OnButtonClick;

uiTCTBAR.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_Menu1) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.Chon[1][1],
		1,
		self.Chon[2][1],
		2,
		self.Chon[3][1],
		3
		);
	end

end

uiTCTBAR.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if szWnd == self.BTN_Menu1 then
		if nItemId==1 then
			UiManager:SwitchWindow(Ui.UI_TOOL95)
		elseif nItemId==2 then
			UiManager:SwitchWindow(Ui.UI_TOOLS)
		elseif nItemId==3 then
			UiManager:SwitchWindow(Ui.UI_TOOLtd)	
		end
	 end
	 ----------------------------------
end	 

function uiTCTBAR:ScrReload()
	UiManager:CloseWindow(Ui.UI_TCTBAR)
end
