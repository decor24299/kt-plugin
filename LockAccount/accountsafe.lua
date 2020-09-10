--local uiAccountSafe = Ui:GetClass("accountsafe");
local uiAccountSafe = Ui(Ui.UI_ACCOUNTSAFE);
local self          = uiAccountSafe;
uiAccountSafe.SZ_CARD_JIESUO_URL = "";
uiAccountSafe.SZ_LINGPAI_JIESUO_URL = "";
uiAccountSafe.BTN_MIBAOKA 	= "BtnMiBaoKa";
uiAccountSafe.BTN_LINGPAI	= "BtnLingPai";
uiAccountSafe.BTN_CLOSE		= "BtnClose";
uiAccountSafe.TEXT_NOTE		= "TxtNote";

function uiAccountSafe:OnOpen()
	local szDISPROTECT_NOTE_KINGSOFT = "Tài khoản của bạn chưa mở chức năng Thẻ mật mã hoặc Lệnh bài.\n\nĐể tài sản của bạn được bảo đảm an toàn, nhất định phải mở Thẻ mật mã miễn phí, mua Lệnh bài hay cài phần mềm mật mã, tránh sự xâm nhập của hacker."
	Txt_SetTxt(self.UIGROUP, self.TEXT_NOTE, szDISPROTECT_NOTE_KINGSOFT);
	local function fnCloseSelf()
		if UiManager:WindowVisible(self.UIGROUP) == 1 then
			UiManager:CloseWindow(self.UIGROUP);
			return 0
		end
	end
	Ui.tbLogic.tbTimer:Register(1,fnCloseSelf);
end

function uiAccountSafe:OnButtonClick(szWndName, nParam)
	print("OnButtonClick"..szWndName)
	if szWndName == self.BTN_LINGPAI then
		--OpenWebSite(self.SZ_LINGPAI_JIESUO_URL);
	end
	
	-- if szWndName == self.BTN_MIBAOSOFT then
		-- OpenWebSite(self.SZ_MIBAOSOFT_URL);
	-- end
	
	if szWndName == self.BTN_MIBAOKA then
		--OpenWebSite(self.SZ_CARD_JIESUO_URL);
	end

	if szWndName == self.BTN_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	end
	
	-- if szWndName == self.BTN_SMALL_CLOSE then
		-- UiManager:CloseWindow(self.UIGROUP);
	-- end
end


