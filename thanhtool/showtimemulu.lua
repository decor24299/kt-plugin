Ui.UI_SHOWTIMEMULU		        = "UI_SHOWTIMEMULU";
local uiShowTimeMULU		    = Ui.tbWnd[Ui.UI_SHOWTIMEMULU] or {};
uiShowTimeMULU.UIGROUP		    = Ui.UI_SHOWTIMEMULU;
Ui.tbWnd[Ui.UI_SHOWTIMEMULU]	= uiShowTimeMULU
Map.tbShowTimeMULU		        = uiShowTimeMULU;

local BTNST1		=	"BtnST1"
local BTNST2		= 	"BtnST2"
--local BTNST3		= 	"BtnST3"
--local BTNST4		= 	"BtnST4"
--local BTNST5		=	"BtnST5"
--local BTNST6		=	"BtnST6"
--local BTNST7		=	"BtnST7"
--local BTNST8		=	"BtnST8"
--local BTNST9		=	"BtnST9"
--local BTNST10		=	"BtnST10"
--local BTNST11		=	"BtnST11"
--local BTNST12		=	"BtnST12"
--local BTNST13		=	"BtnST13"

local self = uiShowTimeMULU;
local tbTimer = Ui.tbLogic.tbTimer;

Ui:RegisterNewUiWindow("UI_SHOWTIMEMULU", "showtimemulu", {"a", 714, 229}, {"b", 752,267}, {"c", 1240, 245}, {"d", 1234, 237});

function uiShowTimeMULU:OnButtonClick(szWnd)

	if (szWnd == BTNST1) then

		UiManager:SwitchWindow(Ui.UI_SHOWTIMEMULU);
		UiManager:SwitchWindow(Ui.UI_TOOL);

	elseif (szWnd == BTNST2) then

		UiManager:SwitchWindow(Ui.UI_SHOWTIMEMULU);
		UiManager:SwitchWindow(Ui.UI_SHOWTIMEL);

	--elseif (szWnd == BTNST3) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMED);

	--elseif (szWnd == BTNST4) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEE);

	--elseif (szWnd == BTNST5) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEF);

	--elseif (szWnd == BTNST6) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEG);

	--elseif (szWnd == BTNST7) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEH);

	--elseif (szWnd == BTNST8) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_TOOL);

	--elseif (szWnd == BTNST9) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEI);

	--elseif (szWnd == BTNST10) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEIK);

	--elseif (szWnd == BTNST11) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEDIY);		

	--elseif (szWnd == BTNST12) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEL);
		
    --elseif (szWnd == BTNST13) then

		--UiManager:CloseWindow(Ui.UI_SHOWTIMEMULU);
		--UiManager:OpenWindow(Ui.UI_SHOWTIMEHD);
	end
end

LoadUiGroup(Ui.UI_SHOWTIMEMULU, "showtimemulu.ini");