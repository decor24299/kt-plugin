Ui.UI_TOOLS1				= "UI_TOOLS1";
local uiTools1				= Ui.tbWnd[Ui.UI_TOOLS1] or {};	
uiTools1.UIGROUP			= Ui.UI_TOOLS1;
Ui.tbWnd[Ui.UI_TOOLS1] 		= uiTools1
-------------
uiTools1.BUTTON_FUDAI_ONE	="BtnFuDai"
uiTools1.BUTTON_FUDAI_TWO	="BtnFuDaiWX"
uiTools1.BUTTON_READ		="BtnRead"
uiTools1.BTN_AutoRou		="BtnAutoRou"	
uiTools1.BTN_AutoFoodz		="BtnAutoFoodz"

------------------------------------------

------------------------------------------

local tbTimer 				= Ui.tbLogic.tbTimer;
local BTNSuperMapLink		= "BtnSuperMapLink"
local self					= uiTools1;

local bAutoFoodz=0;
self.BtnAutoFoodzKbn		= 0;
self.BtnAutoRouKbn 			= 0;
self.BtnReadKbn 			= 0;
self.BtnAutoFDKbn 			= 0;
self.BtnAutoFDWXKbn 		= 0;

-----------------------------

-----------------------------

Ui:RegisterNewUiWindow("UI_TOOLS1", "Tools1", {"a", 768, 180}, {"b", 992, 322}, {"c", 1252, 382});

-----------------------------

uiTools1.EnterGame_bak    = uiTools1.EnterGame_bak or Ui.EnterGame;

function Ui:EnterGame()
	uiTools1.EnterGame_bak(Ui);	
	
end
-----------------------------
-----------------------------
self.nRead=1;
self.nAutoRou=1;
self.nAutoFoodz=1;
self.nAutoFD=0;     
self.nAutoFDWX=1;  

self.Rtime1=0;
self.Rtime2=0;
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;  
self.nSec6=0;
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0; 
self.nYe6=0; 
self.nRelayTime1 =60;
self.nRelayTime2 =60; 
self.nNum=0
self.X1=0;
self.Y1=0;
self.X2=0;
self.Y2=0;
self.TimeLost=0;
self.IsRead=0;
self.BookNum=0;
self.read_now=0;
self.Move_Time=0;

self.nTime = 5;
self.nTimerId=0;
self.tbOptionSetting = {};

uiTools1.OnOpen=function(self)
 	tbTimer:Register(Env.GAME_FPS*2, self.OnTimer, self);
	tbTimer:Register(Env.GAME_FPS, self.LoadSetting, self);
	local tbSetting=self:Load("OptionSetting");
	if not tbSetting then
		tbSetting = {};
	end
	if tbSetting.nRead then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_READ, tbSetting.nBack);
	end
	if tbSetting.nAutoFD then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_FUDAI_ONE, tbSetting.nBack);
	end
	if tbSetting.nAutoFDWX then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_FUDAI_TWO, tbSetting.nBack);
	end
	if tbSetting.nAutoRou then
		Btn_Check(self.UIGROUP, uiTools1.BTN_AutoRou, tbSetting.nBack);
	end
	if tbSetting.nAutoFoodz then
		Btn_Check(self.UIGROUP, uiTools1.BTN_AutoFoodz, tbSetting.nBack);
	end

end

uiTools1.LoadSetting=function(self)
	local tbFightSetting = self:Load("OptionSetting");
	if not tbFightSetting then
		tbFightSetting = {};
	end
	if tbFightSetting.nRead 		then			self.nRead 		= 	tbFightSetting.nRead;				end		
	if tbFightSetting.nAutoFD 		then			self.nAutoFD	= 	tbFightSetting.nAutoFD;				end  	
	if tbFightSetting.nAutoRou 		then			self.nAutoRou 	= 	tbFightSetting.nAutoRou;			end		
	if tbFightSetting.nAutoFDWX 	then			self.nAutoFDWX 	= 	tbFightSetting.nAutoFDWX;			end	
	if tbFightSetting.nAutoFoodz 	then			self.nAutoFoodz =	tbFightSetting.nAutoFoodz;			end	
	
	
	if self.nRead then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_READ, self.nRead);
	end
	if self.nAutoFD then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_FUDAI_ONE, self.nAutoFD);
	end
	if self.nAutoFDWX then
		Btn_Check(self.UIGROUP, uiTools1.BUTTON_FUDAI_TWO, self.nAutoFDWX);
	end
	if self.nAutoRou then
		Btn_Check(self.UIGROUP, uiTools1.BTN_AutoRou, self.nAutoRou);
	end
	if self.nAutoFoodz then
		Btn_Check(self.UIGROUP, uiTools1.BTN_AutoFoodz, self.nAutoFoodz);
	end
	
end

uiTools1.SaveData=function(self)
	self.tbOptionSetting = {
		nRead= self.nRead,
		nAutoFD=self.nAutoFD,
		nAutoFDWX=self.nAutoFDWX,
		nAutoRou=self.nAutoRou,
		nAutoFoodz=self.nAutoFoodz,

		}
	self:Save("OptionSetting", self.tbOptionSetting);
end

uiTools1.OnButtonClick_Bak = uiTools1.OnButtonClick;

uiTools1.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_AutoFoodz) then		   
		if self.BtnAutoFoodzKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ngừng tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 0;
	end
	self.nAutoFoodz=nParam
	self:SaveData()
	
----------------------------------------------------------------------------------		
	elseif (szWnd == self.BTN_AutoRou) then
		if self.BtnAutoRouKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động ăn thịt và Tinh hoạt khí<color>");
			self.BtnAutoRouKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động ăn thịt và Tinh hoạt khí<color>");
			self.BtnAutoRouKbn = 0;
	end
	self.nAutoRou=nParam
	self:SaveData()
	
----------------------------------------------------------------------------------
	elseif (szWnd == self.BUTTON_FUDAI_ONE) then		
		if (self.BtnAutoFDKbn == 0 and self.BtnAutoFDWXKbn == 0) or (self.BtnAutoFDKbn == 0 and self.BtnAutoFDWXKbn == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động mở túi phúc giới hạn<color>");
			self.BtnAutoFDKbn = 1;
			self.BtnAutoFDWXKbn = 0;
	elseif (self.BtnAutoFDKbn == 1 and self.BtnAutoFDWXKbn == 1) or (self.BtnAutoFDKbn == 1 and self.BtnAutoFDWXKbn == 0) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động mở túi phúc giới hạn<color>");
			self.BtnAutoFDKbn = 0;
			self.BtnAutoFDWXKbn = 0;
	end
	self.nAutoFD=nParam
	self.nAutoFDWX=0
	self:SaveData()
		if nParam==1 then
			Btn_Check(self.UIGROUP, self.BUTTON_FUDAI_TWO,self.nAutoFDWX,0);
		end
		
	elseif (szWnd == self.BUTTON_FUDAI_TWO) then		
		if (self.BtnAutoFDWXKbn == 0 and self.BtnAutoFDKbn == 0) or (self.BtnAutoFDWXKbn == 0 and self.BtnAutoFDKbn == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động mở túi phúc không giới hạn<color>");
			self.BtnAutoFDWXKbn = 1;
			self.BtnAutoFDKbn = 0;
	elseif (self.BtnAutoFDWXKbn == 1 and self.BtnAutoFDKbn == 1) or (self.BtnAutoFDWXKbn == 1 and self.BtnAutoFDKbn == 0) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động mở túi phúc không giới hạn<color>");
			self.BtnAutoFDWXKbn = 0;
			self.BtnAutoFDKbn = 0;
	end
	self.nAutoFDWX=nParam
	self.nAutoFD=0
	self:SaveData()
		if nParam==1 then
			Btn_Check(self.UIGROUP, self.BUTTON_FUDAI_ONE,0);
		end
----------------------------------------------------------------------------------
	elseif (szWnd == self.BUTTON_READ) then		
		if self.BtnReadKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động Đọc sách<color>");
			self.BtnReadKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động Đọc sách<color>");
			self.BtnReadKbn = 0;
		end
		self.nRead=nParam
		self:SaveData()
----------------------------------------------------------------------------------		
	
----------------------------------------------------------------------------------		
	end
end

uiTools1.CheckErrorData=function(self,szDate)
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

uiTools1.Save=function(self,szKey, tbData)
	self.m_szFilePath="\\user\\tools1\\"..me.szName..".dat";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

uiTools1.Load=function(self,key)
	self.m_szFilePath="\\user\\tools1\\"..me.szName..".dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then		
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
	return tbData
end

uiTools1.Reading=function(self)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	self:BookInfo();
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 then
		self:Read_book_szbf();
	end
	if self.nSec0 > self.nSec2 and self.nYe2<10 then
		self:Read_book_mjjgs();
	end
	if self.nSec0 > self.nSec3 and self.nYe3<10 then
		self:Read_book_wmys();
	end
	if self.nSec0 > self.nSec4 and self.nYe4<10 then
		self:Read_book_ggds();
	end
	if self.nSec0 > self.nSec5 and self.nYe5<10 then
		self:Read_book_bfsslj();
	end
	if self.nSec0 > self.nSec6 and self.nYe6<10 then
		self:Read_book_qym();
	end
end

 uiTools1.Read_book_szbf=function(self)
	if (me.nLevel >= 90) then
		local nBingShuCount = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
		if (nBingShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,298,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Tôn Tử Binh Pháp<color><bclr>");
			end
		end
	end
end

 uiTools1.Read_book_mjjgs=function(self)
	if (me.nLevel >= 90) then
		local nJiGuanShuCount = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
		if (nJiGuanShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,299,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Mặc Gia Cơ Quan Thuật<color><bclr>");
			end
		end
	end
end

 uiTools1.Read_book_ggds=function(self)
	if (me.nLevel >= 110) then
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Quỷ Cốc Đạo Thuật<color><bclr>");
		end
	end
end
 uiTools1.Read_book_wmys=function(self)
	if (me.nLevel >= 110) then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Võ Mục Di Thư<color><bclr>");
		end
	end
end
uiTools1.Read_book_bfsslj=function(self)
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.BookNum=5;
			Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Binh Pháp 36 Kế<color><bclr>");
		end
	end
end

uiTools1.Read_book_qym=function(self)
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.BookNum=6;
			Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow>Khuyết Nhất Môn<color><bclr>");
		end
	end
end

--#STC Doc sach 130 (End)
 uiTools1.BookInfo=function(self)
	local tbFind = me.FindItemInBags(20,1,298,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe1=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec1 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,299,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe2=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec2 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,544,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe3=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec3 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,545,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe4=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec4 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

--#STC: Doc sach level 130+ (Checking hoahongnet's codes)
	local tbFind = me.FindItemInBags(20,1,809,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe5=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec5 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,810,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe6=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec6 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end
--#STC: Doc sach level 130+ (End of Checking hoahongnet's codes)
end
uiTools1.Use_LuckBag=function(self)
	local nFuCount = me.GetTask(2013, 1); 
	local nFuDate = me.GetTask(2013, 2); 
	local nFuLimit = me.GetTask(2013, 3); 
	local nDay = tonumber(os.date("%y%m%d", nNowDate));
	if (nFuDate < nDay) then
			nFuCount = 0;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
  		return
  	end	
	if (self.nAutoFD==1 and self.nAutoFDWX~=1) then
		if (nFuCount < nFuLimit) then
			local tbFind = me.FindItemInBags(18,1,80,1);--Túi Phúc Hoàng Kim
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		end
	elseif (self.nAutoFDWX==1 and self.nAutoFD ~=1) then
		local tbFind = me.FindItemInBags(18,1,80,1);--Túi Phúc Hoàng Kim
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			if (nFuCount == nFuLimit) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
						me.AnswerQestion(0);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					return 0;
				end
				-- Ui.tbLogic.tbTimer:Register(18, fnCloseSay);
			end
			return 1;
		end
	end
	local tbFind = me.FindItemInBags(18,1,193,1);--Túi quân hưởng (cấp 90)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,285,1);--Túi quân hưởng (cấp 110)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,336,1);--Túi quân hưởng (cấp 130)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	
	if self.BtnAutoRouKbn == 1 then
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return
		end	
	
		local tbFind = me.FindItemInBags(20,1,488,1);--Thịt bò chín
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			return 0;
		end
	
		local tbFind = me.FindItemInBags(20,1,488,2);--Chim cút quay
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			return 0;
		end
	
		local tbFind = me.FindItemInBags(18,1,89,1);--Tinh Khí Tán (500)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	
		local tbFind = me.FindItemInBags(18,1,90,1);--Hoạt Khí Tán (500)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	
		local tbFind = me.FindItemInBags(18,1,89,2);--Tinh Khí Tán (1000)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	
		local tbFind = me.FindItemInBags(18,1,90,2);--Hoạt Khí Tán (1000)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	
		local tbFind = me.FindItemInBags(18,1,89,3);--Tinh Khí Tán (1500)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	
		local tbFind = me.FindItemInBags(18,1,90,3);--Hoạt Khí Tán (1500)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,113,1);--Ốc biển truyền thanh (tiểu)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,113,2);--Ốc biển truyền thanh (trung)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,113,3);--Ốc biển truyền thanh (đại)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,71,1);--Bạch Câu Hoàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,71,2);--Đại Bạch Câu Hoàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,71,3);--Cường Hiệu Bạch Câu Hoàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,71,4);--Đặc Hiệu Bạch Câu Hoàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		
		local tbFind = me.FindItemInBags(18,1,20260,1);--Rương hoàng kim (Phúc duyên đạt 110)
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
  	end
	
	if self.BtnAutoFoodzKbn == 1 then
		uiTools1.AutoFoodz();
		local tbFind = me.FindItemInBags(18,1,313,1);--[Thẻ kích sát] Sói chúa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,2);--[Thẻ kích sát] Gấu chúa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,3);--[Thẻ kích sát] Hổ chúa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,4);--[Thẻ kích sát] Cá sấu lớn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,5);--[Thẻ kích sát] Khỉ chúa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,6);--[Thẻ kích sát] Ngựa chúa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,7);--[Thẻ kích sát] Dị Thú
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,8);--[Thẻ kích sát] Sát Đại Mục
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,9);--[Thẻ kích sát] U Minh Quỷ Vương
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,10);--[Thẻ kích sát] Thống Lĩnh Ngụy Quân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,11);--[Thẻ kích sát] Thống Lĩnh Ngô Quân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,12);--[Thẻ kích sát] Giám Quân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,13);--[Thẻ kích sát] Tử Uyển
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,14);--[Thẻ kích sát] Tần Trọng
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,15);--[Thẻ kích sát] Nhậm Diễu
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,16);--[Thẻ kích sát] Tiêu Bất Thực
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,17);--[Thẻ kích sát] Mộc Siêu
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,18);--[Thẻ kích sát] Hạ Tiểu Sảnh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,19);--[Thẻ kích sát] Hồ Khôn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,20);--[Thẻ kích sát] Mặc Quân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,21);--[Thẻ kích sát] Đường Vũ
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,22);--[Thẻ kích sát] Hồ Càn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,23);--[Thẻ kích sát] Diệp Tịnh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,24);--[Thẻ bảo vật] Huyết Ảnh Thương
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,25);--[Thẻ bảo vật] Linh Thú Chiến Ngoa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,26);--[Thẻ bảo vật] Độn Giáp Linh Phù
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,27);--[Thẻ bảo vật] Tử Tinh Huyễn Bội
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,28);--[Thẻ bảo vật] Thất Thái Tiên Đơn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,29);--[Thẻ bí bảo] Tà Linh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,30);--[Thẻ bí bảo] Thánh Ngấn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,31);--[Thẻ bí bảo] Băng Liên
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,32);--[Thẻ vượt ải] Trí Dũng Song Toàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,33);--[Thẻ vượt ải] Xà Huyệt Thoát Hiểm
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,34);--[Thẻ vượt ải] Trợ Nhân Vi Lạc
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,35);--[Thẻ vượt ải] Hậu Sinh Khả Úy
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,36);--[Thẻ vượt ải] Đại Sư Đào Thoát
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,37);--[Thẻ kích sát] Cơ Quan Phủ Thủ
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,38);--[Thẻ kích sát] Phản Quân Thống Lĩnh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,39);--[Thẻ kích sát] Quả Nông
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,40);--[Thẻ kích sát] Cơ Quan Cự Lang
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,41);--[Thẻ kích sát] Thủ Lĩnh Cường Đạo
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,42);--[Thẻ kích sát] Vượng Tài
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,43);--[Thẻ bí bảo] Oán Linh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,44);--[Thẻ bí bảo] Tuyết Tinh Thạch
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,45);--[Thẻ vượt ải] Thử Địa Vô Ngân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,46);--[Thẻ vượt ải] Hộ Hoa Sứ Giả
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,47);--[Thẻ vượt ải] Thoát Khỏi Vòng Vây
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,48);--[Thẻ vượt ải] Hầu Khẩu Đoạt Thực
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,49);--[Thẻ kích sát] Trương Đức Hằng
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,50);--[Thẻ vượt ải] Bái phục
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,51);--[Thẻ vượt ải] Đồng Tâm
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,52);--[Thẻ vượt ải] Tam Quân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,53);--[Thẻ vượt ải] Lấy lại quân uy
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,54);--[Thẻ vượt ải] Thoát chết
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,55);--[Thẻ kích sát] Bảo Ngọc
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,56);--[Thẻ kích sát] Oanh Oanh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,57);--[Thẻ kích sát] Hỏa Bồng Xuân
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,58);--[Thẻ kích sát] Phong Tuyết Tình
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,59);--[Thẻ kích sát] Mộ Dung Tố
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,60);--[Thẻ kích sát] Tạ Vô Kỵ
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,61);--[Thẻ kích sát] Ngân Hoa Bà Bà
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,62);--[Thẻ kích sát] Hỷ Đa Đa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,63);--[Thẻ kích sát] Hàn Đan
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,64);--[Thẻ kích sát] Trịnh Vũ Hoa
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,65);--[Thẻ kích sát] Diệp Toàn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,66);--[Thẻ vượt ải] Dục Hỏa Trùng Sinh
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,313,67);--[Thẻ kích sát] Độc Cô Kiếm
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbFind = me.FindItemInBags(18,1,314,1);--[Thẻ đặc biệt] Biến Huyễn
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
		local tbItem = me.FindItemInBags(18,1,71,2)[1] 
		if tbItem and IsUseBaiJuWan==1 then
			me.UseItem(tbItem.nRoom, tbItem.nX, tbItem.nY);
		end
	end
end

uiTools1.GetRunSkillId=function(self)
	local tbAssistSkill1	= {861, 115, 132, 177, 230, 180, 697, 26, 161, 46, 55, 783, 835, 219};
	for _, nSkillId in ipairs(tbAssistSkill1) do
		if (me.CanCastSkill(nSkillId) == 1) then
			return 	nSkillId;
		end
	end
	return 0;
end

uiTools1.GetRunSkillId2=function(self)
	local tbAssistSkill1	= {1249, 1261, 191};
	for _, nSkillId in ipairs(tbAssistSkill1) do
		if (me.CanCastSkill(nSkillId) == 1) then
			return 	nSkillId;
		end
	end
	return 0;
end

uiTools1.AutoFoodz=function(self)
	if(not bAutoFoodz) then
		return;
	end
	
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if (not nTime or nTime < Env.GAME_FPS * 3)  then
		uiTools1.EatFoodz();
	end	
end

uiTools1.EatFoodz=function(self)
	local tbItemList = me.FindItemInBags(Item.SKILLITEM);
	if((not tbItemList) or (#tbItemList == 0)) then
		return false;
	end
	local pItem = tbItemList[1].pItem;
	if(me.CanUseItem(pItem)) then
		me.Msg("Sử dụng thức ăn <color=yellow>" .. pItem.szName .. "<color>");
		return me.UseItem(pItem);
	end
	return false;
end

uiTools1.OnTimer=function(self)
	self:Use_LuckBag();
	if self.nRead==1 then
		local nLinhKien = 0;
		for i = 1, 10 do
 		local nSotay = me.GetTask(2044, i);
	  		nLinhKien = nLinhKien + nSotay;
		end
		if self.nRead==1 and nLinhKien < 10 then
			local tbFind = me.FindItemInBags(20,1,484,1);
			for j, tbItem in pairs(tbFind) do
 	  			me.UseItem(tbItem.pItem);
 	    			return 1;
			end
		end
		if me.nFightState==0 then
			self.Rtime1=self.Rtime1+1;
			if math.mod(self.Rtime1,20)==0 then
				self.Rtime1=0;
				self:Reading();
			end
		end
	end
	if self.nAutoRou==1 and self.BtnAutoRouKbn == 0 then 
	  self.BtnAutoRouKbn = 1;
	end
	
	if self.nRead==1 and self.BtnReadKbn == 0 then 
	  self.BtnReadKbn = 1;
	end
	
	if self.nAutoFD==1 and self.BtnAutoFDKbn == 0 then 
	  self.BtnAutoFDKbn = 1;
	end
	
	if self.nAutoFDWX==1 and self.BtnAutoFDWXKbn == 0 then 
	  self.BtnAutoFDWXKbn = 1;
	end
	
	if self.nAutoAuxil==1 and self.BtnAutoAuxilKbn == 0 then 
	  self.BtnAutoAuxilKbn = 1;
	end
	
	if self.nAutoFoodz==1 and self.BtnAutoFoodzKbn == 0 then 
	  self.BtnAutoFoodzKbn = 1;
	end
	
	if self.nAutoDie==1 and self.BtnAutoDieKbn == 0 then 
	  self.BtnAutoDieKbn = 1;
	end
	
	
end
