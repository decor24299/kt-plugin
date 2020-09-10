Ui.UI_SHOWTIMEL			    = "UI_SHOWTIMEL";
local uiShowTimeL		    = Ui.tbWnd[Ui.UI_SHOWTIMEL] or {};
uiShowTimeL.UIGROUP		    = Ui.UI_SHOWTIMEL;
Ui.tbWnd[Ui.UI_SHOWTIMEL]	= uiShowTimeL
Map.tbShowTimeL		        = uiShowTimeL;

local BTNST1		=	"BtnST1"
local BTNST2		= 	"BtnST2"
local BTNST3		= 	"BtnST3"
local BTNST4		= 	"BtnST4"
local BTNST5		=	"BtnST5"
local BTNST6		=	"BtnST6"
local BTNST7		=	"BtnST7"
local BTNST8		=	"BtnST8"
local BTNST9		=	"BtnST9"
local BTNST10		=	"BtnST10"
local BTNST11		=	"BtnST11"
local BTNST12		=	"BtnST12"
local BTNST13	    =	"BtnST13"
--local BtnST14		= "BtnST14"
local self			= uiShowTimeL
local tbTimer = Ui.tbLogic.tbTimer;

Ui:RegisterNewUiWindow("UI_SHOWTIMEL", "ShowTimeL", {"a", 714, 229}, {"b", 752,267}, {"c", 1240, 245});

function uiShowTimeL:OnButtonClick(szWnd)
	if (szWnd == BTNST1) then
		UiManager:SwitchWindow(Ui.UI_AUTOFIGHT);
	elseif (szWnd == BTNST2) then
		UiManager:SwitchWindow(Ui.UI_NOPICK_SETTING);
	elseif (szWnd == BTNST3) then
		UiManager:SwitchWindow(Ui.UI_AUTODADAO);
	elseif (szWnd == BTNST4) then
		UiManager:SwitchWindow(Ui.UI_PERESPLUS_SETTING);
	elseif (szWnd == BTNST5) then
		UiManager:SwitchWindow(Ui.UI_AUTOSAY);
	elseif (szWnd == BTNST6) then
		UiManager:SwitchWindow(Ui.UI_AUTO_OPEN_PET);
	elseif (szWnd == BTNST7) then
		UiManager:SwitchWindow(Ui.UI_SPRBAO_SETTING);
	elseif (szWnd == BTNST8) then
		UiManager:SwitchWindow(Ui.UI_UNREAL);
	elseif (szWnd == BTNST9) then
		UiManager:SwitchWindow(Ui.UI_TBMPGUA);		
	elseif (szWnd == BTNST10) then
		UiManager:SwitchWindow(Ui.UI_TRAIN);		
	elseif (szWnd == BTNST11) then
		UiManager:SwitchWindow(Ui.UI_PARTNER);		
	elseif (szWnd == BTNST12) then
		UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)
	elseif (szWnd == BTNST13) then
		UiManager:SwitchWindow(Ui.UI_AUTOAIM)	
	end
end

LoadUiGroup(Ui.UI_SHOWTIMEL, "thietlap.ini");

