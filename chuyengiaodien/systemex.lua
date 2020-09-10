local uiSystemEx = Ui(Ui.UI_SYSTEMEX);

uiSystemEx.BTNJSHZ = "BtnJSHZ"

uiSystemEx.OnButtonClick_Bak = uiSystemEx.OnButtonClick_Bak or uiSystemEx.OnButtonClick;

function uiSystemEx:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTNJSHZ then
		UiManager:SwitchWindow(Ui.UI_JSBOX)
		UiManager:CloseWindow(Ui.UI_SYSTEMEX)
	end
	self:OnButtonClick_Bak(szWnd, nParam);
end


