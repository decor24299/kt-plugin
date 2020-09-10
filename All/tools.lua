--- Thanh Tools - di chuyển nhanh ---
Ui.UI_TOOLS		= "UI_TOOLS";
local uiTools			= Ui.tbWnd[Ui.UI_TOOLS] or {};	
uiTools.UIGROUP		= Ui.UI_TOOLS;
Ui.tbWnd[Ui.UI_TOOLS] = uiTools
-------------
uiTools.BTN_BackTrack		="BtnBackTrack"	
--------Các Menu
local BTN_DEAD				="BtnDEAD"
uiTools.BTN_Map11x			="BtnMap11x"
uiTools.BTN_Map10x			="BtnMap10x" 
uiTools.BTN_Map9x			="BtnMap9x"
uiTools.BTN_Map8x			="BtnMap8x"
uiTools.BTN_Map7x			="BtnMap7x"
uiTools.BTN_Map6x			="BtnMap6x"
uiTools.BTN_Map5x			="BtnMap5x"
uiTools.BTN_Map4x			="BtnMap4x" 
uiTools.BTN_Map3x			="BtnMap3x"
uiTools.BTN_Map2x			="BtnMap2x"
uiTools.BTN_Map1x			="BtnMap1x"
------------------------------------------
uiTools.BTN_MONPHAI		    ="BtnMonPhai"
uiTools.BTN_THONXOM			="BtnThonXom"
uiTools.BTN_NPC             = "BtnNPC"
uiTools.BTN_ThuKho          = "BtnThuKho"
uiTools.BTN_DaLuyenDaiSu 	= "DaLuyenDaiSu"
uiTools.BTN_ThanhTool		="BtnThanhTool"
--------------------
uiTools.BTNgohome	        = "Btngohome"
local tbTimer 				= Ui.tbLogic.tbTimer;
local BTNSuperMapLink		= "BtnSuperMapLink"
local self					= uiTools;

Ui:RegisterNewUiWindow("UI_TOOLS", "tools", {"a", 310, 468}, {"b", 372, 614}, {"c", 392, 32});
	
uiTools.tbAllModeResolution	= {
	["a"]	= { 210, 54 },
	["b"]	= { 430, 5 },
	["c"]	= { 392, 32 },
};
uiTools.gohome =
{ 
	{" Mình Về "},
	{" Chip Về "},
	{" Cả pt Về "},
	
};
uiTools.Map11x =
{ 
	{" Mông Cổ Vương Đình "},
	{" Nguyệt Nha Tuyền "},
	{" Tàn Tích Cung A Phòng "},
	{" Lương Sơn Bạc "},
	{" Thần Nữ Phong "},
	{" Tàn Tích Dạ Lang "},
	{" Cổ Lãng Dữ "},
	{" Đào Hoa Nguyên "},
};
uiTools.Map10x =
{ 
	{" Mạc Bắc Thảo Nguyên "},
	{" Đôn Hoàng Cổ Thành "},
	{" Hoạt Tử Nhân Mộ "},
	{" Đại Vũ Đài "},
	{" Tam Hiệp Sạn Đạo "},
	{" Xi Vưu Động "},
	{" Tỏa Vân Uyên "},
	{" Phục Lưu Động "},
};
uiTools.Map9x =
{ 
	{" Sắc Lặc Xuyên "},
	{" Gia Du Quan "},
	{" Hoa Sơn "},
	{" Thục Cương Sơn "},
	{" Phong Đô Quỷ Thành "},
	{" Miêu Lĩnh "},
	{" Vũ Di Sơn "},
	{" Vũ Lăng Sơn "},
};
uiTools.Map8x =
{ 
	{" Long Môn Thạch Quật "},
	{" Hoàng Lăng Tây Hạ "},
	{" Hoàng Hạc Lâu "},
	{" Tiến Cúc Động "},
	{" Kiếm Môn Quan "},
	{" Thiên Long Tự "},
	{" Bang Nguyên Bí Động "},
};
uiTools.Map7x =
{ 
	{" Phong Lăng Độ "},
	{" Mê Cung Sa Mạc "},
	{" Kê Quán Động "},
	{" Thục Cương Sơn "},
	{" Kiếm Các Thục Đạo "},
	{" Hoàng Lăng Đoàn Thị "},
	{" Cửu Nghi Khê "},
};
uiTools.Map6x =
{ 
	{" Cư Diên Trạch "},
	{" Phục Ngưu Sơn "},
	{" Hổ Khâu Kiếm Tri "},
	{" Hưởng Thủy Động "},
	{" Điểm Thương Sơn "},
	{" Bành Lãi Cổ Trạch "},
};
uiTools.Map5x =
{ 
	{" Thái Hành Cổ Kính "},
	{" Đại Tán Quan "},
	{" Hán Thủy Cổ Độ "},
	{" Hàn Sơn Cổ Sát "},
	{" Cán Hoa Khê "},
	{" Nhĩ Hải Ma Nham "},
	{" Thái Thạch Cơ "},
};
uiTools.Map4x =
{ 
	{" Tây Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 2 "},
	{" Mê Cung Băng Huyệt 2 "},
	{" Tây Long Hổ Huyễn Cảnh "},
	{" Giữa Yến Tử Ổ "},
	{" Cửu Lão Động 2 "},
	{" Trong Bách Hoa Trận "},
	{" Tây Bờ Hồ Trúc Lâm "},
	{" Tây Rừng Nguyên Sinh "},
	{" Tây Bắc Lư Vĩ Đãng "},
};
uiTools.Map3x =
{ 
	{" Đông Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 1 "},
	{" Mê Cung Băng Huyệt 1 "},
	{" Đông Long Hổ Huyễn Cảnh "},
	{" Ngoài Yến Tử Ổ "},
	{" Cửu Lão Động 1 "},
	{" Ngoài Bách Hoa Trận "},
	{" Đông Bờ Hồ Trúc Lâm "},
	{" Đông Rừng Nguyên Sinh "},
	{" Đông Nam Lư Vĩ Đãng "},
};
uiTools.Map2x =
{ 
	{" Cấm Địa Hậu Sơn "},
	{" Cấm Địa Thiên Nhẫn "},
	{" Kiến Tính Phong "},
	{" Thiên Trụ Phong "},
	{" Cô Tô Thủy Tạ "},
	{" Cừu Lão Phong "},
	{" Bách Hoa Cốc "},
	{" Hồ Phỉ Thúy "},
	{" Bộ Lạc Nam Di "},
	{" Thanh Loa Đảo "},
};
uiTools.Map1x =
{ 
	{" Trấn Đông Mộ Viên "},
	{" Trà Mã Cổ Đạo "},
	{" Kỳ Liên Sơn "},
	{" Đồng Quan "},
	{" Hoài Thủy Sa Châu "},
	{" Thục Nam Trúc Hải "},
	{" Nhạc Dương Lâu "},
};
uiTools.MenuMonPhai =
{ 
	{" Đoàn Thị "},
	{" Nga My "},
	{" Thúy Yên "},
	{" Ngũ Độc "},
	{" Minh Giáo "},
	{" Đường Môn "},
	{" Thiếu Lâm "},
	{" Thiên Vương "},
	{" Cái Bang "},
	{" Thiên Nhẫn "},
	{" Võ Đang "},
	{" Côn Lôn "},
	{" Cổ Mộ "},
	{" Tiêu Dao "},
};	
uiTools.MenuThonXom =
{ 	
	{" Vĩnh Lạc Trấn "},
	{" Ba Lăng Huyện "},
	{" Long Môn Trấn "},
	{" Thạch Cổ Trấn "},
	{" Đạo Hương Thôn "},
	{" Giang Tân Thôn "},
	{" Vân Trung Trấn "},
	{" Long Tuyền Thôn "},
	{" ---==========--- "},
	{" Biện Kinh "},
	{" Dương Châu "},
	{" Lâm An "},
	{" Tương Dương "},
	{" Thành Đô "},
	{" Phượng Tường "},
	{" Đại Lý "},
	{" ---==========--- "},
	{" QD_Lâm An "},
	{" QD_Tương Dương "},
	{" QD_Phượng Tường "},
};
uiTools.MenuNPC =
{ 
	{" Tửu Lầu "},
	{" Tạp Hóa "},
	{" Hiệu Thuốc "},
	{" Hiệp Khách "},
	{" Bạch Hổ Đường "},
	{" Đảo Thiên Tử "},
	{" Tiêu Dao Cốc 2 "},
	{" Quan Lãnh Thổ "},
	{" Thời Quang Lệnh "},
	{" Sứ Giả Hoạt Động "},
	{" Tiền Trang "},
	{" Bổ Đầu Hình Bộ "},
	{" Bảo Thạch "},
	{" Xa Phu "},
};

uiTools.TanLang =
{
	{" Vào Tần Lăng "},
	{" Cửa Phù 3 "},
	{" Cửa Phù 5 "},
	{" Tầng 2 "},
	{" Tầng 3 "},
	{" Tầng 4 "},
	{" Tầng 5 "},
};

self.tbOptionSetting = {};

uiTools.OnButtonClick_Bak = uiTools.OnButtonClick;

uiTools.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_Map11x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map11x[1][1],
		1,
		self.Map11x[2][1],
		2,
		self.Map11x[3][1],
		3,
		self.Map11x[4][1],
		4,
		self.Map11x[5][1],
		5,
		self.Map11x[6][1],
		6,
		self.Map11x[7][1],
		7,
		self.Map11x[8][1],
		8
		);		
	elseif (szWnd == self.BTN_Map10x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map10x[1][1],
		1,
		self.Map10x[2][1],
		2,
		self.Map10x[3][1],
		3,
		self.Map10x[4][1],
		4,
		self.Map10x[5][1],
		5,
		self.Map10x[6][1],
		6,
		self.Map10x[7][1],
		7,
		self.Map10x[8][1],
		8
		);	
    elseif (szWnd == self.BTN_Map9x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map9x[1][1],
		1,
		self.Map9x[2][1],
		2,
		self.Map9x[3][1],
		3,
		self.Map9x[4][1],
		4,
		self.Map9x[5][1],
		5,
		self.Map9x[6][1],
		6,
		self.Map9x[7][1],
		7,
		self.Map9x[8][1],
		8
		);
    elseif (szWnd == self.BTN_Map8x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map8x[1][1],
		1,
		self.Map8x[2][1],
		2,
		self.Map8x[3][1],
		3,
		self.Map8x[4][1],
		4,
		self.Map8x[5][1],
		5,
		self.Map8x[6][1],
		6,
		self.Map8x[7][1],
		7
		);
     elseif (szWnd == self.BTN_Map7x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map7x[1][1],
		1,
		self.Map7x[2][1],
		2,
		self.Map7x[3][1],
		3,
		self.Map7x[4][1],
		4,
		self.Map7x[5][1],
		5,
		self.Map7x[6][1],
		6,
		self.Map7x[7][1],
		7
		);
        elseif (szWnd == self.BTN_Map6x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Map6x[1][1],
		1,
		self.Map6x[2][1],
		2,
		self.Map6x[3][1],
		3,
		self.Map6x[4][1],
		4,
		self.Map6x[5][1],
		5,
		self.Map6x[6][1],
		6
		);	
	elseif (szWnd == self.BTN_Map5x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map5x[1][1],
		1,
		self.Map5x[2][1],
		2,
		self.Map5x[3][1],
		3,
		self.Map5x[4][1],
		4,
		self.Map5x[5][1],
		5,
		self.Map5x[6][1],
		6,
		self.Map5x[7][1],
		7
		);
	elseif (szWnd == self.BTN_Map4x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map4x[1][1],
		1,
		self.Map4x[2][1],
		2,
		self.Map4x[3][1],
		3,
		self.Map4x[4][1],
		4,
		self.Map4x[5][1],
		5,
		self.Map4x[6][1],
		6,
		self.Map4x[7][1],
		7,
		self.Map4x[8][1],
		8,
		self.Map4x[9][1],
		9,
		self.Map4x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map3x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map3x[1][1],
		1,
		self.Map3x[2][1],
		2,
		self.Map3x[3][1],
		3,
		self.Map3x[4][1],
		4,
		self.Map3x[5][1],
		5,
		self.Map3x[6][1],
		6,
		self.Map3x[7][1],
		7,
		self.Map3x[8][1],
		8,
		self.Map3x[9][1],
		9,
		self.Map3x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map2x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map2x[1][1],
		1,
		self.Map2x[2][1],
		2,
		self.Map2x[3][1],
		3,
		self.Map2x[4][1],
		4,
		self.Map2x[5][1],
		5,
		self.Map2x[6][1],
		6,
		self.Map2x[7][1],
		7,
		self.Map2x[8][1],
		8,
		self.Map2x[9][1],
		9,
		self.Map2x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map1x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map1x[1][1],
		1,
		self.Map1x[2][1],
		2,
		self.Map1x[3][1],
		3,
		self.Map1x[4][1],
		4,
		self.Map1x[5][1],
		5,
		self.Map1x[6][1],
		6,
		self.Map1x[7][1],
		7
		);
	elseif (szWnd == self.BTN_MONPHAI) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		14,
		0,
		self.MenuMonPhai[1][1],
		1,
		self.MenuMonPhai[2][1],
		2,
		self.MenuMonPhai[3][1],
		3,
		self.MenuMonPhai[4][1],
		4,
		self.MenuMonPhai[5][1],
		5,
		self.MenuMonPhai[6][1],
		6,
		self.MenuMonPhai[7][1],
		7,
		self.MenuMonPhai[8][1],
		8,
		self.MenuMonPhai[9][1],
		9,
		self.MenuMonPhai[10][1],
		10,
		self.MenuMonPhai[11][1],
		11,
		self.MenuMonPhai[12][1],
		12,
		self.MenuMonPhai[13][1],
		13,
		self.MenuMonPhai[14][1],
		14		
		);	
	elseif (szWnd == self.BTN_THONXOM) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		20,
		0,
		self.MenuThonXom[1][1],
		1,
		self.MenuThonXom[2][1],
		2,
		self.MenuThonXom[3][1],
		3,
		self.MenuThonXom[4][1],
		4,
		self.MenuThonXom[5][1],
		5,
		self.MenuThonXom[6][1],
		6,
		self.MenuThonXom[7][1],
		7,
		self.MenuThonXom[8][1],
		8,
		self.MenuThonXom[9][1],
		9,
		self.MenuThonXom[10][1],
		10,
		self.MenuThonXom[11][1],
		11,
		self.MenuThonXom[12][1],
		12,
		self.MenuThonXom[13][1],
		13,
		self.MenuThonXom[14][1],
		14,
		self.MenuThonXom[15][1],
		15,
		self.MenuThonXom[16][1],
		16,
		self.MenuThonXom[17][1],
		17,
		self.MenuThonXom[18][1],
		18,
		self.MenuThonXom[19][1],
		19,
		self.MenuThonXom[20][1],
		20
		);
	elseif (szWnd == self.BTN_NPC) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		14,
		0,
		self.MenuNPC[1][1],
		1,
		self.MenuNPC[2][1],
		2,
		self.MenuNPC[3][1],
		3,
		self.MenuNPC[4][1],
		4,
		self.MenuNPC[5][1],
		5,
		self.MenuNPC[6][1],
		6,
		self.MenuNPC[7][1],
		7,
		self.MenuNPC[8][1],
		8,
		self.MenuNPC[9][1],
		9,
		self.MenuNPC[10][1],
		10,
		self.MenuNPC[11][1],
		11,
		self.MenuNPC[12][1],
		12,
		self.MenuNPC[13][1],
		13,
		self.MenuNPC[14][1],
		14
		);
	elseif (szWnd == self.BTN_TanLang) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.TanLang[1][1],
		1,
		self.TanLang[2][1],
		2,
		self.TanLang[3][1],
		3,
		self.TanLang[4][1],
		4,
		self.TanLang[5][1],
		5,
		self.TanLang[6][1],
		6,
		self.TanLang[7][1],
		7
		);	
		
	elseif szWnd == BTNSuperMapLink then
		UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)
 	elseif szWnd == BTN_DEAD then
		local szData = KFile.ReadTxtFile("\\interface2\\Kato\\BaoBoss\\TDLT.txt");	
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = szData});
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Đến Map Chiến Đấu<color>");
	elseif (szWnd == self.BTN_BackTrack) then
        AutoAi:SwitchBackTrack()
		---------------New------------------
	elseif (szWnd == self.BTN_ThoiQuangLenh) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615"});	
	elseif (szWnd == self.BTN_ThuKho) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,2599"});	
	elseif (szWnd == self.BTN_DaLuyenDaiSu) then
		Map.tbSuperMapLink:DaLuyenDaiSu();
	elseif (szWnd == self.BTN_ThuongHoi) then
		Map.tbSuperMapLink:ThuongHoi();
	elseif (szWnd == self.BTN_LienDauCao) then
		Map.tbSuperMapLink:LienDauCao();
	elseif (szWnd == self.BTN_LeQuan) then
		Map.tbSuperMapLink:LeQuan();
	elseif (szWnd == self.BTN_VHC) then
		Map.tbSuperMapLink:VHC();
	elseif (szWnd == self.BTN_TQC) then
		Map.tbSuperMapLink:TQC();
	elseif (szWnd == self.BTN_XaPhu) then
		Map.tbSuperMapLink:XaPhu();	
	elseif (szWnd == self.BTN_QuanLanhTho) then
		Map.tbSuperMapLink:QuanLanhTho();
	elseif (szWnd == self.BTN_DaoThienTu) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",114,20223,1"});	
	elseif (szWnd == self.BTN_TieuDaoCoc) then
		SendChannelMsg("Team","Anh em đi TDC 2 nào!!!")
		--Ui(Ui.UI_TieuDaoCoc):State1();
	elseif (szWnd == self.BTN_BachHoDuongC) then	
		SendChannelMsg("Team","Anh em đi Bạch Hổ Đường Cao!!!")
		--Ui(Ui.UI_BHDC):State1();
	elseif (szWnd == self.BTN_BachHoDuongK) then		
		SendChannelMsg("Team","Anh em đi Bạch Hổ Đường Kim!!!")
		--Ui(Ui.UI_BHDK):State1();
	elseif (szWnd == self.BTN_TongKim) then		
		SendChannelMsg("Team","Anh em đi Tống Kim nào!!!")	
		--Ui(Ui.UI_TongKim):State1();	
	elseif (szWnd == self.BTN_MCLSV) then		
		Ui(Ui.UI_MCLSV):State1();
	elseif (szWnd == self.BTN_THLSV) then		
		Ui(Ui.UI_THLSV):State1();	
	elseif (szWnd == self.BTNgohome) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.gohome[1][1],
		1,
		self.gohome[2][1],
		2,
		self.gohome[3][1],
		3
		);	
	elseif (szWnd == self.BTN_ThanhTool) then
	    UiManager.OnOpen();
	    --UiManager:SwitchWindow(Ui.UI_TOOL);
	elseif (szWnd == self.BTN_chatAGT) then
		if me.GetMapTemplateId() < 30 then
		Ui(Ui.UI_LANHDIA):State1();
		else
		me.CallServerScript({"UseUnlimitedTrans", 6}); 
		end
	elseif (szWnd == self.BTN_Server) then
		if me.GetMapTemplateId() < 30 then
		Ui(Ui.UI_Server):State1();
		else
		me.CallServerScript({"UseUnlimitedTrans", 6}); 
		end
-----------------------------------------------------------
elseif (szWnd == self.BTN_AutoFoodz) then		   
		if self.BtnAutoFoodzKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ngừng tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 0;
		end
		self.nAutoFoodz=nParam
		self:SaveData()
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
	end
end

uiTools.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if (szWnd == self.BTNgohome) then
		if nItemId==1 then
			me.CallServerScript({"UseUnlimitedTrans", 24});
		elseif nItemId==2 then
			SendChannelMsg("Team","gohome2")
		elseif nItemId==3 then
			SendChannelMsg("Team","gohome1")
		end
	elseif szWnd == self.BTN_Map11x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",130,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",131,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",133,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",134,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",135,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",136,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",137,0,"});	         
		   	end
	 end  
	if szWnd == self.BTN_Map10x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",122,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",123,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",124,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",125,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",126,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",127,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",128,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",129,0,"});	         
		   	end
	 end 
    if szWnd == self.BTN_Map9x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",114,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",115,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",116,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",117,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",118,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",119,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",120,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",121,0,"});	         
		   	end
	 end
	if szWnd == self.BTN_Map8x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",107,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",108,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",109,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",110,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",111,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",112,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",113,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map7x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",100,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",101,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",102,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",103,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",104,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",105,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",106,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map6x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",94,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",95,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",96,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",97,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",98,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",99,0,"});	
		    end
	 end 
	 if szWnd == self.BTN_Map5x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",86,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",87,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",88,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",89,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",90,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",91,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",92,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map4x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",66,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",67,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",68,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",69,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",70,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",71,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",72,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",73,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",74,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",75,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map3x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",56,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",57,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",58,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",59,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",60,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",61,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",62,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",63,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",64,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",65,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map2x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",46,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",47,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",48,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",49,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",50,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",51,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",52,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",53,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",54,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",55,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map1x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",38,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",43,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",39,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",40,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",41,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",42,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",45,0,"});
		end
	 end
	 if szWnd == self.BTN_Map5 then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",30,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",31,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",32,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",33,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",34,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",35,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",36,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",37,0,"});	
			end
	 end
	 if szWnd == self.BTN_MONPHAI then
			if nItemId==1 then
		me.CallServerScript({"UseUnlimitedTrans", 19});--doan thi
			elseif nItemId==2 then
		me.CallServerScript({"UseUnlimitedTrans", 16});--nga my
			elseif nItemId==3 then
		me.CallServerScript({"UseUnlimitedTrans", 17});--thuy yen
			elseif nItemId==4 then
		me.CallServerScript({"UseUnlimitedTrans", 20});--ngu doc
			elseif nItemId==5 then
		me.CallServerScript({"UseUnlimitedTrans", 224});--minhgiao
			elseif nItemId==6 then
		me.CallServerScript({"UseUnlimitedTrans", 18});--duong mon
			elseif nItemId==7 then
		me.CallServerScript({"UseUnlimitedTrans", 9});--thieu lam
			elseif nItemId==8 then
		me.CallServerScript({"UseUnlimitedTrans", 22});--thienvuong
			elseif nItemId==9 then
		me.CallServerScript({"UseUnlimitedTrans", 15});--cai bang
			elseif nItemId==10 then
		me.CallServerScript({"UseUnlimitedTrans", 10});--thien nhan
		    elseif nItemId==11 then
		me.CallServerScript({"UseUnlimitedTrans", 14});--vo dang
			elseif nItemId==12 then
		me.CallServerScript({"UseUnlimitedTrans", 12});--con lon
		    elseif nItemId==13 then
		me.CallServerScript({"UseUnlimitedTrans", 2261});--Cổ Mộ
			    elseif nItemId==14 then
		me.CallServerScript({"UseUnlimitedTrans", 2364});--Tiêu Dao	
        	end
	end
	if szWnd == self.BTN_THONXOM then
			if nItemId==1 then
		me.CallServerScript({"UseUnlimitedTrans", 3}); --VinhLac
			elseif nItemId==2 then
		me.CallServerScript({"UseUnlimitedTrans", 8}); --BaLang
			elseif nItemId==3 then
        me.CallServerScript({"UseUnlimitedTrans", 2}); --LongMon
			elseif nItemId==4 then
		me.CallServerScript({"UseUnlimitedTrans", 6}); --ThachCo
			elseif nItemId==5 then
		me.CallServerScript({"UseUnlimitedTrans", 4}); --DaoHuong
			elseif nItemId==6 then
		me.CallServerScript({"UseUnlimitedTrans", 5}); --GiangTan
		    elseif nItemId==7 then
		me.CallServerScript({"UseUnlimitedTrans", 1}); --VanTrung
			elseif nItemId==8 then
		me.CallServerScript({"UseUnlimitedTrans", 7}); --LongTuyen
		    elseif nItemId==9 then
			
			elseif nItemId==10 then
		me.CallServerScript({"UseUnlimitedTrans", 23}); --BienKinh
			elseif nItemId==11 then
        me.CallServerScript({"UseUnlimitedTrans", 26}); --DuongChau
			elseif nItemId==12 then
        me.CallServerScript({"UseUnlimitedTrans", 29}); --LamAn
			elseif nItemId==13 then
        me.CallServerScript({"UseUnlimitedTrans", 25}); --TuongDuong
		    elseif nItemId==14 then
        me.CallServerScript({"UseUnlimitedTrans", 27}); --ThanhDo
			elseif nItemId==15 then
        me.CallServerScript({"UseUnlimitedTrans", 24}); --PhuongTuong
			elseif nItemId==16 then
        me.CallServerScript({"UseUnlimitedTrans", 28}); --DaiLy
		    elseif nItemId==17 then
		
		    elseif nItemId==18 then
        me.CallServerScript({"UseUnlimitedTrans", 29}); --Lam An
			elseif nItemId==19 then
        me.CallServerScript({"UseUnlimitedTrans", 25}); --Tuong Duong
			elseif nItemId==20 then
		me.CallServerScript({"UseUnlimitedTrans", 24}); --Phuong Tuong
			end
	end	
	if szWnd == self.BTN_NPC then
			if nItemId==1 then
		Map.tbSuperMapLink:TuuLau();
			elseif nItemId==2 then
		Map.tbSuperMapLink:TapHoa();
		    elseif nItemId==3 then
		Map.tbSuperMapLink:HieuThuoc();
		    elseif nItemId==4 then
		Map.tbSuperMapLink:HiepKhach();	
		    elseif nItemId==5 then
		Map.tbSuperMapLink:BachHoDuong();
		    elseif nItemId==6 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",114,20223,1"});
		    elseif nItemId==7 then
		Map.tbSuperMapLink:TieuDaoCoc();	
		    elseif nItemId==8 then
		Map.tbSuperMapLink:QuanLanhTho();
		    elseif nItemId==9 then
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",132,1903,3806"});
		    elseif nItemId==10 then
		Map.tbSuperMapLink:SuGiaHoatDong();	
			elseif nItemId==11 then
		Map.tbSuperMapLink:TienTrang();
			elseif nItemId==12 then
		Map.tbSuperMapLink:BoDauHinhBo();
			elseif nItemId==13 then
		Map.tbSuperMapLink:BaoThach();
			elseif nItemId==14 then
		Map.tbSuperMapLink:XaPhu();
		    end
	end
	if szWnd == self.BTN_TanLang then
			
			if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,2441,1"});
			nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
			--Map.tbSuperMapLink:TanLang();
			elseif nItemId==2 then -- truyen tong 3
			
				local tbPos = {}
				tbPos.nMapId = 1536
				tbPos.nX = 1401
				tbPos.nY = 3620
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
			elseif nItemId==3 then -- truyen tong 5 
				local tbPos = {}
				tbPos.nMapId = 1536
				tbPos.nX = 1591
				tbPos.nY = 3449
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)	
			elseif nItemId==4 then -- Tầng 2
							
				local tbPos = {}
				tbPos.nMapId = 1536
				tbPos.nX = 1768
				tbPos.nY = 4012
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)	
			
			elseif nItemId==5 then --Tầng 3
				local tbPos = {}
				tbPos.nMapId = 1537
				tbPos.nX = 1969
				tbPos.nY = 3678
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)	  
			elseif nItemId==6 then -- tầng 4
				local tbPos = {}
				tbPos.nMapId = 1538
				tbPos.nX = 1757
				tbPos.nY = 3526
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)	
			elseif nItemId==7 then -- tầng 5
				local tbPos = {}
				tbPos.nMapId = 1539
				tbPos.nX = 1900
				tbPos.nY = 3878
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)	
			end
	 end
end	
function uiTools:ScrReload()
	UiManager:CloseWindow(Ui.UI_TOOLS)
end
