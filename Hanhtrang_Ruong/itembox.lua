--cyberdemon--
local tbItemBox = Ui(Ui.UI_ITEMBOX);
local BTN_CLASSIFICATION= "BtnClassification";
local BTN_Diu_QI			= "BtnDiuQIWuQing";
local BTN_Diu_QI_XuanJing	= "BtnDiuQiXuanJing";
local BTN_Open_Bank			= "BtnOpenBank";

tbItemBox.OnOpen_Bak = tbItemBox.OnOpen
tbItemBox.OnOpen = function(self)
	tbItemBox.OnOpen_Bak(self)
	local nX,nY  = Wnd_GetPos(self.UIGROUP, BTN_CLASSIFICATION);
	Wnd_SetPos(self.UIGROUP,BTN_Diu_QI,nX + 68,nY);
	Wnd_SetPos(self.UIGROUP,BTN_Diu_QI_XuanJing,nX + 95,nY);
	Wnd_SetPos(self.UIGROUP,BTN_Open_Bank,nX + 122,nY);
end

tbItemBox.OnButtonClick_Bak = tbItemBox.OnButtonClick;
tbItemBox.OnButtonClick = function(self, szWnd, nParam)
	if (szWnd == BTN_Diu_QI) then
		AutoAi:SwitchAutoThrowAway2();
	elseif (szWnd == BTN_Diu_QI_XuanJing) then
		AutoAi:SwitchAutoThrowAway();
	elseif (szWnd == BTN_Open_Bank) then
		if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 0 then
			UiManager:OpenWindow(Ui.UI_REPOSITORY);
		else
			UiManager:CloseWindow(Ui.UI_REPOSITORY);
		end
	end
	self:OnButtonClick_Bak(szWnd, nParam);
end