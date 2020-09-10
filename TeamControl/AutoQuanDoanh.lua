----------Auto Quan Doanh by HOAHONGNET---------------
----------Edited by Quốc Huy-----
Ui.UI_AutoQuanDoanh            = "UI_AutoQuanDoanh";
local uiAutoQuanDoanh          = Ui.tbWnd[Ui.UI_AutoQuanDoanh] or {};
uiAutoQuanDoanh.UIGROUP        = Ui.UI_AutoQuanDoanh;
Ui.tbWnd[Ui.UI_AutoQuanDoanh]  = uiAutoQuanDoanh;
Map.tbAutoQuanDoanh		       = uiAutoQuanDoanh;
local self                     = uiAutoQuanDoanh;
local tbTimer 				   = Ui.tbLogic.tbTimer;

local eggStart     = 0;
local nPickState   = 0;
local nPickTimerId = 0;
local nPickTime    = 0.3; 
------------------------He Thong-------------------------
local BTNreload								= "Btnreload"
local BTNChatFollow							= "BtnChatFollow"
local BTNChatStartBuff						= "BtnChatStartBuff"
local BTNChatStartPK						= "BtnChatStartPK"
local BTNChatStopPK							= "BtnChatStopPK"
local BTNChatTeam							= "BtnChatTeam"
-----------------------NLHN-----------------------------
local BTNChatNLHN							= "BtnChatNLHN"
-----------------------HLVM-----------------------------
local BTNChatGoHLVM							= "BtnChatGoHLVM"
------------------------BMS-------------------------------
local BTNChatGoBMS							= "BtnChatGoBMS"
------------------------HPNS--------------------------------------
local BTNChatGoHSPN					        = "BtnChatGoHSPN"

------------------------Khác---------------------------------------
local BTNChatGoTDC							= "BtnChatGoTDC"
local BTNChatRTDC							= "BtnChatRTDC"
local BTNChatMTDC							= "BtnChatMTDC"
local BTNChatTRAM							= "BtnChatTRAM"
local BTNChatCTC							= "BtnChatCTC"
local BTNChatThanKyThach					= "BtnChatThanKyThach"
local BTNChatcheckskill						= "BtnChatcheckskill"
local BTNChatBHDserver						= "BtnChatBHDserver"
local BTNChatGhepHT							= "BtnChatGhepHT"
local BTNChatPhoThuyLoi					    = "BtnChatPhoThuyLoi"
local BTNChatMAIL					        = "BtnChatMAIL"
local BTNChatTUCHAU					        = "BtnChatTUCHAU"
local BTNChattuiQH					        = "BtnChattuiQH"
local BTNChatDDP							= "BtnChatDDP"
local BTNChatStartlua					    = "BtnChatStartlua"
local BTNChatstoplua						= "BtnChatstoplua"
local BTNChatBVD							= "BtnChatBVD"
local BTNChatRTDLT							= "BtnChatRTDLT"
local BTNChatPET						    = "BtnChatPET"
local BTNChatStopTDLT						= "BtnChatStopTDLT"
local BTNChatMauTDLT						= "BtnChatMauTDLT"
local BTNChatThuongTDLT						= "BtnChatThuongTDLT"
local BTNChatLakTDLT						= "BtnChatLakTDLT"
local BTNChatBuLakTDLT						= "BtnChatBuLakTDLT"
local BTNChatBuLak							= "BtnChatBuLak"
local BTNChatKDM							= "BtnChatKDM"
local BTNChatgohome						    = "BtnChatgohome"
local BTNChatgottt							= "BtnChatgottt"
local BTNChatTQL							= "BtnChatTQL"
local BTNChatgiatoc							= "BtnChatgiatoc"
local BTNChatRoiLauLan						= "BtnChatRoiLauLan"
local BTNChatCKP							= "BtnChatCKP"
local BTNChatkimte						    = "BtnChatkimte"
local BTNChatsuado						    = "BtnChatsuado"
local BTNChatchucphuc						= "BtnChatchucphuc"
local BTNChatNangDong						= "BtnChatNangDong"
local BTNChatcomo					        = "BtnChatcomo"
local BTNChatruongTBD					    = "BtnChatruongTBD"
local BTNChathoisinh					    = "BtnChathoisinh"
local BTNChatLuuRuong						= "BtnChatLuuRuong"
------------------------TongKim-------------------------------------
local BTNChatVaoTH							= "BtnChatVaoTH" --tay ha
local BTNChatVaoMC							= "BtnChatVaoMC"  -- mong co
local BTNChatHD								= "BtnChatHD"
local BTNChatLMPK							= "BtnChatLMPK"
local BTNChatVaoLMPK						= "BtnChatVaoLMPK"
local BTNCHATMAUTK							= "BtnCHATMAUTK"
local BTNCHATRuongTK						= "BtnCHATRUONGTK"
local BTNCHATNVHK							= "BtnCHATNVHK"
local BTNChatBoss							= "BtnChatBoss"
local BTNCHATMUAMAU							= "BtnCHATMUAMAU"
local BTNCHATCAI							= "BtnChatCai"
local BTNChatRacTDC							= "BtnChatRacTDC"

-----------------------Mua Máu, thức ăn-----------------------------------------
self.BTN_SAVE		= "BtnSave";
self.EDT_FREEBAG	= "EdtFreeBag";
self.EDT_NEEDB	    = "EdtNeedB";
self.DATA_KEY	    = "TeamControlSetting";
self.tbSetting	    = {};
self.BTNChatTBLenh	= "BtnChatTBLenh"
self.BTNChatTuoiThoNgua	= "BtnChatTuoiThoNgua"
self.BTNChatTTP	= "BtnChatTTP"
self.BTNChatDA	= "BtnChatDA"
self.BTNChatQNL	= "BtnChatQNL"
self.BTNChatKTH	= "BtnChatKTH"
self.BTNChatTDLT	= "BtnChatTDLT"
-----------------------het-----------------------------------------

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

Ui:RegisterNewUiWindow("UI_AutoQuanDoanh", "AutoQuanDoanh", {"a", 581, 457}, {"b", 808, 600}, {"c", 855, 645});
											-- a: Trái - Phải, Lên - Xuống
												-- bé	- to,	bé 	- to											

function uiAutoQuanDoanh:Init()

end
self.ChatCTC =
{ 
	{" Đi CTC "},
	{" Vào thành "},
	{" Rời thành "},
	{" Nhận thưởng "},
	{" Lấy máu  "},
	{" Lên tầng 2"},
	{" Lên tầng 3"},
};

self.ChatLauLan =
{ 
	{" Nhận Nhiệm Vụ "},
	{" Vào Lâu Lan "},
	{" Rời Lâu Lan "},
	{" Nhận thưởng "},
	
};

self.ChatRacTDC =
{ 	
	{" Bật Nhặt Nhanh "},
	{" Vứt Rác TDC "},
	{" Bán Rác * HT "},
};

self.ChatKDM = 
{
	{" Nhận Quân Lệnh "},
	{" Làm nhiệm vụ "},
	{" Rời khỏi "},
};
self.ChatKTH = 
{
	{" Vào KTH "},
	{" Làm Nhiệm vụ "},
	{" Đi lên "},
	{" Đi Xuống "},
	{" Khu an toàn về thành "},
	{" Tăng Dem "},
	{" Giảm Dem "},
	
};
self.ChatTDLT = 
{
	{" Quan Lãnh Thổ"},
	{" Nhận LAK "},
	{" Dùng LAK"},
	{" Nhận Thưởng "},
	{" Lưu Map "},
	{" Map Đang Đánh "},
};
self.ChatPhoThuyLoi = 
{
	{" Vào mộng cảnh "},
	{" trail mộng cảnh "},
	{" Quit mộng cảnh "},
};

self.ChatPET = 
{
	{" Mở pet 1 "},
	{" Mở pet 2 "},
	{" Mở pet 3 "},
};


self.ChatThanKyThach = 
{
	{" Đập đá 1 cạnh "},
	{" Đập đá 2 cạnh "},
	{" Đập đá 3 cạnh "},
	{" Đập đá 4 cạnh "},
	{" Đập đá 5 cạnh "},
	{" Đập đá 6 cạnh "},
	{" Nhận Đồ mài đá "},
};

self.ChatNLHN = 
{
    {" báo danh "},
	{" Vào P.bản "},
	{" Bắt ngựa "},
	{" Tế Tự Đại "},
	{" Trả lời "},
	{" Rời khỏi "},
	{" trả nhiệm vụ NLHN "},
};

self.Chatgottt = 
{
	{" nhận lệnh bài "},
	{" nhận nhiệm vụ "},
	{" vào ải "},
	{" nhận thưởng "},
};

self.ChatGoTDC = 
{
	{" Vào TDC1 "},
	{" Vào TDC2 "},
	{" Đổi thể bí bảo "},
	{" Đổi bạc khóa "},
	{" Nhận thưởng thu thập thẻ "},
	{" Nhận sổ thu thập thẻ "},
};

self.ChatBuLak = 
{
	{" Ma đao thạch cấp 7 "},
	{" Vạn vật quy nguyên đơn "},
	{" Mông tây lak 1 skill  "},
	{" Mông Tây lak phản đòn"},
	{" Mông tây kháng tất cả"},
};

self.ChatGoHLVM = 
{
    {" Báo danh "},
	{" Vào hải lăng "},
	{" Vượt rừng gai "},	
	{" Phong "},
	{" Lâm "},
	{" Hỏa "},
	{" sơn "},
	{" Tầng 2 "},
	{" Tầng 3 "},
	{" Tầng 4 "},
	{" Đoán số 0 "},
	{" Trả nhiệm vụ HLVM "},
};

self.ChatGoBMS = 
{
    {" Báo Danh "},
	{" Vào BMS "},
	{" Báo cáo NKT "},
	{" Báo cáo DBC "},
	{" Gọi PT lên boss cuối "},
	{" Gọi PT Quit BMS "},
	{" Trả nhiệm vụ BMS "},
};

self.ChatGoHSPN = 
{
    {" Báo Danh "},
	{" Vào HSPN "},
	{" Bắt chuột "},
	{" Vượt rào "},
	{" Tìm nghĩa Quân "},
	{" Lấy Gỗ "},
	{" Thu thập thảo dược "},
	{" Báo cáo đạo cụ "},
	{" Quit HS "},
	{" Trả nhiệm vụ HSPN "},
};

self.Chatgiatoc = 
{
	{" Vào / rời lãnh địa "},
	{" Vào ải gia tộc "},
	{" Lên boss cuối ải gia tộc "},
	{" Quit ải "},
	{" Đổi tiền cổ "},
	{" Nhận Lương Gia Tộc "},
	{" Trồng Cây Gia tộc "},
};

self.ChatTQL = 
{
	{" Nhận lệnh bài "},
	{" Nhận nhiệm vụ "},
	{" Vào thời quang điện "},
	{" Rời thời quang điện "},	
	{" Nhận thưởng "},	
	{" Điểm truyền tống 2 "},	
};

self.ChattuiQH = 
{
	{" Túi quân hưởng "},
	{" Đọc sách "},	
};
-----------------------

function uiAutoQuanDoanh:OnButtonClick(szWnd)
	if (szWnd == BTNreload) then
		self.ScrReload();
		self:LoadSetting();	
	elseif (szWnd == BTNChatFollow) then
		uiAutoQuanDoanh:ChatFollow();	
	elseif (szWnd == BTNChatStartBuff) then
		uiAutoQuanDoanh:ChatStartBuff();
	elseif (szWnd == BTNChatStartPK) then
		uiAutoQuanDoanh:ChatStartPK();
	elseif (szWnd == BTNChatStopPK) then
		uiAutoQuanDoanh:ChatStopPK();
	elseif (szWnd == BTNChatTeam) then
		uiAutoQuanDoanh:ChatTeam();	
	-------------------NLHN-----------------
	elseif (szWnd == BTNChatNLHN) then
		--uiAutoQuanDoanh:ChatGoNLHN();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatNLHN[1][1],
		1,
		self.ChatNLHN[2][1],
		2,
		self.ChatNLHN[3][1],
		3,
		self.ChatNLHN[4][1],
		4,
		self.ChatNLHN[5][1],
		5,
		self.ChatNLHN[6][1],
		6,
		self.ChatNLHN[7][1],
		7
		);	
	--------------------HLVM------------------		
	elseif (szWnd == BTNChatGoHLVM) then
		--uiAutoQuanDoanh:ChatGoHLVM();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		12,
		0,
		self.ChatGoHLVM[1][1],
		1,
		self.ChatGoHLVM[2][1],
		2,
		self.ChatGoHLVM[3][1],
		3,
		self.ChatGoHLVM[4][1],
		4,
		self.ChatGoHLVM[5][1],
		5,
		self.ChatGoHLVM[6][1],
		6,
		self.ChatGoHLVM[7][1],
		7,
		self.ChatGoHLVM[8][1],
		8,
		self.ChatGoHLVM[9][1],
		9,
		self.ChatGoHLVM[10][1],
		10,
		self.ChatGoHLVM[11][1],
		11,
		self.ChatGoHLVM[12][1],
		12
		);
	------------------BMS------------------
	elseif (szWnd == BTNChatGoBMS) then
		--uiAutoQuanDoanh:ChatGoBMS();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatGoBMS[1][1],
		1,
		self.ChatGoBMS[2][1],
		2,
		self.ChatGoBMS[3][1],
		3,
		self.ChatGoBMS[4][1],
		4,
		self.ChatGoBMS[5][1],
		5,
		self.ChatGoBMS[6][1],
		6,
		self.ChatGoBMS[7][1],
		7
		);
	------------------HSPN-----------------
	elseif (szWnd == BTNChatGoHSPN) then
		--uiAutoQuanDoanh:ChatGoHSPN();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.ChatGoHSPN[1][1],
		1,
		self.ChatGoHSPN[2][1],
		2,
		self.ChatGoHSPN[3][1],
		3,
		self.ChatGoHSPN[4][1],
		4,
		self.ChatGoHSPN[5][1],
		5,
		self.ChatGoHSPN[6][1],
		6,
		self.ChatGoHSPN[7][1],
		7,
		self.ChatGoHSPN[8][1],
		8,
		self.ChatGoHSPN[9][1],
		9,
		self.ChatGoHSPN[10][1],
		10
		);
			---------------------add-----
	elseif (szWnd == BTNCHATCAI) then
		uiAutoQuanDoanh:ChatCai();
--------------------Khác----------------------------
	elseif (szWnd == BTNChatGoTDC) then
		--uiAutoQuanDoanh:ChatGoTDC();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.ChatGoTDC[1][1],
		1,
		self.ChatGoTDC[2][1],
		2,
		self.ChatGoTDC[3][1],
		3,
		self.ChatGoTDC[4][1],
		4,
		self.ChatGoTDC[5][1],
		5,
		self.ChatGoTDC[6][1],
		6
		);
	elseif (szWnd == BTNChatgohome) then
		uiAutoQuanDoanh:Chatgohome();
	elseif (szWnd == BTNChatgottt) then
		--uiAutoQuanDoanh:Chatttt();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		4,
		0,
		self.Chatgottt[1][1],
		1,
		self.Chatgottt[2][1],
		2,
		self.Chatgottt[3][1],
		3,
		self.Chatgottt[4][1],
		4
		);
	elseif (szWnd == BTNChatRoiLauLan) then
		--uiAutoQuanDoanh:Chatttt();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		4,
		0,
		self.ChatLauLan[1][1],
		1,
		self.ChatLauLan[2][1],
		2,
		self.ChatLauLan[3][1],
		3,
		self.ChatLauLan[4][1],
		4
		);	
	elseif (szWnd == BTNChatgiatoc) then
		--uiAutoQuanDoanh:Chatgiatoc();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Chatgiatoc[1][1],
		1,
		self.Chatgiatoc[2][1],
		2,
		self.Chatgiatoc[3][1],
		3,
		self.Chatgiatoc[4][1],
		4,
		self.Chatgiatoc[5][1],
		5,
		self.Chatgiatoc[6][1],
		6,
		self.Chatgiatoc[7][1],
		7
		);
	elseif (szWnd == BTNChatTQL) then
		--uiAutoQuanDoanh:ChatTQL();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.ChatTQL[1][1],
		1,
		self.ChatTQL[2][1],
		2,
		self.ChatTQL[3][1],
		3,
		self.ChatTQL[4][1],
		4,
		self.ChatTQL[5][1],
		5,
		self.ChatTQL[6][1],
		6
		);	
	elseif (szWnd == BTNChatRTDC) then
		uiAutoQuanDoanh:ChatRTDC();
	elseif (szWnd == BTNChatMTDC) then
		uiAutoQuanDoanh:ChatMTDC();
	elseif (szWnd == BTNChatBHDserver) then
		uiAutoQuanDoanh:ChatBHDserver();
	elseif (szWnd == BTNChatGhepHT) then
		uiAutoQuanDoanh:ChatGhepHT();	
	elseif (szWnd == BTNChatBVD) then
		uiAutoQuanDoanh:ChatBVD();
	elseif (szWnd == BTNChatRacTDC) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.ChatRacTDC[1][1],
		1,
		self.ChatRacTDC[2][1],
		2,
		self.ChatRacTDC[3][1],
		3
		);	
		--uiAutoQuanDoanh:ChatRacTDC();	
	elseif (szWnd == BTNChatPhoThuyLoi) then
		--uiAutoQuanDoanh:ChatPhoThuyLoi();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.ChatPhoThuyLoi[1][1],
		1,
		self.ChatPhoThuyLoi[2][1],
		2,
		self.ChatPhoThuyLoi[3][1],
		3
		);
	elseif (szWnd == BTNChatMAIL) then
		uiAutoQuanDoanh:ChatMAIL();
	elseif (szWnd == BTNChatTUCHAU) then
		uiAutoQuanDoanh:ChatTUCHAU();
	elseif (szWnd == BTNChattuiQH) then
		--uiAutoQuanDoanh:ChattuiQH();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		2,
		0,
		self.ChattuiQH[1][1],
		1,
		self.ChattuiQH[2][1],
		2
		);
	elseif (szWnd == BTNChatStartlua) then
		uiAutoQuanDoanh:ChatStartlua();
	elseif (szWnd == BTNChatstoplua) then
		uiAutoQuanDoanh:Chatstoplua();
	elseif (szWnd == BTNChatRTDLT) then
		uiAutoQuanDoanh:ChatRTDLT();
	elseif (szWnd == BTNChatPET) then
		--uiAutoQuanDoanh:ChatPET();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.ChatPET[1][1],
		1,
		self.ChatPET[2][1],
		2,
		self.ChatPET[3][1],
		3
		);
	elseif (szWnd == BTNChatStopTDLT) then
		uiAutoQuanDoanh:ChatStopTDLT();
	elseif (szWnd == BTNChatThuongTDLT) then
		uiAutoQuanDoanh:ChatThuongTDLT();
	elseif (szWnd == BTNChatMauTDLT) then
		uiAutoQuanDoanh:ChatMauTDLT();
	elseif (szWnd == BTNChatLakTDLT) then
		uiAutoQuanDoanh:ChatLakTDLT();	
	elseif (szWnd == BTNChatBuLakTDLT) then
		uiAutoQuanDoanh:ChatBuLakTDLT();
	elseif (szWnd == BTNChatBuLak) then
		--uiAutoQuanDoanh:ChatBuLak7();
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		5,
		0,
		self.ChatBuLak[1][1],
		1,
		self.ChatBuLak[2][1],
		2,
		self.ChatBuLak[3][1],
		3,
		self.ChatBuLak[4][1],
		4,
		self.ChatBuLak[5][1],	
		5
		);		
	elseif (szWnd == BTNChatKDM) then
		--uiAutoQuanDoanh:ChatKDM();	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.ChatKDM[1][1],
		1,
		self.ChatKDM[2][1],
		2,
		self.ChatKDM[3][1],
		3
		);	 
	elseif (szWnd == self.BTNChatKTH) then
		--uiAutoQuanDoanh:ChatKDM();	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatKTH[1][1],
		1,
		self.ChatKTH[2][1],
		2,
		self.ChatKTH[3][1],
		3,
		self.ChatKTH[4][1],
		4,
		self.ChatKTH[5][1],
		5,
		self.ChatKTH[6][1],
		6,
		self.ChatKTH[7][1],
		7
		);	
	elseif (szWnd == self.BTNChatTDLT) then
		--uiAutoQuanDoanh:ChatKDM();	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.ChatTDLT[1][1],
		1,
		self.ChatTDLT[2][1],
		2,
		self.ChatTDLT[3][1],
		3,
		self.ChatTDLT[4][1],
		4,
		self.ChatTDLT[5][1],
		5,
		self.ChatTDLT[6][1],
		6
		);	 	
	elseif (szWnd == BTNChatTRAM) then
		uiAutoQuanDoanh:ChatTRAM();
	elseif (szWnd == BTNChatCTC) then	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatCTC[1][1],
		1,
		self.ChatCTC[2][1],
		2,
		self.ChatCTC[3][1],
		3,
		self.ChatCTC[4][1],
		4,
		self.ChatCTC[5][1],
		5,
		self.ChatCTC[6][1],
		6,
		self.ChatCTC[7][1],
		7
		);	
	elseif (szWnd == BTNChatThanKyThach) then	
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.ChatThanKyThach[1][1],
		1,
		self.ChatThanKyThach[2][1],
		2,
		self.ChatThanKyThach[3][1],
		3,
		self.ChatThanKyThach[4][1],
		4,
		self.ChatThanKyThach[5][1],
		5,
		self.ChatThanKyThach[6][1],
		6,
		self.ChatThanKyThach[7][1],
		7
		);
------------------------TongKim-----------------------
	elseif (szWnd == BTNChatCKP) then
		uiAutoQuanDoanh:ChatCKP();
	elseif (szWnd == self.BTNChatTTP) then
		uiAutoQuanDoanh:ChatTTP();	
	elseif (szWnd == self.BTNChatTBLenh) then
		uiAutoQuanDoanh:ChatTBLenh();	
	elseif (szWnd == self.BTNChatTuoiThoNgua) then
		uiAutoQuanDoanh:ChatTuoiThoNgua();		
	elseif (szWnd == self.BTNChatDA) then
		uiAutoQuanDoanh:ChatDA();		
	elseif (szWnd == self.BTNChatQNL) then
		uiAutoQuanDoanh:ChatQNL();		
		
		
	elseif (szWnd == BTNChatkimte) then
		uiAutoQuanDoanh:Chatkimte();
	elseif (szWnd == BTNChatsuado) then
		uiAutoQuanDoanh:Chatsuado();
	elseif (szWnd == BTNChatNangDong) then
		uiAutoQuanDoanh:ChatNangDong();
	elseif (szWnd == BTNChatLuuRuong) then
		uiAutoQuanDoanh:ChatLuuRuong();
	elseif (szWnd == BTNChatcomo) then
		uiAutoQuanDoanh:Chatcomo();
	elseif (szWnd == BTNChatruongTBD) then
		uiAutoQuanDoanh:ChatruongTBD();
	elseif (szWnd == BTNChathoisinh) then
		uiAutoQuanDoanh:Chathoisinh();
	elseif (szWnd == BTNChatcheckskill) then
		uiAutoQuanDoanh:Chatcheckskill();	
	elseif (szWnd == BTNChatLMPK) then
		uiAutoQuanDoanh:ChatLMPK();
	elseif (szWnd == BTNChatVaoLMPK) then
		uiAutoQuanDoanh:ChatVaoLMPK();	
	elseif (szWnd == BTNChatVaoMC) then
		uiAutoQuanDoanh:ChatVaoMC();
	elseif (szWnd == BTNChatVaoTH) then
		uiAutoQuanDoanh:ChatVaoTH();
	elseif (szWnd == BTNCHATMAUTK) then
		uiAutoQuanDoanh:ChatMAUTK();
	elseif (szWnd == BTNCHATRuongTK) then
		uiAutoQuanDoanh:ChatRuongTK() ;
	elseif (szWnd == BTNCHATNVHK) then
		uiAutoQuanDoanh:ChatNVHK() ;
	elseif (szWnd == BTNChatBoss) then
		uiAutoQuanDoanh:ChatBoss();	
	elseif (szWnd == BTNCHATMUAMAU) then
		uiAutoQuanDoanh:ChatMUAMAU();		
	elseif (szWnd == self.BTN_SAVE) then	
		self:SaveData();	
-----------------------het-------------------------------------		
end
end

-----------popup tra mau--------------------

uiAutoQuanDoanh.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if szWnd == BTNChatCTC then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em đi CTC!!");
			elseif nItemId==2 then
        SendChannelMsg("NearBy", "Anh em vào thiết phù thành!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em rời khỏi thiết phù thành!!");		
			elseif nItemId==4 then
       	SendChannelMsg("NearBy", "Anh em nhận thưởng CTC!!");
			elseif nItemId==5 then
       	SendChannelMsg("Team", "Anh em lấy máu CTC!!");
			elseif nItemId==6 then
       	SendChannelMsg("Team", "Anh em Lên tầng hai nào!!");
			elseif nItemId==7 then
       	SendChannelMsg("Team", "Anh em Lên tầng ba nào!!");
		 	end
	elseif szWnd == BTNChatKDM then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em nhận Quân Lệnh nào!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em làm nhiệm vụ Khắc Di Môn nào!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em rời bản đồ khắc di môn nào !!");		
			end
	elseif szWnd == self.BTNChatKTH then
			if nItemId==1 then
		SendChannelMsg("Team", "vaokth");	
			elseif nItemId==2 then
		SendChannelMsg("Team", "nhiemvukt");
			elseif nItemId==3 then
        SendChannelMsg("Team", "dilen");	
			elseif nItemId==4 then
       	SendChannelMsg("Team", "dixuong");		
			elseif nItemId==5 then
       	SendChannelMsg("Team", "khuantoan");	
			elseif nItemId==6 then
		SendChannelMsg("Team", "Tăng Dem");
			elseif nItemId==7 then
		SendChannelMsg("Team", "Giảm Dem");
			end	

	elseif szWnd == self.BTNChatTDLT then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",29,1606,4020"});	
			elseif nItemId==2 then
		uiAutoQuanDoanh:ChatLakTDLT();
			elseif nItemId==3 then
        uiAutoQuanDoanh:ChatBuLakTDLT();	
			elseif nItemId==4 then
       	uiAutoQuanDoanh:ChatThuongTDLT();		
			elseif nItemId==5 then
				local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
				local tbmap= ","..nMapId..","..nMyPosX..","..nMyPosY
				KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\TDLT.txt", tbmap);
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Lưu Map Thành Công<color>");
			elseif nItemId==6 then
				local szData = KFile.ReadTxtFile("\\interface2\\Kato\\BaoBoss\\TDLT.txt");	
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = szData});
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Đến Map Chiến Đấu<color>");
			end			
	elseif szWnd == BTNChatThanKyThach then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em đập đá 1 cạnh!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em đập đá 2 cạnh!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em đập đá ba cạnh!!");		
			elseif nItemId==4 then
       	SendChannelMsg("Team", "Anh em đập đá 4 cạnh!!");
			elseif nItemId==5 then
       	SendChannelMsg("Team", "Anh em đập đá 5 cạnh!!");
			elseif nItemId==6 then
       	SendChannelMsg("Team", "Anh em đập đá 6 cạnh!!");
			elseif nItemId==7 then
       	SendChannelMsg("Team", "nhandomaida");
		 	end
	elseif szWnd == BTNChatRoiLauLan then
			if nItemId==1 then
		SendChannelMsg("Team", "Anh em nhận nhiệm vụ lâu lan!!");
			elseif nItemId==2 then
        SendChannelMsg("Team", "Anh em vào lâu lan!!");	
			elseif nItemId==3 then
       	SendChannelMsg("Team", "Anh em rời khỏi lâu lan!!");		
			elseif nItemId==4 then
       	SendChannelMsg("Team", "Anh em nhận thưởng lâu lan!!");
		 	end		
	elseif szWnd == BTNChatgottt then
			if nItemId==1 then self:nhanlenhbai();
			elseif nItemId==2 then self:nhannhiemvu();
			elseif nItemId==3 then self:vaottt();
			elseif nItemId==4 then self:nhanthuong();
		    end
	elseif szWnd == BTNChatGoHLVM then
	        if nItemId == 1 then self:BaodanhHL();
		    elseif nItemId == 2 then self:VaoHL();
		    elseif nItemId == 3 then self:Vuotrunggai();
		    elseif nItemId == 4 then self:Phong();
		    elseif nItemId == 5 then self:Lam();
		    elseif nItemId == 6 then self:Hoa();
		    elseif nItemId == 7 then self:Son();
		    elseif nItemId == 8 then self:chatTang2();
		    elseif nItemId == 9 then self:Tangboss3();
		    elseif nItemId == 10 then self:chatTang4();
			elseif nItemId == 11 then self:chatso0();
			elseif nItemId == 12 then self:TNVHLVM();
		    end
	elseif szWnd == BTNChatGoBMS then
	        if nItemId == 1 then self:BDBMS();
		    elseif nItemId == 2 then self:VaoBMS();
		    elseif nItemId == 3 then self:BaocaoNKT();
		    elseif nItemId == 4 then self:BaocaoDBC();
		    elseif nItemId == 5 then self:Bosscuoi();
		    elseif nItemId == 6 then self:QuitBMS();
			elseif nItemId == 7 then self:TNVBMS();
		    end
	elseif szWnd == BTNChatGoHSPN then
	        if nItemId == 1 then self:BDHSPN();
		    elseif nItemId == 2 then self:VaoHS();
		    elseif nItemId == 3 then self:Batchuot();
		    elseif nItemId == 4 then self:Vuotrao();
		    elseif nItemId == 5 then self:Nghiaquan();
			elseif nItemId == 6 then self:gophong();
		    elseif nItemId == 7 then self:Thaoduoc();
		    elseif nItemId == 8 then self:Daocu();
		    elseif nItemId == 9 then self:QuitHSPN();
			elseif nItemId == 10 then self:TNVHSPN();
		    end
	elseif szWnd == BTNChatgiatoc then
		    if nItemId == 1 then self:VaoLanhDia();
		    elseif nItemId == 2 then self:VaoGiaToc();
		    elseif nItemId == 3 then self:LoThong();
		    elseif nItemId == 4 then self:RaGiaToc();
		    elseif nItemId == 5 then self:DongTienCo();
			elseif nItemId == 6 then self:ChatLuongGT();
			elseif nItemId == 7 then self:Chattrongcay();
		    end	
	elseif szWnd == BTNChatTQL then
		    if nItemId == 1 then self:LBTQL();
		    elseif nItemId == 2 then self:NVTQL();
		    elseif nItemId == 3 then self:VaoTQL();
		    elseif nItemId == 4 then self:RoiTQL();
			elseif nItemId == 5 then
				SendChannelMsg("Team", "Anh em nhận thưởng TQL!!");
			elseif nItemId == 6 then
				SendChannelMsg("Team", "Anh em điểm truyền tống 2!!");	
		    end	
	elseif szWnd == BTNChatRacTDC then
		    if nItemId == 1 then self:ChatNhatNhanh();
			elseif nItemId == 2 then self:ChatRacTDC1();
		    elseif nItemId == 3 then self:vutrac();
		    end				
	elseif szWnd == BTNChatGoTDC then
            if nItemId == 1 then self:vaoTDC1();
		    elseif nItemId == 2 then self:vaoTDC2();
		    elseif nItemId == 3 then self:DoiTheBiBao();
		    elseif nItemId == 4 then self:DoiBacKhoaTH();
		    elseif nItemId == 5 then self:NhanThuongThang();		
		    elseif nItemId == 6 then self:NhanSoTay();
		    end
	elseif szWnd == BTNChatPhoThuyLoi then
            if nItemId == 1 then self:ChatPhoThuyLoi1();
		    elseif nItemId == 2 then self:ChatPhoThuyLoi3();
			elseif nItemId == 3 then self:ChatPhoThuyLoi2();
			end
	elseif szWnd == BTNChatPET then
            if nItemId == 1 then self:Chatpet1();
		    elseif nItemId == 2 then self:Chatpet2();
			elseif nItemId == 3 then self:Chatpet3();
			end	
	elseif szWnd == BTNChattuiQH then
            if nItemId == 1 then self:ChattuiQH1();
		    elseif nItemId == 2 then self:chatdocsach();
			end			
	elseif szWnd == BTNChatNLHN then
	        if nItemId==1 then self:baodanhnlhn();
			elseif nItemId==2 then self:vaonlhn();		
			elseif nItemId==3 then self:batnguanlhn();
			elseif nItemId==4 then self:tetudai();
			elseif nItemId==5 then self:trabai();
		    elseif nItemId==6 then self:roikhoi();
		    elseif nItemId==7 then self:tranhiemvunlhn();
			end
	elseif szWnd == BTNChatBuLak then
            if nItemId == 1 then self:lak7();
		    elseif nItemId == 2 then self:lak10();
		    elseif nItemId == 3 then self:lak1kill();
		    elseif nItemId == 4 then self:lakphandon();
		    elseif nItemId == 5 then self:lakkhang();		
		    end			
	end  
end	 
--------------------------add-------------------------------------

uiAutoQuanDoanh.PeepChatMsg =function(self)
	uiAutoQuanDoanh.OnMsgArrival_bak	= uiAutoQuanDoanh.OnMsgArrival_bak or UiCallback.OnMsgArrival;
	function uiAutoQuanDoanh:OnMsgArrival(nChannelID, szSendName, szMsg)
		uiAutoQuanDoanh:SeeChatMsg(szMsg);
		uiAutoQuanDoanh.OnMsgArrival_bak(UiCallback, nChannelID, szSendName, szMsg);
	end
end

function uiAutoQuanDoanh:OnOpen()
	self:LoadSetting();
	
	Wnd_SetFocus(self.UIGROUP, self.EDT_NEEDB);
	Wnd_SetFocus(self.UIGROUP, self.EDT_FREEBAG);
	self:UpdateEdit();
end

function uiAutoQuanDoanh:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY) or {};
	
	if not self.tbSetting.nFreeBag then
		self.tbSetting.nFreeBag = 2;
	end
		if  not self.tbSetting.nNeedBuy then
		self.tbSetting.nNeedBuy =30
		end
	
end
function uiAutoQuanDoanh:OnEditChange(szWndName, nParam)
	if (szWndName == self.EDT_FREEBAG) then
		local nFNum = Edt_GetInt(self.UIGROUP, self.EDT_FREEBAG);
		if (nFNum == self.tbSetting.nFreeBag) then	
			return;
		end
		if (nFNum < 0) then
			nFNum = 0;
		end
		if (nFNum > 100) then
			nFNum = 99;
		end
		if szFreeBag == "" or nil then
		self.tbSetting.nFreeBag = 2
		end
		self.tbSetting.nFreeBag = nFNum;
		self:UpdateEdit();
	end
	if (szWndName == self.EDT_NEEDB) then
		local nNNum = Edt_GetInt(self.UIGROUP, self.EDT_NEEDB);
		if (nNNum == self.tbSetting.nNeedB) then	
			return;
		end
		if (nNNum < 0) then
			nNNum = 0;
		end
		if (nNNum > 100) then
			nNNum = 99;
		end
		if szNeedB == "" or nil then
		self.tbSetting.nNeedB = 2
		end
		self.tbSetting.nNeedB = nNNum;
		self:UpdateEdit();
	end
end

function uiAutoQuanDoanh:OnEditEnter(szWnd)
	if (szWnd == self.EDT_FREEBAG) or (szWnd == self.EDT_NEEDBUY) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
end
function uiAutoQuanDoanh:UpdateEdit()
	Edt_SetInt(self.UIGROUP, self.EDT_FREEBAG, self.tbSetting.nFreeBag);
	
	Edt_SetInt(self.UIGROUP, self.EDT_NEEDB, self.tbSetting.nNeedB);
end


function uiAutoQuanDoanh:SaveData()
	self:Save(self.DATA_KEY, self.tbSetting);
end


function uiAutoQuanDoanh:Save(szKey, tbData)
	self.m_szFilePath="\\user\\freebag.dat";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);

		KIo.WriteFile(self.m_szFilePath, szData);
	
end

function uiAutoQuanDoanh:Load(key)
	self.m_szFilePath="\\user\\freebag.dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);

	if (szData) then
			self.m_tbData = Lib:Str2Val(szData);
	end
	local tbData = self.m_tbData[key];
	return tbData
end


function uiAutoQuanDoanh:OnPickTimer()
	if (nPickState == 0) then
		return 0
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	if Map.firedown == 1 then
		return 0
	end
----------------
if me.GetMapTemplateId() > 273 and me.GetMapTemplateId() < 556  then
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong map nhiệm vụ<color>");
		me.Msg("<color=yellow>Chức năng này chỉ hoạt động trong map nhiệm vụ<color>")
		nPickState = 0;
		return
	end
-------------------
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 4038) then  -- HLVM 
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào HLVM [Shift+A]<color>");
			me.AnswerQestion(2)
			me.AnswerQestion(1)
			break;
		elseif (pNpc.nTemplateId == 2955) then  --AutoQuanDoanh
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào VAGT [Shift+A]<color>");
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;	

		end
	end
	
	if me.GetMapTemplateId() > 65500 then
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình [Shift+A]");
		Timer:Close(nPickTimerId);
	end
end

function uiAutoQuanDoanh:AutoPick()
	if nPickState == 0 then 
		nPickState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Mở chức năng vào HLVM và VAGT [Shift+A]");
		nPickTimerId = Timer:Register(Env.GAME_FPS * nPickTime, self.OnPickTimer, self);
	else
		nPickState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chức năng vào HLVM và VAGT [Shift+A]");
		Timer:Close(nPickTimerId);
	end
end



function uiAutoQuanDoanh:OnSay(szChannelName, szName, szMsg, szGateway)
	local stype
	if   szChannelName=="Team" then
		stype="Đồng Đội"
	elseif  szChannelName=="Tong" then
		stype="Bang"
	elseif  szChannelName=="Friend" then
		stype="Hảo hữu"
	elseif  szChannelName=="Kin" then
		stype="Gia Tộc"
	elseif  szChannelName=="NearBy" then
		stype="Lân cận"
	end
	end
	
----------
function uiAutoQuanDoanh:ChatTeam()
UiManager:SwitchWindow(Ui.UI_CONSET);
end
-----------	
---------------------NLHN------------------
function uiAutoQuanDoanh:baodanhnlhn()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em báo danh Ngạc Luân Hà Nguyên nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:vaonlhn()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào Ngạc Luân Hà Nguyên nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:batnguanlhn()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em bắt ngựa nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:tetudai()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đến Tế Tự Đài nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:trabai()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em trả bài nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:roikhoi()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em rời khỏi Ngạc Luân Hà Nguyên nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:tranhiemvunlhn()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em trả nhiệm vụ Ngạc Luân Hà Nguyên nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
-------------------HLVM---------------------------
function uiAutoQuanDoanh:VaoHL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào HLVM nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Vuotrunggai()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Rừng Gai");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:chatTang2()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tầng 2");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:chatTang4()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tầng 4");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BaodanhHL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em BDHLVM nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Phong()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1808,3223);
end


function uiAutoQuanDoanh:Lam()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1895,3196);
end

function uiAutoQuanDoanh:Hoa()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1835,3281);
end

function uiAutoQuanDoanh:Son()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1833,3185);
end

function uiAutoQuanDoanh:tang2()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1757,3454);
end

function uiAutoQuanDoanh:Tangboss3()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1746,3648);
end

function uiAutoQuanDoanh:tang4()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
end
self:StopAutoFight();
end
me.StartAutoPath(1940,3595);
end

function uiAutoQuanDoanh:TNVHLVM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả trả nhiệm vụ HLVM")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:chatso0()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả đoán số 0")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

-------------------------BMS------------------------------
function uiAutoQuanDoanh:VaoBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào BMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:BaocaoNKT()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Có bao nhiêu NKT rồi");
end
end

function uiAutoQuanDoanh:BaocaoDBC()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Có bao nhiêu ĐBC rồi");
end
end

function uiAutoQuanDoanh:Bosscuoi()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em ra chỗ cổ vương nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:QuitBMS()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em quit khỏi BMS");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BDBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em BDBMS nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end


function uiAutoQuanDoanh:DanhBossBMS()                                   
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1819,2845);
end

function uiAutoQuanDoanh:QuitBMS1()
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1837,2837);
end

function uiAutoQuanDoanh:TNVBMS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả trả nhiệm vụ BMS")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

-------------------------HSPN----------------------------
function uiAutoQuanDoanh:VaoHS()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào HSPN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Batchuot()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cùng nhau bắt chuột nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:Vuotrao()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vượt rào nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:Nghiaquan()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em tìm nghĩa quân nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:gophong()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy gỗ phong nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:Thaoduoc()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em hái thảo dược nào");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:Daocu()
if me.GetMapTemplateId() > 65500 then
SendChannelMsg("Team", "Anh em báo cáo đạo cụ nào");
end
end

function uiAutoQuanDoanh:QuitHSPN()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em quit khỏi HPNS");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:BDHSPN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em BDHSPN nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:TimNghiaQuan()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1764,3080);
end

function uiAutoQuanDoanh:QuitHPNS1()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
me.StartAutoPath(1666,3760);
end
end

function uiAutoQuanDoanh:TNVHSPN()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả trả nhiệm vụ HSPN")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
--------------------------Khac----------------------------
function uiAutoQuanDoanh:ChatLakTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận Lak TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatBuLakTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cắn Lak TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:lak7()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cán Lak Ma Đao Thạch cấp 7 nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:lak10()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cán Lak 10 nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:lak1kill()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Cắn Lak 1 skill nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:lakphandon()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cán Lak phản đòn nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:lakkhang()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em cắn Lak kháng tất cả nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:vaoTDC1()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em vào TDC 1 nào!!")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh:vaoTDC2()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào TDC 2 nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh.NhanThuongThang()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Nhận thưởng tháng TDC")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.NhanSoTay()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Nhận lại sổ thu thập thẻ")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.DoiTheBiBao()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Đổi thẻ bí bảo")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.DoiBacKhoaTH()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Đổi bạc khóa tại Thương Hội")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh:Chatgohome()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "gohome1")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatRTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDC nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMTDC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu TDC nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatTRAM()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Trả máu Phúc Lợi!!");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatBHDserver()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào BHĐ Liên Server nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatGhepHT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi ghép HT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatBVD()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em chạy BVĐ nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatLuongGT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em nhận lương nào !!")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.ChatLuuRuong()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Lưu điểm về thành")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.Chatcomo()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em nhận NVCM nào !!")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.ChattuiQH1()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em nhận túi quân hưởng nào !!")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.ChatStartlua()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "dotlua1")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiAutoQuanDoanh.Chatstoplua()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "stopdotlua")
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
---------- gọi vào Mộng cảnh ----------
function uiAutoQuanDoanh:ChatPhoThuyLoi1()
if me.GetMapTemplateId() < 225 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào Mộng Cảnh thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatPhoThuyLoi2()
if me.GetMapTemplateId() > 65540 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em rời khỏi Mộng Cảnh thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatPhoThuyLoi3()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh Em ơi Train trong Mộng Cảnh!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:QuitMongCanh()						
if me.GetMapTemplateId() > 65500 then
if me.GetNpc().IsRideHorse() == 0 then
   Switch([[horse]]);
   end
self:StopAutoFight();
end
me.StartAutoPath(1600,3200);
--self:ProcessClick(tbPos, ...);
end
-------------- tự vào VAGT và nhận thưởng-----------
function uiAutoQuanDoanh:VaoGiaToc()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh Em ơi Vào Ải gia tộc chơi đê!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end


function uiAutoQuanDoanh:DongTienCo()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi đổi tiền nào!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh.RaGiaToc()
if me.GetMapTemplateId() > 65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Xong ải gia tộc rồi ra thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh.LoThong()
if me.GetMapTemplateId() > 65000 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lên bem con boss cuối nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh.VaoLanhDia()
if me.GetMapTemplateId() < 30 then
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
	SendChannelMsg("Team", "Anh em vào lãnh địa gia tộc nào !!")
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
else
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
	SendChannelMsg("Team", "Anh em rời khỏi lãnh địa gia tộc nào !!")
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
end
-------------
function uiAutoQuanDoanh:ChatRTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu TDLT nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatThuongTDLT()
if me.GetMapTemplateId() < 255 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Nhận thưởng TDLT mau thôi")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end
-------- báo boss-------
function uiAutoQuanDoanh:ChatBoss()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em bật/tắt báo boss nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
------------ vứt nguyên liệu TDC-------
SendChannelMsg("Team","Tất cả bât nhặt đồ nhanh");

function uiAutoQuanDoanh:ChatNhatNhanh()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team","Tất cả bât nhặt đồ nhanh");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatRacTDC1()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em xả rác nào <pic=94>!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:vutrac()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em bán rác HT nào <pic=94>!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
----------------------------TongKim--------------------------
function uiAutoQuanDoanh:ChatVaoMC()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào MÔNG CỔ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatVaoTH()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào TÂY HẠ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
---------LMKP-------
function uiAutoQuanDoanh:ChatVaoLMPK()
if me.GetMapTemplateId() < 225 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em vào Hầm thôi!!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end

function uiAutoQuanDoanh:ChatLMPK()
if me.GetMapTemplateId()>65500 then
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Đi qua nào !!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
end
---------------


function uiAutoQuanDoanh:ChatRuongTK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em lấy rương máu Tống Kim!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMAUTK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu Tống Kim!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMauTDLT()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương máu Phúc Lợi!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatNVHK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhan,tra nv hiep khach nao!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMUAMAU()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi mua máu nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatCai()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em đi mua thức ăn!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
----------------- Ext---------------
function uiAutoQuanDoanh:LBTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận Lệnh bài TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:NVTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận nhiệm vụ TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:VaoTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Vào TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:RoiTQL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Rời khỏi TQL nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatCKP()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "muackp")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatTTP()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "muattp")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
function uiAutoQuanDoanh:ChatTBLenh()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở rương tinh binh lệnh")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
function uiAutoQuanDoanh:ChatTuoiThoNgua()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em tăng tuổi thọ ngựa nào!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end
function uiAutoQuanDoanh:ChatDA()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "anda")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatQNL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "anqnl")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatNangDong()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em nhận điểm năng động nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chattrongcay()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em trồng cây nào!!")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatruongTBD()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "moruong")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatcheckskill()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em CHECK SKILL")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatMAIL()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mở mail")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chathoisinh()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em Hồi Sinh")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:nhanlenhbai()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "lbttt")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:nhannhiemvu()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "nvttt")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:vaottt()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "vaottt")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:nhanthuong()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "thuongttt")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatpet1()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "teammopet1")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatpet2()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "teammopet2")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatpet3()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "teammopet3")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatTUCHAU()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "anh em mở tu châu")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:chatdocsach()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "anh em nhận NV đọc sách nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatkimte()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em mua kim tê nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:Chatsuado()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Anh em sửa đồ nào")
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

--------------------------HE THONG------------------------
function uiAutoQuanDoanh:GetTeamLeader()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if nAllotModel and tbMemberList then
    local tLeader = tbMemberList[1];
    local pNpc = KNpc.GetByPlayerId(tLeader.nPlayerID);
    if(not pNpc or pNpc.szName == me.szName) then
    	return nil;
    end
		return pNpc;
	end
end

function uiAutoQuanDoanh:ChatFollow()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật hộ tống");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStartBuff()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật tự buff");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStartPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả bật tự động đánh");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:ChatStopPK()
local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
if nTeamLeader == 1 then
SendChannelMsg("Team", "Tất cả dừng mọi hoạt động");
else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
end
end

function uiAutoQuanDoanh:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function uiAutoQuanDoanh:StartAutoFight()
	if me.nAutoFightState ~= 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end
--------------------------------------------------------------------------

function uiAutoQuanDoanh:ScrReload()
	UiManager:CloseWindow(Ui.UI_AutoQuanDoanh)
end

