---------------------------======Edited by Quốc Huy======---------------------------
local uiMail = Ui(Ui.UI_MAIL)
local self = uiMail

function uiMail:OnButtonClick(szWnd, nParam)
	if Mail.IsManuUse == 0 then
		return 0;
	end
	if (szWnd == self.CLOSE_WINDOW_BUTTON) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BUTTON_OPEN_MAIL) then
		Ui.tbWnd[Ui.UI_TOOLS2]:SwitchDelMails()
	elseif (szWnd == self.BUTTON_NEW_MAIL) then
		Mail:RequestOpenNewMail();
	elseif (szWnd == self.BUTTON_CLS_ALL_MAIL) then
		Ui(Ui.UI_MAIL):ClearAllMail(0);
	elseif (szWnd == self.BUTTON_CLS_READ_MAIL) then
		Ui(Ui.UI_MAIL):ClearAllMail(1);
	end
end