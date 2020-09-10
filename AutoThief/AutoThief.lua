
Ui.UI_AUTODADAO = "UI_AUTODADAO";
local uiAutoDaDao = Ui.tbWnd[Ui.UI_AUTODADAO] or {};
uiAutoDaDao.UIGROUP = Ui.UI_AUTODADAO;
Ui.tbWnd[Ui.UI_AUTODADAO] = uiAutoDaDao;

local self = uiAutoDaDao;
local nYao = 0;
local nPL = 0;

uiAutoDaDao.BTN_CLOSE		= "BtnClose";
uiAutoDaDao.BTN_SAVE		= "BtnSave";
uiAutoDaDao.BTN_CANCEL		= "BtnCancel";
uiAutoDaDao.BTN_START		= "BtnStart";
uiAutoDaDao.BTN_STOP		= "BtnStop";
uiAutoDaDao.CMB_CITYMAP		= "CmbCityMap";
uiAutoDaDao.CHK_DANSHUA		= "ChkDanShua";
uiAutoDaDao.CHK_QUNSHUA		= "ChkQunShua";
uiAutoDaDao.CHK_LBVD		= "ChkLBVD";
uiAutoDaDao.CHK_Thoat		= "ChkThoat";
uiAutoDaDao.CHK_Luyen		= "ChkLuyen";
uiAutoDaDao.CHK_NMChien		= "ChkNMChien";
uiAutoDaDao.CHK_THROWALL	= "ChkThrowAll";
uiAutoDaDao.CHK_TUIZHU		= "ChkTuiZhu";
uiAutoDaDao.CHK_AUTOLEVEL	= "ChkAutoLevel";
uiAutoDaDao.TXT_BEFWAITTIME	= "TxtBefWaitTimeDisplay";
uiAutoDaDao.SCR_BEFWAITTIME	= "ScrBefWaitTime";
uiAutoDaDao.TXT_AFTWAITTIME	= "TxtAftWaitTimeDisplay";
uiAutoDaDao.SCR_AFTWAITTIME	= "ScrAftWaitTime";
uiAutoDaDao.EDT_BUYREDNUM	= "EdtBuyRedNum";
uiAutoDaDao.BTN_ADDREDNUM	= "BtnAddRedNum";
uiAutoDaDao.BTN_DECREDNUM	= "BtnDecRedNum";
uiAutoDaDao.CMB_TASKLEVEL	= "CmbTaskLevel";
uiAutoDaDao.CMB_RED	        = "CmbRed";

--uiAutoDaDao.BTN_ALLSTART	= "BtnAllStart";
--uiAutoDaDao.BTN_90		= "Btn90";
--uiAutoDaDao.BTN_110		= "Btn100";

local nT5 = 0
self.SK = 0
self.SKWC = 0
self.SKJD = 0

self.DATA_KEY        = "AutoDaDaoSetting";
self.tbSetting        = {};
self.TaskLevel        = {"Cấp nhiệm vụ", "Cấp 90", "Cấp 80", "Cấp 70", "Cấp 60", "Cấp 50"};

self.tbCityMap        = {
                {"Tương Dương", 25, 1627, 3073},
                {"Phượng Tường", 24, 1709, 3506},
                {"Biện Kinh", 23, 1644, 3087},
                {"Dương Châu", 26, 1657, 3157},
                {"Thành Đô", 27, 1625, 3286},
                {"Đại Lý", 28, 1661, 3289},
                {"Lâm an", 29, 1653, 3804},
        };

self.tbRed	= {
		{"Thất Xảo Bổ Tâm Đơn","Thất Xảo Bổ Tâm Đơn"},
		{"Ngũ Hoa Ngọc Lộ Hoàn","Ngũ Hoa Ngọc Lộ Hoàn"},
		{"Kim Sáng Dược (đại)","Kim Sáng Dược (đại)"},
		{"Hồi Thiên Đơn","Hồi Thiên Đơn"},
		{"Cửu Chuyển Hoàn Hồn Đơn","Cửu Chuyển Hoàn Hồn Đơn"},
		{"Đại Bổ Tán","Đại Bổ Tán"},
		{"Thủ Ô Hoàn Thần Đơn","Thủ Ô Hoàn Thần Đơn"},
	};


self.STUFF_LIST = {
	["Thịt xào măng"] = {"Thịt xào măng", 821, 821, 17, 3, 2, 1},
	["Đậu tứ quý"] = {"Đậu tứ quý", 822, 822, 17, 3, 2, 2},
	["Đậu Hòa Lan xào"] = {"Đậu Hòa Lan xào", 823, 823, 17, 3, 2, 3},
	["Cải xào tỏi"] = {"Cải xào tỏi", 824, 824, 17, 3, 2, 4},
	["Ngọc Trúc Mai Hoa"] = {"Ngọc Trúc Mai Hoa", 825, 825, 17, 3, 2, 5},

	["Kim Sáng Dược (tiểu)"] = {"Kim Sáng Dược (tiểu)", 676, 676, 17, 1, 1, 1},
	["Kim Sáng Dược (trung)"] = {"Kim Sáng Dược (trung)", 677, 677, 17, 1, 1, 2},
	["Kim Sáng Dược (đại)"] = {"Kim Sáng Dược (đại)", 678, 678, 17, 1, 1, 3},
	["Hồi Thiên Đơn"] = {"Hồi Thiên Đơn", 679, 679, 17, 1, 1, 4},
	["Cửu Chuyển Hoàn Hồn Đơn"] = {"Cửu Chuyển Hoàn Hồn Đơn", 680, 680, 17, 1, 1, 5},

	["Ngưng Thần Đơn (tiểu)"] = {"Ngưng Thần Đơn (tiểu)", 681, 681, 17, 2, 1, 1},
	["Ngưng Thần Đơn (trung)"] = {"Ngưng Thần Đơn (trung)", 682, 682, 17, 2, 1, 2},
	["Ngưng Thần Đơn (đại)"] = {"Ngưng Thần Đơn (đại)", 683, 683, 17, 2, 1, 3},
	["Đại Bổ Tán"] = {"Đại Bổ Tán", 684, 684, 17, 2, 1, 4},
	["Thủ Ô Hoàn Thần Đơn"] = {"Thủ Ô Hoàn Thần Đơn", 685, 685, 17, 2, 1, 5},

	["Thừa Tiên Mật (tiểu)"] = {"Thừa Tiên Mật (tiểu)", 686, 686, 17, 3, 1, 1},
	["Thừa Tiên Mật (trung)"] = {"Thừa Tiên Mật (trung)", 687, 687, 17, 3, 1, 2},
	["Thừa Tiên Mật (đại)"] = {"Thừa Tiên Mật (đại)", 688, 688, 17, 3, 1, 3},
	["Thất Xảo Bổ Tâm Đơn"] = {"Thất Xảo Bổ Tâm Đơn", 689, 689, 17, 3, 1, 4},
	["Ngũ Hoa Ngọc Lộ Hoàn"] = {"Ngũ Hoa Ngọc Lộ Hoàn", 690, 690, 17, 3, 1, 5},
}

local status		= 0;
local nRunning		= 0;
local nArrival		= 0;
local nWaitTimes	= 0;
local nWantedTimerId	= 0;
local nFinishTimes	= 0;
local ConfirmFinish	= 0;
local nCloseUiTimerId	= 0;
local nWaitstats	= 0;
local nSelectOn		= 0;
local nTaskClass	= 0;
local pWantedTime	= 2;	
local pCloseUiTime	= 2;	
self.nWantedState	= 0;	
local nTaskNpcPosX	= 207;	
local nTaskNpcPosY	= 197;	
local tbTeamLeader	= {};	

local szCmd	= [=[
		UiManager:SwitchWindow(Ui.UI_AUTODADAO);
	]=];
UiShortcutAlias:AddAlias("GM_S7", szCmd);

function uiAutoDaDao:Init()

end

function uiAutoDaDao:OnOpen()
	self:LoadSetting();

	Wnd_SetFocus(self.UIGROUP, self.EDT_BUYREDNUM);

	ClearComboBoxItem(self.UIGROUP, self.CMB_CITYMAP);
	for i = 1, #self.tbCityMap do 
		ComboBoxAddItem(self.UIGROUP, self.CMB_CITYMAP, i, self.tbCityMap[i][1]);
	end

	ClearComboBoxItem(self.UIGROUP, self.CMB_TASKLEVEL);
	for i = 1, #self.TaskLevel do 
		ComboBoxAddItem(self.UIGROUP, self.CMB_TASKLEVEL, i, self.TaskLevel[i]);
	end

	ClearComboBoxItem(self.UIGROUP, self.CMB_RED);
	for i = 1, #self.tbRed do 
		ComboBoxAddItem(self.UIGROUP, self.CMB_RED, i, self.tbRed[i][1]);
	end

	self:UpdateControlButton(nWantedTimerId)
	self:UpdateCheckButton();
	self:UpdateScorllBar();
	self:UpdateEdit();
	self:UpdateComboBox();
end

function uiAutoDaDao:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY..tostring(me.nFaction)) or {};
	if not self.tbSetting.nCityMapID then
		self.tbSetting.nCityMapID = 0;
	end
	if not self.tbSetting.nDanShua then
		self.tbSetting.nDanShua = 0;
	end
	if not self.tbSetting.CHK_LBVD then
		self.tbSetting.CHK_LBVD = 0;
	end
	if not self.tbSetting.CHK_Luyen then
		self.tbSetting.CHK_Luyen = 0;
	end
	if not self.tbSetting.CHK_Thoat then
		self.tbSetting.CHK_Thoat = 1;
	end
	if not self.tbSetting.nNMChien then
		self.tbSetting.nNMChien = 0;
	end
	if not self.tbSetting.nThrowAll then
		self.tbSetting.nThrowAll = 0;
	end	
	if not self.tbSetting.nTuiZhu then
		self.tbSetting.nTuiZhu = 0;
	end
	if not self.tbSetting.nAutoLevel then
		self.tbSetting.nAutoLevel = 0;
	end
	if not self.tbSetting.nBefWaitTime then
		self.tbSetting.nBefWaitTime = 18;
	end
	if not self.tbSetting.nAftWaitTime then
		self.tbSetting.nAftWaitTime = 8;
	end
	if not self.tbSetting.nBuyRedNum then
		self.tbSetting.nBuyRedNum = 11;
	end
	if not self.tbSetting.nTaskLevelID then
		self.tbSetting.nTaskLevelID = 0;
	end

	if not self.tbSetting.nRed then
		self.tbSetting.nRed = 3;
	end
end

function uiAutoDaDao:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BTN_CLOSE) then		
		UiManager:CloseWindow(self.UIGROUP);
		self:LoadSetting();
	elseif (szWnd == self.BTN_SAVE) then
		self:SaveData();
		self:Test();
		me.Msg("<bclr=0,0,200><color=white>Lưu dữ liệu thành công ");
	elseif (szWnd == self.BTN_CANCEL) then
		self:LoadSetting();
	elseif (szWnd == self.BTN_START) then
		self:SwitchWantedTask();
	elseif (szWnd == self.BTN_STOP) then
		
	elseif (szWnd == self.CHK_DANSHUA) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 0);
			self.tbSetting.nDanShua = 1;
		else
			Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 1);
			self.tbSetting.nDanShua = 0;
		end
	elseif (szWnd == self.CHK_QUNSHUA) then
		if (nParam == 1) then
			self.tbSetting.nDanShua = 0;
			Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 0);
		else
			self.tbSetting.nDanShua = 1;
			Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 1);
		end
	elseif (szWnd == self.CHK_LBVD) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 1);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 0);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 0);
			self.tbSetting.CHK_LBVD = 1;
			self.tbSetting.CHK_Thoat = 0;
			self.tbSetting.CHK_Luyen = 0;
		end	
	elseif (szWnd == self.CHK_Thoat) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 0);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 1);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 0);
			self.tbSetting.CHK_LBVD = 0;
			self.tbSetting.CHK_Thoat = 1;
			self.tbSetting.CHK_Luyen = 0;
		end
	elseif (szWnd == self.CHK_Luyen) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 0);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 0);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 1);
			self.tbSetting.CHK_LBVD = 0;
			self.tbSetting.CHK_Thoat = 0;
			self.tbSetting.CHK_Luyen = 1;
		end
	elseif (szWnd == self.CHK_NMChien) then	
		self.tbSetting.nNMChien = nParam;
	elseif (szWnd == self.CHK_THROWALL) then	
		self.tbSetting.nThrowAll = nParam;	
	elseif (szWnd == self.CHK_TUIZHU) then
		self.tbSetting.nTuiZhu = nParam;
	elseif (szWnd == self.CHK_AUTOLEVEL) then
		self.tbSetting.nAutoLevel = nParam;
		if (nParam == 1) then
			Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 0);
		else
			Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 1);
		end
	elseif (szWnd == self.BTN_ADDREDNUM) then
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum + 1);
	elseif (szWnd == self.BTN_DECREDNUM) then
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum - 1);

	elseif (szWnd == self.BTN_ALLSTART) then
		Map.tbSuperCall:DuiDao();
	elseif (szWnd == self.BTN_90) then
		Ui.tbBaiDao:StartBaiDao90()
	elseif (szWnd == self.BTN_110) then
		Ui.tbBaiDao:StartBaiDao110()
	end
end

function uiAutoDaDao:UpdateControlButton(nWantedTimerId)
	if (nWantedTimerId == 0) then
		Btn_SetTxt(self.UIGROUP, self.BTN_START, "Bắt đầu");
	else
		Btn_SetTxt(self.UIGROUP, self.BTN_START, "Ngừng");
	end
end

function uiAutoDaDao:UpdateCheckButton()
	if (self.tbSetting.nDanShua == 1) then
		Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 1);
		Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 0);
	else
		Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 0);
		Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 1);
	end
	Btn_Check(self.UIGROUP, self.CHK_LBVD, self.tbSetting.CHK_LBVD);
	Btn_Check(self.UIGROUP, self.CHK_Thoat, self.tbSetting.CHK_Thoat);
	Btn_Check(self.UIGROUP, self.CHK_Luyen, self.tbSetting.CHK_Luyen);
	Btn_Check(self.UIGROUP, self.CHK_NMChien, self.tbSetting.nNMChien);
	Btn_Check(self.UIGROUP, self.CHK_THROWALL, self.tbSetting.nThrowAll);
	Btn_Check(self.UIGROUP, self.CHK_TUIZHU, self.tbSetting.nTuiZhu);
	Btn_Check(self.UIGROUP, self.CHK_AUTOLEVEL, self.tbSetting.nAutoLevel);
end

function uiAutoDaDao:OnScorllbarPosChanged(szWnd, nParam)
	if szWnd == self.SCR_BEFWAITTIME then
		self.tbSetting.nBefWaitTime = nParam;
	end
	if szWnd == self.SCR_AFTWAITTIME then
		self.tbSetting.nAftWaitTime = nParam;
	end
	self:UpdateScorllBar();
end

function uiAutoDaDao:UpdateScorllBar()
	ScrBar_SetCurValue(self.UIGROUP, self.SCR_BEFWAITTIME, self.tbSetting.nBefWaitTime);
	local szText = string.format("<color=gold>%s<color>", self.tbSetting.nBefWaitTime) .." giây";
	Txt_SetTxt(self.UIGROUP, self.TXT_BEFWAITTIME, szText);

	ScrBar_SetCurValue(self.UIGROUP, self.SCR_AFTWAITTIME, self.tbSetting.nAftWaitTime);
	local szText = string.format("<color=gold>%s<color>", self.tbSetting.nAftWaitTime) .." giây";
	Txt_SetTxt(self.UIGROUP, self.TXT_AFTWAITTIME, szText);
end

function uiAutoDaDao:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == self.CMB_CITYMAP) then
		self.tbSetting.nCityMapID = nIndex;
	end

	if (szWnd == self.CMB_TASKLEVEL) then
		self.tbSetting.nTaskLevelID = nIndex;
	end

	if (szWnd == self.CMB_RED) then
		self.tbSetting.nRed = nIndex;
	end
end

function uiAutoDaDao:UpdateComboBox()
	ComboBoxSelectItem(self.UIGROUP, self.CMB_CITYMAP, self.tbSetting.nCityMapID);

	if (self.tbSetting.nAutoLevel == 1) then
		Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 0);
	else
		Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 1);
	end
	ComboBoxSelectItem(self.UIGROUP, self.CMB_TASKLEVEL, self.tbSetting.nTaskLevelID);

	ComboBoxSelectItem(self.UIGROUP, self.CMB_RED, self.tbSetting.nRed);
end

function uiAutoDaDao:OnEditChange(szWndName, nParam)
	if (szWndName == self.EDT_BUYREDNUM) then
		local nNum = Edt_GetInt(self.UIGROUP, self.EDT_BUYREDNUM);
		if (nNum == self.tbSetting.nBuyRedNum) then
			return;
		end
		if (nNum < 0) then
			nNum = 0;
		end
		self.tbSetting.nBuyRedNum = nNum;
		self:UpdateEdit();
	end
end

function uiAutoDaDao:OnEditEnter(szWnd)
	if (szWnd == self.EDT_BUYREDNUM) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
end

function uiAutoDaDao:UpdateEdit()
	Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum);
end

function uiAutoDaDao:SaveData()
	self:Save(self.DATA_KEY..tostring(me.nFaction), self.tbSetting);
end

function uiAutoDaDao:Save(szKey, tbData)
	self.m_szFilePath="\\user\\thief\\Thief_setting_"..me.szName..".txt";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);

	if self:CheckErrorData(szData) == 1 then
		KFile.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function uiAutoDaDao:Load(key)
	self.m_szFilePath="\\user\\thief\\Thief_setting_"..me.szName..".txt";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);

	if (szData) then
		if self:CheckErrorData(szData) == 1 then
			self.m_tbData = Lib:Str2Val(szData);
		else
			KFile.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	return tbData
end

function uiAutoDaDao:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then
			return 0;
		end
	end
	return 1;
end

function uiAutoDaDao:SwitchWantedTask()
	if self.nWantedState == 0 then
		Btn_SetTxt(self.UIGROUP, self.BTN_START, "Ngừng");
		-- UiManager:SwitchWindow(Ui.UI_AUTODADAO);
		self:SaveData();
		self:Test();
		self:GetWantedTaskStatus();
		if (status == 1) then
			me.Msg("<color=yellow>Nhiệm vụ truy nã Hải Tặc hôm nay đã hết");
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Bắt đầu");
			return;
		end
		Ui(Ui.UI_AUTOFIGHT):LoadSetting();
		local nLifeRet = Ui(Ui.UI_AUTOFIGHT).nLifeRet;
		if nLifeRet == nil then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=white>Xin hãy thiết lập tự động đánh<color>")
			UiManager:OpenWindow(Ui.UI_AUTOFIGHT)
			return;
		end
		self.nWantedState = 1;
		nWaitstats = 1;
		self.nLeader = 0;
		nSelectOn = 1;
		nWantedTimerId = Ui.tbLogic.tbTimer:Register(pWantedTime * Env.GAME_FPS, self.OnWantedTaskTimer, self);
		UiManager:AutoEatRed(bAutoRed,bAutoFood);
		UiManager:CloseWindow(self.UIGROUP);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Bật - Tự săn Hải Tặc<color>");
		if me.nTeamId == 0 then
			me.CreateTeam();
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Tự tạo nhóm đi săn")
		end
	else
		Btn_SetTxt(self.UIGROUP, self.BTN_START, "Bắt đầu");
		self.nWantedState = 0;
		self:StopAutoFight();
		Ui.tbLogic.tbTimer:Close(nWantedTimerId);
		nWantedTimerId = 0;
		nArrival = 0;
		nT5 = 0
		self.SK = 0
		self.SKWC = 0
		self.SKJD = 0
		if (nCloseUiTimerId > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
			nCloseUiTimerId = 0;
		end
		UiManager:AutoEatRed(); 
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=white>Tắt - Tự săn Hải Tặc<color>");
		if Map.tbCLosePick.nCPick == 1 then
			Map.tbCLosePick:CLosePick()
		end
	end
end

function uiAutoDaDao:OnWantedTaskTimer()
	local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
	if (nMyMapId <= 0 or nMyPosX <= 0) then
		return;	
	end
	self:GetWantedTaskStatus();
	self:IsMoving();
	self:WantedTaskFlow();
	if ((me.nCurLife*100/me.nMaxLife < 95) or (me.nCurMana*100/me.nMaxMana < 90)) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then
			local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				if 0 == AutoAi.Eat(4) then
					print("AutoAi- No Food...");
				end
			end
		end
	end
end

function uiAutoDaDao:WantedTaskFlow()
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then
		return; 
	end
	local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
	if (nMyMapId <= 0 or nMyPosX <= 0) then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		end
	end
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if (me.IsDead() == 1) and (me.nTeamId > 0) and (nTeamLeader == 1)then
		me.SendClientCmdRevive(0);
		self:StopAutoFight();
		nArrival = 0;
		nYao = 1;
		return;
	end
	if (me.IsDead() == 1) and (status == 3) then
		me.SendClientCmdRevive(0);     
		self:StopAutoFight();
		return;
	end
	if (status == 1) then
		self:FinishConfirm();
	elseif (status == 2) then
		self:GetKillNpcTask(88);
	elseif (status == 3) then
		if (me.IsDead() == 1) then
			me.SendClientCmdRevive(0);
			self:StopAutoFight();
			return;
		end
		if (me.nAutoFightState ~= 1) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
		local nNearby = self:IsNearbyNpcPos();
		if (nNearby == 1 and nWaitTimes < self.tbSetting.nAftWaitTime) then
			nWaitTimes = nWaitTimes + 1;
			return 0;
		end
		self:StopAutoFight();
		
		local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
		if (nMyMapId == 115) and (nMyPosY > 3237) then
			if (me.GetNpc().nIsRideHorse == 0) then
				Switch("horse");
			end
			AutoAi.SetTargetIndex(0);
			me.AutoPath(1639,3158)
			if (nNearby == 0) then
				local _,nWorldPosX,nWorldPosY = me.GetWorldPos();
				me.AutoPath(nWorldPosX,nWorldPosY);
				self:FinishKillNpcTask();
			end
		else
			self:FinishKillNpcTask();
		end
		nWaitTimes = 0;
		nArrival = 0;
	elseif (status == 4) then
		local nNearby = self:IsNearbyNpcPos();
		if (me.IsDead() == 1) and nNearby == 0 then
			me.SendClientCmdRevive(0);
			return;
		end
		self:StopAutoFight();
		self:CloseUiWindow();
		local ndendai
			if me.nRunSpeed < 21 then
				ndendai = 1
			elseif me.nRunSpeed >= 21 and me.nRunSpeed < 24 then
				ndendai = 2
			elseif me.nRunSpeed >= 24 and me.nRunSpeed < 28 then
				ndendai = 3
			elseif me.nRunSpeed >= 28 then
				ndendai = 4
			end
		if (nWaitTimes < ndendai) and self.tbSetting.nDanShua ~= 1 then
			nWaitTimes = nWaitTimes + 1;
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
				UiManager:CloseWindow(Ui.UI_GUTAWARD)
			end
			return 0;
		end

		local nSubTaskId = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
		local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
		self:GoToKillNpcPos(nMapId,nKillNpcId);
		local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
		local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
		local szPosText = string.format("MyPos: <%d,%d,%d>", nMapId, nPosX, nPosY);
	elseif (status == 5) then
		--self:CastAssistSkill();
		nT5 = 0
		self.SK = 0
		self.SKWC = 0
		return;
	elseif (status == 8) then
		nArrival = 1;
		if self.SK == 0 then 
			self.SK = 1
  			self.SKJD = MathRandom(0,7);
			local function fnGO()
				nT5 = nT5 +1
				local nJL = 4
				if me.nLevel < 70 then
					nJL = 3
				end
				if nT5 > nJL or status~= 8 then
					self.SKWC = 1
					nT5 = 0
					status = 6
					self.SK = 0
					return 0;
				end
				
				if self.SKJD == 0 then
					MoveTo(0,0)
				elseif self.SKJD == 1 then
					MoveTo(40,0)
				elseif self.SKJD == 2 then
					MoveTo(16,0)
				elseif self.SKJD == 3 then
					MoveTo(24,0)
				elseif self.SKJD == 4 then
					MoveTo(32,0)
				elseif self.SKJD == 5 then
					MoveTo(48,0)
				elseif self.SKJD == 6 then
					MoveTo(56,0)
				elseif self.SKJD == 7 then
					MoveTo(8,0)
				end

			end
			Ui.tbLogic.tbTimer:Register(3, fnGO);
		end		
	elseif (status == 6) then
		if (me.nFaction == 5 and me.CanCastSkill(98) == 1 and me.nTeamId > 0 and me.nRouteId == 2 ) then
			self:StopAutoFight();
			UseSkill(98);
		else
			nArrival = 1;
			local bChecked = me.GetNpc().IsRideHorse();
			local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
			if (tbSkillInfo.nHorseLimited == 1 and bChecked == 1) then
				Switch([[horse]]);
			end
			if (me.nFaction == 3 and me.nRouteId == 1) and me.GetNpc().nDoing == Npc.DO_SIT then
				if me.CanCastSkill(69) == 1 then
					UseSkill(69);
				end
			end
			if (me.nAutoFightState ~= 1) then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			end
			self:SetKillNpcTarget();
		end	
	elseif (status == 7) then
		local nRedInBag   = self:GetItemCountByName(self.tbRed[self.tbSetting.nRed + 1][2]);
		local nNum = self.tbSetting.nBuyRedNum - nRedInBag;
		self:BuyRed(self.tbRed[self.tbSetting.nRed + 1][2], nNum);
	end
end

function uiAutoDaDao:GetWantedTaskStatus()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskCount  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_COUNT);
	local nTaskFinish = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_FINISH);
	local nRedInBag   = self:GetItemCountByName(self.tbRed[self.tbSetting.nRed + 1][2]);
	local nCountFree  = me.CountFreeBagCell();

	local nMyMapId = me.GetMapTemplateId();
	if me.nPkModel ~= Player.emKPK_STATE_PRACTISE and ((nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0)) then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
	end
	if (nSubTaskId == 0 and nTaskCount == 0) then
		status = 1;	
	elseif (nSubTaskId == 0 and nTaskCount > 0) then
		status = 2;
		self:IsMoving();
		if (nRunning == 1) then
			status = 5;	
		elseif (me.nFightState ~= 1 and nRedInBag < self.tbSetting.nBuyRedNum and nCountFree > 1) then
			status = 7;	
		end
	elseif (nSubTaskId > 0 and nTaskFinish == 0) then
		status = 3;
		self:IsMoving();
		if (nRunning == 1) and me.nAutoFightState ~=1 then
			status = 5;
		end
	elseif (nSubTaskId > 0 and nTaskFinish == 1) then
		local nAtNpcPos = self:IsArrival();
		if (nAtNpcPos == 1 or nArrival == 1) then
			if self.SKWC == 1 or self.tbSetting.nDanShua == 1 or (me.nFaction == 5 and me.nRouteId == 2 ) or (me.nFaction == 3 and me.nRouteId == 1) or (me.nFaction == 1 and me.nRouteId == 2) or me.nFaction == 2 or (me.nFaction == 6 and me.nRouteId == 2) or (me.nFaction == 7 and me.nRouteId == 1) or (me.nFaction == 8 and me.nRouteId == 1) or (me.nFaction == 9 and me.nRouteId == 2) or (me.nFaction == 11 and me.nRouteId == 1) or (me.nFaction == 12 and me.nRouteId == 1) then	-- ��������δ��ɣ����ѵִ�����
				status = 6
			else
				status = 8;	
			end
		elseif (nRunning == 0) and (nYao == 0)  then
			status = 4;
		elseif (nRunning == 0) and (nYao == 1) then
			status = 7;	
		else
			status = 5;
		end
	end
end

function uiAutoDaDao:GoToKillNpcPos(nMapId, nKillNpcId)
	local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
	if (nMyMapId <= 0 or nMyPosX <= 0) then
  		return; 
	end

	if nPL == 1 then
		nPL = 0
	end

	local nX1, nY1 = KNpc.ClientGetNpcPos(nMapId, nKillNpcId);
	local nS = MathRandom(-2,2);
	if self.tbSetting.nDanShua == 1 or (me.nFaction == 1 and me.nRouteId == 2) or me.nFaction == 2 or (me.nFaction == 6 and me.nRouteId == 2) or (me.nFaction == 7 and me.nRouteId == 1) or (me.nFaction == 8 and me.nRouteId == 1) or (me.nFaction == 9 and me.nRouteId == 2) or (me.nFaction == 11 and me.nRouteId == 1) or (me.nFaction == 12 and me.nRouteId == 1) then
		nX1 = nX1 + nS
		nY1 = nY1 + nS
	end
	if nMyMapId == nMapId then
  		me.AutoPath(nX1, nY1);
	else
		local tbPosInfo ={}
		tbPosInfo.szType = "pos"
		tbPosInfo.szLink = "Hải Tặc"..","..nMapId..","..nX1..","..nY1
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
	end
end

function uiAutoDaDao:GetTaskClass()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	local tbMember = me.GetTeamMemberInfo()
	local nMemberCount = #tbMember
	local IsCaptain=1
	for i = 1, #tbMember do
		if tbMember[i].nLeader == 1 then
			IsCaptain=0
		end
	end	
	if me.nTeamId > 0 then
		local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
		if (nTeamLeader == 1 and self.tbSetting.nDanShua == 0 and  nMemberCount ~= 0) then
			nTaskClass = 1;
		elseif (nTeamLeader == 1 and self.tbSetting.nDanShua == 1) then
			nTaskClass = 2;
		elseif (nTeamLeader == 1 and nMemberCount == 0) then
			nTaskClass = 2;
		elseif (nTeamLeader == 0 and self.tbSetting.nDanShua == 0) then
			nTaskClass = 3;
		elseif (nTeamLeader == 0 and self.tbSetting.nDanShua == 1) then
			nTaskClass = 4;
		end
	else
		nTaskClass = 4;
	end
	nFinishTimes = nMemberCount;
end

function uiAutoDaDao:GetKillNpcTask(pLevel)
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
        local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
        local nTaskNpcPosX = self.tbCityMap[self.tbSetting.nCityMapID + 1][3];
        local nTaskNpcPosY = self.tbCityMap[self.tbSetting.nCityMapID + 1][4];
        local nTaskMapLink = {szType = "pos", szLink = ","..nTaskMapID..","..nTaskNpcPosX..","..nTaskNpcPosY};
        local nLevel = self:GetKillNpcLevel(pLevel);
        if (nLevel < 0) then
                return;  
        end
        if (self.tbSetting.nAutoLevel ~= 1) then
                nLevel = (6 - self.tbSetting.nTaskLevelID);
        end
	self:GetTaskClass();
	if (nTaskClass == 1) then
		me.Msg("Săn nhóm")
		if (nWaitTimes < self.tbSetting.nBefWaitTime) then
			nWaitTimes = nWaitTimes + 1; 
			SendChannelMsg("Team",string.format( "Sau "..self.tbSetting.nBefWaitTime.."s tiếp tục đi săn....[%d]", nWaitTimes));
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			if (UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1) then
				UiManager:CloseWindow(Ui.UI_GUTAWARD)
			end
			return 0;
		end
		Map.tbSuperMapLink:StartGoto(nTaskMapLink); 
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(0)
				nSelectOn = 2
			end	
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1)
				nSelectOn = 3
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 3) then
				me.AnswerQestion(0)
				nSelectOn = 4
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end	
		end
	elseif (nTaskClass == 2) then
		me.Msg("Săn đơn")
		Map.tbSuperMapLink:StartGoto(nTaskMapLink); 
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(1)
				nSelectOn = 2
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1)
				nSelectOn = 3
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 3) then
				me.AnswerQestion(0)
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end	
		end
	elseif (nTaskClass == 3) then
		me.Msg("Săn nhóm")
		if nWaitstats == 1 then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			Map.tbSuperMapLink:StartGoto(nTaskMapLink);
			nWaitstats = 2;
		elseif nWaitstats == 0 or nWaitstats == 2 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Phải") then
						me.AnswerQestion(i-1);
						SendChannelMsg("Team", "Đã nhận nhiệm vụ truy nã");
					end
				end
			end
		end
	elseif (nTaskClass == 4) then
		me.Msg("Săn đơn")
		Map.tbSuperMapLink:StartGoto(nTaskMapLink); 
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(0);
				nSelectOn = 2
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1);
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
		end
	end
end

function uiAutoDaDao:FinishKillNpcTask()
        local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
        if (nMyMapId <= 0 or nMyPosX <= 0) then	
	        return;	
        end
        local nCountFree = me.CountFreeBagCell();
        if (nCountFree == 0) then
                AutoAi.Eat(1); 
        end

	if nPL == 0 then
		AutoAi:SwitchAutoThrowAway2()
		nPL = 1
	end

        local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
        local nTaskNpcPosX = self.tbCityMap[self.tbSetting.nCityMapID + 1][3];
        local nTaskNpcPosY = self.tbCityMap[self.tbSetting.nCityMapID + 1][4];
        local nTaskMapLink = {szType = "pos", szLink = ","..nTaskMapID..","..nTaskNpcPosX..","..nTaskNpcPosY};
        Map.tbSuperMapLink:StartGoto(nTaskMapLink); 
        local nId = uiAutoDaDao:GetAroundNpcId(2994);
	if nId then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			AutoAi.SetTargetIndex(nId)
		end
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		end
		if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
			local uiGutAward = Ui(Ui.UI_GUTAWARD)
			uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
			UiManager:CloseWindow(Ui.UI_GUTAWARD)
		end
		SendChannelMsg("Team", "Đã trả nhiệm vụ truy nã");
		nWaitstats = 1
		nSelectOn = 1
	end
end

uiAutoDaDao.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 15);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end

function uiAutoDaDao:GetKillNpcLevel(pLevel)
	local nLevel = 0;
	nLevel = math.floor(pLevel/10) - 3; 
	if (nLevel > 6) then
		nLevel = 6;
	end
	return nLevel;
end

function uiAutoDaDao:GetWantedTaskInfo(nSubTaskId)
	local pTabFile	= KIo.OpenTabFile("\\interface2\\All\\worldmap.txt");
	local nKillID	= math.mod(nSubTaskId,50000) + 2;
	local nTaskName	= pTabFile.GetStr(nKillID,2);
	local nMapId	= pTabFile.GetInt(nKillID,4);
	local nPosX	= pTabFile.GetInt(nKillID,5);
	local nPosY	= pTabFile.GetInt(nKillID,6);
	local nKillNpcId	= pTabFile.GetInt(nKillID,8);
	KIo.CloseTabFile(pTabFile);
	return nTaskName, nMapId, nKillNpcId, nPosX, nPosY;
end

function uiAutoDaDao:IsNearbyNpcPos()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = self:GetNpcDistance();
	if (nMapId == nMyMapId and nDistance < 20) then
		return 1;
	end
	return 0;
end

function uiAutoDaDao:IsArrival()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = self:GetNpcDistance();
	if (nMapId == nMyMapId and nDistance < 5) then
		return 1;
	end
	return 0;
end

function uiAutoDaDao:GetNpcDistance()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = math.sqrt((nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2);
	return nDistance;
end

function uiAutoDaDao:IsMoving()
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		nRunning = 1;
	else
		nRunning = 0;
	end
end

function uiAutoDaDao:GetAssistSkillId()
	local tbAssistSkill = { 26, 46, 55, 115, 132, 161, 177, 180, 191, 219, 230, 697, 783};
	for _, nSkillId in ipairs(tbAssistSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			return 	nSkillId;
		end
	end
	return 0;
end

function uiAutoDaDao:CastAssistSkill()
	if (me.nFightState == 1) then
		local nSkillId = self:GetAssistSkillId();
		if (nSkillId > 0) then
			local _, _, nRestTime	= me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < Env.GAME_FPS) then
				AutoAi:Pause();
				AutoAi.AssistSelf(nSkillId);
				Timer:Register(Env.GAME_FPS * 1, AutoAi.DelayResumeAi, AutoAi);
			end
		end
	end
end

function uiAutoDaDao:MoveToSafePos()
	AutoAi.SetTargetIndex(0);
	self:RideHorse();
	local nCurMapId  = me.GetWorldPos();
	local szInfoFile = Map.tbSuperMapLink.tbAllMapInfo[nCurMapId].szInfoFile;
	local tbFileData = Lib:LoadTabFile("\\setting\\map\\map_info\\" .. szInfoFile .. "\\info.txt");
	for nRowNum, tbRow in ipairs(tbFileData or {}) do
		if (tbRow.NpcTemplateId == "2525") then
			local bSuccess = me.AutoPath(tonumber(tbRow.XPos)/32+MathRandom(-10, 10), tonumber(tbRow.YPos)/32+MathRandom(-10, 10));
			break;
		end
	end
end

function uiAutoDaDao:SetKillNpcTarget()
	local nSubTaskId = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId = self:GetWantedTaskInfo(nSubTaskId);
	local nTargetIndex = self:GetAroundNpcTargetIndex(nKillNpcId);
	AutoAi.SetTargetIndex(nTargetIndex);
end

function uiAutoDaDao:RideHorse()
	local bChecked = me.GetNpc().IsRideHorse();	
	if (bChecked == 0) then
		Switch([[horse]]);
	end
end

function uiAutoDaDao:GetDownHorse()
	local bChecked = me.GetNpc().IsRideHorse(); 
	if (bChecked == 1) then
		Switch([[horse]]);
	end
end

function uiAutoDaDao:GetItemCountByName(szName)
	local g;
	local d;
	local p;
	local l;
	local pTabFile = KIo.OpenTabFile("\\setting\\item\\001\\other\\medicine.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 2, nHeight do
		local name = pTabFile.GetStr(i, 1);
		if name == szName then
			g = pTabFile.GetInt(i, 3);
			d = pTabFile.GetInt(i, 4);
			p = pTabFile.GetInt(i, 5);
			l = pTabFile.GetInt(i, 6);
			break;
		end
	end
	KIo.CloseTabFile(pTabFile);
	return me.GetItemCountInBags(g,d,p,l);
end

function uiAutoDaDao:BuyRed(szName,nNum)
        me.Msg("Dược phẩm" .. string.format(self.tbSetting.nBuyRedNum));
	local nCountFree = me.CountFreeBagCell();
	if (nNum >= nCountFree) then
		nNum = nCountFree - 1;
	end
	local uId = uiAutoDaDao.STUFF_LIST[szName][3];	
	local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
	local szLink = ","..nTaskMapID..",3564,1";	
	local pItem = KItem.GetItemObj(uId);
	if (pItem and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		me.ShopBuyItem(uId, nNum);
		nYao = 0;
		if (nCloseUiTimerId == 0) then
			nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
		end
	else
		UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
	end
end

function uiAutoDaDao:CloseUiWindow()
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

function uiAutoDaDao:StopAutoFight()
	AutoAi.SetTargetIndex(0);
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function uiAutoDaDao:SetDeathRevivePos(nCityMapId)
	local nMapId = 26;
	if (nCityMapId) then
		nMapId = nCityMapId;
	end
	local szLink = ","..nMapId..",2599,1";	
	UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
end

function uiAutoDaDao:GetAroundNpcTargetIndex(nTemplateId)
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTemplateId) then
			return pNpc.nIndex;
		end
	end
	return 0;
end

function uiAutoDaDao:FinishConfirm()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID); 
	local nTaskCount  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_COUNT);
	local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
--	local nDistance = math.sqrt((nTaskNpcPosX-nMyPosX/8)^2 + (nTaskNpcPosY-nMyPosY/16)^2);
	if (nSubTaskId == 0 and nTaskCount == 0 and me.nAutoFightState ~= 1 and nMyMapId == self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
		-- me.Msg("<color=green>Nhiệm vụ truy nã Hải Tặc hôm nay đã hết");
		local nAllotModel, tbMemberList = me.GetTeamInfo();
        if (self.tbSetting.CHK_LBVD == 1  and me.nTeamId > 0) then
			uiAutoDaDao:HaiTacOff()
			UiManager:StartBao();
		elseif (self.tbSetting.CHK_Thoat == 1  and me.nTeamId > 0) then
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
			Exit();	
		elseif (self.tbSetting.CHK_Luyen == 1  and me.nTeamId > 0) then
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
			UiManager:StartGua();
		else
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
		end	
	end	
end


function uiAutoDaDao:TeamLeave()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if tbMemberList == nil then
		return;
	end
	me.TeamLeave();
	self:ClearTeamLeader();
end

function uiAutoDaDao:ClearTeamLeader()
	tbTeamLeader = {};
end

self:Init();

function uiAutoDaDao:Test()
	local nCityMapTxt = self.tbCityMap[self.tbSetting.nCityMapID + 1][1];
	me.Msg("Thời gian chờ trước khi nhận nhiệm vụ:<color=white> " .. string.format(self.tbSetting.nBefWaitTime));
	me.Msg("Thời gian chờ sau khi nhận nhiệm vụ:<color=white> " .. string.format(self.tbSetting.nAftWaitTime));
	me.Msg("Số lượng máu cần mua:<color=white> " .. string.format(self.tbSetting.nBuyRedNum));
	me.Msg("Cấp nhiệm vụ:<color=white> " .. string.format((6 - self.tbSetting.nTaskLevelID)*10+45));
	me.Msg("Thành nhận/trả nhiệm vụ: <color=white> " .. string.format(nCityMapTxt));
	--me.Msg("cap thuoc" .. string.format(self.tbSetting.nRed));
	--me.Msg("ID phu" .. self.tbCityMap[self.tbSetting.nCityMapID + 1][2]);
	me.Msg("Mua mau:<color=white> " .. self.tbRed[self.tbSetting.nRed + 1][2]);
	if self.tbSetting.CHK_LBVD == 1 then
		SysMsg("<color=yellow>Lam xong HT se lam BVD");
	elseif self.tbSetting.CHK_Thoat == 1 then
		SysMsg("<color=yellow>Lam xong HT se thoat");
	elseif self.tbSetting.CHK_Luyen == 1 then
		SysMsg("<color=yellow>Lam xong HT se di luyen");
	end
end

function uiAutoDaDao.Reload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\AutoThief\\AutoThief.lua");
	me.Msg("<bclr=0,0,200><color=white>Tự động tải lại hoàn thành<color><bclr><color=yellow> " .. GetLocalDate("%d-%m-%Y %H:%M:%S"));
end

LoadUiGroup(Ui.UI_AUTODADAO, "AutoThief.ini");