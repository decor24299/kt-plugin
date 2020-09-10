
Ui.UI_STR_TEST = "UI_STR_TEST";
local uiStrTest = Ui.tbWnd[Ui.UI_STR_TEST] or {};
uiStrTest.UIGROUP = Ui.UI_STR_TEST;
Ui.tbWnd[Ui.UI_STR_TEST] = uiStrTest;

local self = uiStrTest;

uiStrTest.BTN_PRINT      		= "BtnPrint"; 
uiStrTest.BTN_RELOAD			= "BtnReload";
uiStrTest.BTN_CLOSE       		= "BtnClose";
uiStrTest.BTN_EXIT       		= "BtnExit";

uiStrTest.EDT_SILVERUP			= "EdtSilverUp";

uiStrTest.CMB_Select	        = "CmbSelect";
uiStrTest.CMB_STRTHEN	        = "CmbStrThen";

--uiStrTest.TXT_STRLEVEL  			= "TxtStrLevel";

uiStrTest.TXT_COUNTHT  			= "TxtCountHT2";
uiStrTest.TXT_PERCENT  			= "TxtPercent";
uiStrTest.TXT_SILVER  			= "TxtSilver";

uiStrTest.TXT_NUMHT1  			= "TxtNumHT1";
uiStrTest.TXT_NUMHT2 	 		= "TxtNumHT2";
uiStrTest.TXT_NUMHT3  			= "TxtNumHT3";
uiStrTest.TXT_NUMHT4  			= "TxtNumHT4";
uiStrTest.TXT_NUMHT5  			= "TxtNumHT5";
uiStrTest.TXT_NUMHT6  			= "TxtNumHT6";
uiStrTest.TXT_NUMHT7  			= "TxtNumHT7";
uiStrTest.TXT_NUMHT8  			= "TxtNumHT8";
uiStrTest.TXT_NUMHT9  			= "TxtNumHT9";
uiStrTest.TXT_NUMHT10  			= "TxtNumHT10";
uiStrTest.TXT_NUMHT11  			= "TxtNumHT11";
uiStrTest.TXT_NUMHT12  			= "TxtNumHT12";

-- uiStrTest.BTN_ADD_STR  			= "BtnAddStr";
uiStrTest.BTN_ADD_HT1  			= "BtnAddHT1";
uiStrTest.BTN_ADD_HT2  			= "BtnAddHT2";
uiStrTest.BTN_ADD_HT3  			= "BtnAddHT3";
uiStrTest.BTN_ADD_HT4  			= "BtnAddHT4";
uiStrTest.BTN_ADD_HT5  			= "BtnAddHT5";
uiStrTest.BTN_ADD_HT6  			= "BtnAddHT6";
uiStrTest.BTN_ADD_HT7  			= "BtnAddHT7";
uiStrTest.BTN_ADD_HT8  			= "BtnAddHT8";
uiStrTest.BTN_ADD_HT9  			= "BtnAddHT9";
uiStrTest.BTN_ADD_HT10  		= "BtnAddHT10";
uiStrTest.BTN_ADD_HT11  		= "BtnAddHT11";
uiStrTest.BTN_ADD_HT12  		= "BtnAddHT12";

--uiStrTest.BTN_DEC_STR  			= "BtnDecStr";
uiStrTest.BTN_DEC_HT1  			= "BtnDecHT1";
uiStrTest.BTN_DEC_HT2  			= "BtnDecHT2";
uiStrTest.BTN_DEC_HT3  			= "BtnDecHT3";
uiStrTest.BTN_DEC_HT4  			= "BtnDecHT4";
uiStrTest.BTN_DEC_HT5  			= "BtnDecHT5";
uiStrTest.BTN_DEC_HT6  			= "BtnDecHT6";
uiStrTest.BTN_DEC_HT7  			= "BtnDecHT7";
uiStrTest.BTN_DEC_HT8  			= "BtnDecHT8";
uiStrTest.BTN_DEC_HT9  			= "BtnDecHT9";
uiStrTest.BTN_DEC_HT10  		= "BtnDecHT10";
uiStrTest.BTN_DEC_HT11  		= "BtnDecHT11";
uiStrTest.BTN_DEC_HT12  		= "BtnDecHT12";

local nSelect = 1;
local nStrLv = 1;
local nStrThen = 1;
local nPercent = 0;
local nSilver = 0;
local nSilverUp = 200;

local nBeginHT1 = 0;
local nBeginHT2 = 0;
local nBeginHT3 = 0;
local nBeginHT4 = 0;
local nBeginHT5 = 0;
local nBeginHT6 = 0;
local nBeginHT7 = 0;
local nBeginHT8 = 0;
local nBeginHT9 = 0;
local nBeginHT10 = 0;
local nBeginHT11 = 0;
local nBeginHT12 = 0;
local nCountHT = 0;
local nX = 4;

local nPerHT1 = 0;
local nPerHT2 = 0;
local nPerHT3 = 0;
local nPerHT4 = 0;
local nPerHT5 = 0;
local nPerHT6 = 0;
local nPerHT7 = 0;
local nPerHT8 = 0;
local nPerHT9 = 0;
local nPerHT10 = 0;
local nPerHT11 = 0;
local nPerHT12 = 0;

self.tbSelect	= {"Vũ Khí", "Phòng Cụ", "Trang Sức"};
self.tbStrThen = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"};

self.STUFF_LIST1 = {
	["1"] = {"Tỷ lệ cường hóa cấp 1", 0.0694444444444, 0.25, 0.9, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
	["2"] = {"Tỷ lệ cường hóa cấp 2", 0.0277777777778, 0.1, 0.36, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
	["3"] = {"Tỷ lệ cường hóa cấp 3", 0.00925925925926, 0.0333333333333, 0.12, 0.431944444444, 1, 1, 1, 1, 1, 1, 1, 1}, 
	["4"] = {"Tỷ lệ cường hóa cấp 4", 0.00231481481481, 0.00833333333333, 0.03, 0.107986111111, 0.388796296296, 1, 1, 1, 1, 1, 1, 1}, 
	["5"] = {"Tỷ lệ cường hóa cấp 5", 0.00173611111111, 0.00625, 0.0225, 0.0809895833333, 0.291597222222, 1, 1, 1, 1, 1, 1, 1}, 
	["6"] = {"Tỷ lệ cường hóa cấp 6", 0.00111111111111, 0.004, 0.0144, 0.0518333333333, 0.186622222222, 0.671844444444, 1, 1, 1, 1, 1, 1}, 
	["7"] = {"Tỷ lệ cường hóa cấp 7", 0.000555555555556, 0.002, 0.0072, 0.0259166666667, 0.0933111111111, 0.335922222222, 1, 1, 1, 1, 1, 1}, 
	["8"] = {"Tỷ lệ cường hóa cấp 8", 0.000132275132275, 0.00047619047619, 0.00171428571429, 0.00617063492063, 0.0222169312169, 0.0799814814815, 0.287933862434, 1, 1, 1, 1, 1}, 
	["9"] = {"Tỷ lệ cường hóa cấp 9", 0.000104821802935, 0.000377358490566, 0.00135849056604, 0.00488993710692, 0.017605870021, 0.0633815513627, 0.228174004193, 0.821426624738, 1, 1, 1, 1}, 
	["10"] = {"Tỷ lệ cường hóa cấp 10", 0, 0.00025, 0.0009, 0.00323958333333, 0.0116638888889, 0.0419902777778, 0.151165277778, 0.544195138889, 1, 1, 1, 1}, 
	["11"] = {"Tỷ lệ cường hóa cấp 11", 0, 0.000125, 0.00045, 0.00161979166667, 0.00583194444444, 0.0209951388889, 0.0755826388889, 0.272097569444, 0.979551736111, 1, 1, 1}, 
	["12"] = {"Tỷ lệ cường hóa cấp 12", 0, 0, 0.0001125, 0.000404947916667, 0.00145798611111, 0.00524878472222, 0.0188956597222, 0.0680243923611, 0.244887934028, 0.881596788194, 1, 1}, 
	["13"] = {"Tỷ lệ cường hóa cấp 13", 0, 0, 0, 0.000323958333333, 0.00116638888889, 0.00419902777778, 0.0151165277778, 0.0544195138889, 0.195910347222, 0.705277430556, 1, 1}, 
	["14"] = {"Tỷ lệ cường hóa cấp 14", 0, 0, 0, 0.000215972222222, 0.000777592592593, 0.00279935185185, 0.0100776851852, 0.0362796759259, 0.130606898148, 0.470184953704, 1, 1}, 
	["15"] = {"Tỷ lệ cường hóa cấp 15", 0, 0, 0, 0.000107986111111, 0.000388796296296, 0.00139967592593, 0.00503884259259, 0.018139837963, 0.0653034490741, 0.235092476852, 0.846429675926, 1}, 
	["16"] = {"Tỷ lệ cường hóa cấp 16", 0, 0, 0, 0, 0, 0.000349918981481, 0.00125971064815, 0.00453495949074, 0.0163258622685, 0.058773119213, 0.211607418981, 0.761786712963}, 
}

self.STUFF_LIST2 = {
	["Bạc"] = {"Bạc cường hóa", 640, 800, 4800, 19200, 25600, 40000, 80000, 336000, 424000, 640000, 1280000, 5120000, 6400000, 9600000, 19200000, 76800000}, 
}

local szCmd	= [=[
		UiManager:SwitchWindow(Ui.UI_STR_TEST);
	]=];
	
function uiStrTest:OnOpen()

	ClearComboBoxItem(self.UIGROUP, self.CMB_Select);
	for i = 1, #self.tbSelect do
		ComboBoxAddItem(self.UIGROUP, self.CMB_Select, i, self.tbSelect[i]);
	end
	ClearComboBoxItem(self.UIGROUP, self.CMB_STRTHEN);
	for i = 1, #self.tbStrThen do
		ComboBoxAddItem(self.UIGROUP, self.CMB_STRTHEN, i, self.tbStrThen[i]);
	end
	self:UpdateComboBox();
	
	--Txt_SetTxt(self.UIGROUP, self.TXT_STRLEVEL, nStrLv);
	Txt_SetTxt(self.UIGROUP, self.TXT_PERCENT, nPercent);
	Txt_SetTxt(self.UIGROUP, self.TXT_SILVER, nSilver);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT1, nBeginHT1);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT2, nBeginHT2);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT3, nBeginHT3);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT4, nBeginHT4);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT5, nBeginHT5);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT6, nBeginHT6);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT7, nBeginHT7);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT8, nBeginHT8);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT9, nBeginHT9);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT10, nBeginHT10);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT11, nBeginHT11);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT12, nBeginHT12);
	Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
	Edt_SetTxt(self.UIGROUP, self.EDT_SILVERUP, nSilverUp);
end

function uiStrTest:OnButtonClick(szWnd, nParam)
	if (szWnd == uiStrTest.BTN_CLOSE) or (szWnd == uiStrTest.BTN_EXIT) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_RELOAD) then
		self:ScrReload();
	elseif (szWnd == uiStrTest.BTN_PRINT) then
		self:ToNothing();
		-- self:SaveSetting();
		-- self:CarcPercent();
	-- elseif (szWnd == uiStrTest.BTN_ADD_STR) and (nStrLv < 16) then
		-- nStrLv = nStrLv + 1;
		-- Txt_SetTxt(self.UIGROUP, self.TXT_STRLEVEL, nStrLv);
	-- elseif (szWnd == uiStrTest.BTN_DEC_STR) and (nStrLv > 1) then
		-- nStrLv = nStrLv - 1;
		-- Txt_SetTxt(self.UIGROUP, self.TXT_STRLEVEL, nStrLv);
	elseif (szWnd == uiStrTest.BTN_ADD_HT1) and (nBeginHT1 < 16) and (nCountHT < 16) then
		nBeginHT1 = nBeginHT1 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT1, "<color=yellow>"..nBeginHT1);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT2) and (nBeginHT2 < 16) and (nCountHT < 16) then
		nBeginHT2 = nBeginHT2 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT2, "<color=yellow>"..nBeginHT2);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT3) and (nBeginHT3 < 16) and (nCountHT < 16) then
		nBeginHT3 = nBeginHT3 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT3, "<color=yellow>"..nBeginHT3);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT4) and (nBeginHT4 < 16) and (nCountHT < 16) then
		nBeginHT4 = nBeginHT4 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT4, "<color=yellow>"..nBeginHT4);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT5) and (nBeginHT5 < 16) and (nCountHT < 16) then
		nBeginHT5 = nBeginHT5 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT5, "<color=yellow>"..nBeginHT5);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT6) and (nBeginHT6 < 16) and (nCountHT < 16) then
		nBeginHT6 = nBeginHT6 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT6, "<color=yellow>"..nBeginHT6);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT7) and (nBeginHT7 < 16) and (nCountHT < 16) then
		nBeginHT7 = nBeginHT7 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT7, "<color=yellow>"..nBeginHT7);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT8) and (nBeginHT8 < 16) and (nCountHT < 16) then
		nBeginHT8 = nBeginHT8 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT8, "<color=yellow>"..nBeginHT8);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT9) and (nBeginHT9 < 16) and (nCountHT < 16) then
		nBeginHT9 = nBeginHT9 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT9, "<color=yellow>"..nBeginHT9);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT10) and (nBeginHT10 < 16) and (nCountHT < 16) then
		nBeginHT10 = nBeginHT10 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT10, "<color=yellow>"..nBeginHT10);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT11) and (nBeginHT11 < 16) and (nCountHT < 16) then
		nBeginHT11 = nBeginHT11 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT11, "<color=yellow>"..nBeginHT11);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_ADD_HT12) and (nBeginHT12 < 16) and (nCountHT < 16) then
		nBeginHT12 = nBeginHT12 + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT12, "<color=yellow>"..nBeginHT12);
		nCountHT = nCountHT + 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
		
	elseif (szWnd == uiStrTest.BTN_DEC_HT1) and (nBeginHT1 > 0) then
		nBeginHT1 = nBeginHT1 - 1;
		if nBeginHT1 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT1, "<color=yellow>"..nBeginHT1);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT1, nBeginHT1);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT2) and (nBeginHT2 > 0) then
		nBeginHT2 = nBeginHT2 - 1;
		if nBeginHT2 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT2, "<color=yellow>"..nBeginHT2);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT2, nBeginHT2);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT3) and (nBeginHT3 > 0) then
		nBeginHT3 = nBeginHT3 - 1;
		if nBeginHT3 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT3, "<color=yellow>"..nBeginHT3);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT3, nBeginHT3);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT4) and (nBeginHT4 > 0) then
		nBeginHT4 = nBeginHT4 - 1;
		if nBeginHT4 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT4, "<color=yellow>"..nBeginHT4);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT4, nBeginHT4);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT5) and (nBeginHT5 > 0) then
		nBeginHT5 = nBeginHT5 - 1;
		if nBeginHT5 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT5, "<color=yellow>"..nBeginHT5);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT5, nBeginHT5);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT6) and (nBeginHT6 > 0) then
		nBeginHT6 = nBeginHT6 - 1;
		if nBeginHT6 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT6, "<color=yellow>"..nBeginHT6);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT6, nBeginHT6);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT7) and (nBeginHT7 > 0) then
		nBeginHT7 = nBeginHT7 - 1;
		if nBeginHT7 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT7, "<color=yellow>"..nBeginHT7);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT7, nBeginHT7);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT8) and (nBeginHT8 > 0) then
		nBeginHT8 = nBeginHT8 - 1;
		if nBeginHT8 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT8, "<color=yellow>"..nBeginHT8);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT8, nBeginHT8);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT9) and (nBeginHT9 > 0) then
		nBeginHT9 = nBeginHT9 - 1;
		if nBeginHT9 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT9, "<color=yellow>"..nBeginHT9);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT9, nBeginHT9);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT10) and (nBeginHT10 > 0) then
		nBeginHT10 = nBeginHT10 - 1;
		if nBeginHT10 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT10, "<color=yellow>"..nBeginHT10);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT10, nBeginHT10);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT11) and (nBeginHT11 > 0) then
		nBeginHT11 = nBeginHT11 - 1;
		if nBeginHT11 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT11, "<color=yellow>"..nBeginHT11);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT11, nBeginHT11);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	elseif (szWnd == uiStrTest.BTN_DEC_HT12) and (nBeginHT12 > 0) then
		nBeginHT12 = nBeginHT12 - 1;
		if nBeginHT12 > 0 then
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT12, "<color=yellow>"..nBeginHT12);
		else
			Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT12, nBeginHT12);
		end
		nCountHT = nCountHT - 1;
		Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
		self:CarcPercent();
	end
end

function uiStrTest:SaveSetting()
    self:GetEdtValue();
end

function uiStrTest:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == self.CMB_Select) then
		self.nSelect = nIndex;
		self:CarcPercent();
	elseif (szWnd == self.CMB_STRTHEN) then
		self.nStrThen = nIndex;
		nStrLv = self.nStrThen + 1;
		self:CarcPercent();
	end
end

function uiStrTest:ToNothing()
	self:UpdateComboBox();
	self.nSelect = 0;
	self.nStrThen = 0;
	nStrLv = 1;
	nPercent = 0;
	nSilver = 0;
	nSilverUp = 50;
	
	nBeginHT1 = 0;
	nBeginHT2 = 0;
	nBeginHT3 = 0;
	nBeginHT4 = 0;
	nBeginHT5 = 0;
	nBeginHT6 = 0;
	nBeginHT7 = 0;
	nBeginHT8 = 0;
	nBeginHT9 = 0;
	nBeginHT10 = 0;
	nBeginHT11 = 0;
	nBeginHT12 = 0;
	nCountHT = 0;
	nX = 4;

	nPerHT1 = 0;
	nPerHT2 = 0;
	nPerHT3 = 0;
	nPerHT4 = 0;
	nPerHT5 = 0;
	nPerHT6 = 0;
	nPerHT7 = 0;
	nPerHT8 = 0;
	nPerHT9 = 0;
	nPerHT10 = 0;
	nPerHT11 = 0;
	nPerHT12 = 0;

	--Txt_SetTxt(self.UIGROUP, self.TXT_STRLEVEL, nStrLv);
	Txt_SetTxt(self.UIGROUP, self.TXT_PERCENT, nPercent);
	Txt_SetTxt(self.UIGROUP, self.TXT_SILVER, nSilver);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT1, nBeginHT1);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT2, nBeginHT2);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT3, nBeginHT3);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT4, nBeginHT4);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT5, nBeginHT5);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT6, nBeginHT6);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT7, nBeginHT7);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT8, nBeginHT8);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT9, nBeginHT9);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT10, nBeginHT10);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT11, nBeginHT11);
	Txt_SetTxt(self.UIGROUP, self.TXT_NUMHT12, nBeginHT12);
	Txt_SetTxt(self.UIGROUP, self.TXT_COUNTHT, nCountHT);
	Edt_SetTxt(self.UIGROUP, self.EDT_SILVERUP, nSilverUp);
end

function uiStrTest:UpdateComboBox()
	ComboBoxSelectItem(self.UIGROUP, self.CMB_Select, 0);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_STRTHEN, 0);
end

function uiStrTest:CloseUiWindow()
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if (UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1) then
		UiManager:CloseWindow(Ui.UI_REPOSITORY);
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
		nCloseUiTimerId = 0;
	end
end

function uiStrTest:CarcPercent()

	self:SaveSetting();

	Edt_SetTxt(self.UIGROUP, self.EDT_SILVERUP, nSilverUp);
	
	if self.nSelect == 0 then
		nX = 1;
	elseif self.nSelect == 1 then
		nX = 4;
	elseif self.nSelect == 2 then
		nX = (4/1.5);
	end
	
	nPerHT1 = nBeginHT1 * (self.STUFF_LIST1[""..nStrLv..""][2]);
	nPerHT2 = nBeginHT2 * (self.STUFF_LIST1[""..nStrLv..""][3]);
	nPerHT3 = nBeginHT3 * (self.STUFF_LIST1[""..nStrLv..""][4]);
	nPerHT4 = nBeginHT4 * (self.STUFF_LIST1[""..nStrLv..""][5]);
	nPerHT5 = nBeginHT5 * (self.STUFF_LIST1[""..nStrLv..""][6]);
	nPerHT6 = nBeginHT6 * (self.STUFF_LIST1[""..nStrLv..""][7]);
	nPerHT7 = nBeginHT7 * (self.STUFF_LIST1[""..nStrLv..""][8]);
	nPerHT8 = nBeginHT8 * (self.STUFF_LIST1[""..nStrLv..""][9]);
	nPerHT9 = nBeginHT9 * (self.STUFF_LIST1[""..nStrLv..""][10]);
	nPerHT10 = nBeginHT10 * (self.STUFF_LIST1[""..nStrLv..""][11]);
	nPerHT11 = nBeginHT11 * (self.STUFF_LIST1[""..nStrLv..""][12]);
	nPerHT12 = nBeginHT12 * (self.STUFF_LIST1[""..nStrLv..""][13]);
	
	nPercent = ((nPerHT1 + nPerHT2 + nPerHT3 + nPerHT4 + nPerHT5 + nPerHT6 + nPerHT7 + nPerHT8 + nPerHT9 + nPerHT10 + nPerHT11 + nPerHT12) * 100 * nX);
	nSilver = (((nSilverUp / 100) * (self.STUFF_LIST2["Bạc"][nStrLv+1])) / nX);
	--self:FormatMoney(nSilver);
	
	Txt_SetTxt(self.UIGROUP, self.TXT_PERCENT, nPercent);
	Txt_SetTxt(self.UIGROUP, self.TXT_SILVER, self:FormatMoney(nSilver));
	
end

function uiStrTest:GetEdtValue()
	local szSilverUp = Edt_GetInt(self.UIGROUP, self.EDT_SILVERUP)
	if szSilverUp == "" or nil then
		nSilverUp = 200
	else
		nSilverUp = tonumber(szSilverUp)
	end
	if nSilverUp > 200 then
		nSilverUp = 200
	end
	if nSilverUp < 50 then
		nSilverUp = 50
	end
end

function uiStrTest:FormatMoney(nMoney)
	local szMoney = "";
	if (not nMoney) or (nMoney < 0) then
		return	"Vô hiệu";								-- 价钱小于0，出错
	end
	if (nMoney >= 100000000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 100000000)).."Ức";
		nMoney = nMoney % 100000000;
	end
	if (nMoney >= 10000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 10000)).."Vạn";
		nMoney = nMoney % 10000;
	end
	if (nMoney > 0) then
		szMoney = szMoney..tostring(nMoney);
	end
	if (szMoney == "") then
		szMoney = "0";
	end
	return	szMoney;
end

function uiStrTest:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\unreal_tester\\cuonghoa.lua");
	me.Msg("<bclr=0,0,200><color=white>Tự động tải lại hoàn thành !!!<color><bclr>");
end

local tCmd={"UiManager:SwitchWindow(Ui.UI_STR_TEST)", "cuonghoa", "", "Ctrl+J", "Ctrl+J", "cuonghoa"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

LoadUiGroup(Ui.UI_STR_TEST, "cuonghoa_setting.ini");