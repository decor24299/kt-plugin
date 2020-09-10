
Ui.UI_BUTTOND		        = "UI_BUTTOND";
local uiButtonD		        = Ui.tbWnd[Ui.UI_BUTTOND] or {};	-- 支持重载
uiButtonD.UIGROUP		    = Ui.UI_BUTTOND;
Ui.tbWnd[Ui.UI_BUTTOND]	    = uiButtonD
Map.tbButtonD		        = uiButtonD;
local self			        = uiButtonD
local tbTimer = Ui.tbLogic.tbTimer;

-- 功能:调入面板屏幕放置位置
Ui:RegisterNewUiWindow("UI_BUTTOND", "ButtonD",  {"a", 749, 205}, {"b", 766,239}, {"c", 1258, 210}, {"d", 1245, 214});

local n1 = 0

-- 功能:按钮设置
local BTN_MENU1	= "BtnMenu1"
local BTN_MENU2	= "BtnMenu2"

-- 功能:点击按钮弹出菜单
uiButtonD.OnButtonClick_Bak = uiButtonD.OnButtonClick;

-- 功能:点击弹出菜单功能设置
function uiButtonD:OnButtonClick(szWnd)
	if (szWnd == BTN_MENU1) then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	elseif (szWnd == BTN_MENU2) then
		if (UiManager:WindowVisible(Ui.UI_TOOL) == 1) then
			UiManager:CloseWindow(Ui.UI_TOOL)
		end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEB) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEB)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEC) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEC)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMED) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMED)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEE) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEE)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEF) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEF)
		--end		
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEG) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEG)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEH) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEH)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEI) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEI)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEIK) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEIK)
		--end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEDIY) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEDIY)
		--end	
		if (UiManager:WindowVisible(Ui.UI_SHOWTIMEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SHOWTIMEL)
		end
		--if (UiManager:WindowVisible(Ui.UI_SHOWTIMEHD) == 1) then
			--UiManager:CloseWindow(Ui.UI_SHOWTIMEHD)
		--end		

		--local nResolution = GetUiMode();
		--if (UiManager:WindowVisible(Ui.UI_SIDEBAR) == 1) and nResolution == "a" then
			--UiManager:CloseWindow(Ui.UI_SIDEBAR)
		--end

		UiManager:SwitchWindow(Ui.UI_SHOWTIMEMULU)

	end
end
LoadUiGroup(Ui.UI_BUTTOND, "2.ini");
