--- Thanh TOOL95 - di chuyển nhanh ---
Ui.UI_TOOL95		= "UI_TOOL95";
local uiTOOL95			= Ui.tbWnd[Ui.UI_TOOL95] or {};	
uiTOOL95.UIGROUP		= Ui.UI_TOOL95;
Ui.tbWnd[Ui.UI_TOOL95] = uiTOOL95

--------Các Menu

uiTOOL95.BTN_Kim95				="BtnKim95"
uiTOOL95.BTN_Moc95				="BtnMoc95"
uiTOOL95.BTN_Thuy95				="BtnThuy95"
uiTOOL95.BTN_Hoa95				="BtnHoa95"
uiTOOL95.BTN_Tho95				="BtnTho95"

uiTOOL95.BTN_DiemChau		="BtnDiemChau"
uiTOOL95.BTN_DongHa			="BtnDongHa"
uiTOOL95.BTN_KhacDi			="BtnKhacDi"
uiTOOL95.BTN_NgotLat		="BtnNgotLat"

uiTOOL95.BTN_TanLang		="BtnTanLang"
uiTOOL95.BTN_Up				="BtnUp"
uiTOOL95.BTN_Down			="BtnDown"

--------------------
local tbTimer 				= Ui.tbLogic.tbTimer;
local self					= uiTOOL95;


Ui:RegisterNewUiWindow("UI_TOOL95", "tool95", {"a", 310, 450}, {"b", 372, 575}, {"c", 392, 32});
	
uiTOOL95.tbAllModeResolution	= {
	["a"]	= { 210, 54 },
	["b"]	= { 430, 5 },
	["c"]	= { 392, 32 },
};

uiTOOL95.Kim95 =
{ 
	{" Sắc Lặc Xuyên "},
	{" Thục Cương Sơn "},
	{" Miêu Lĩnh "},
	{" Vũ Lăng Sơn "},
	{" Hoa Sơn "},
	{" Chủ pt "},

};
uiTOOL95.Moc95 =
{ 
	{" Sắc Lặc Xuyên "},
	{" Thục Cương Sơn "},
	{" Miêu Lĩnh "},
	{" Gia Du Quan "},
	{" Hoa Sơn "},
	{" Chủ pt "},
};
uiTOOL95.Thuy95 =
{ 
	{" Phong Đô Quỹ Thành "},
	{" Thục Cương Sơn "},
	{" Vũ Di Sơn "},
	{" Miêu Lĩnh "},
	{" Sắc Lặc Xuyên "},
	{" Chủ pt "},
};
uiTOOL95.Hoa95 =
{ 
	{" Phong Đô Quỹ Thành "},
	{" Vũ Di Sơn "},
	{" Gia Du Quan "},
	{" Vũ Lăng Sơn "},
	{" Hoa Sơn "},
	{" Chủ pt "},
};
uiTOOL95.Tho95 =
{ 
	{" Hoa Sơn "},
	{" Vũ Di Sơn "},
	{" Gia Du Quan "},
	{" Phong Đô Quỹ Thành "},
	{" Vũ Lăng Sơn "},
	{" Chủ pt "},
};
	
uiTOOL95.DiemChau =
{
	{" Diêm Châu 1 "},
	{" Diêm Châu 2 "},
	{" Diêm Châu 3 "},
	{" Diêm Châu 4 "},
	{" Diêm Châu 5 "},
	{" Diêm Châu 6 "},
	{" Chủ pt "},
};	
uiTOOL95.DongHa =
{
	{" Đông Hạ 1 "},
	{" Đông Hạ 2 "},
	{" Đông Hạ 3 "},
	{" Đông Hạ 4 "},
	{" Đông Hạ 5 "},
	{" Đông Hạ 6 "},
	{" Chủ pt "},
};	
uiTOOL95.KhacDi =
{
	{" Khắc Di 1 "},
	{" Khắc Di 2 "},
	{" Khắc Di 3 "},
	{" Khắc Di 4 "},
	{" Khắc Di 5 "},
	{" Khắc Di 6 "},
	{" Chủ pt "},
};	
uiTOOL95.NgotLat =
{
	{" Ngột Lạt 1 "},
	{" Ngột Lạt 2 "},
	{" Ngột Lạt 3 "},
	{" Ngột Lạt 4 "},
	{" Ngột Lạt 5 "},
	{" Ngột Lạt 6 "},
	{" Chủ pt "},
};	
uiTOOL95.TanLang =
{
	{" Cửa Phù 3 "},
	{" Cửa Phù 5 "},
	{" Vào Tần Lăng "},
};	

self.tbOptionSetting = {};

uiTOOL95.OnButtonClick_Bak = uiTOOL95.OnButtonClick;

uiTOOL95.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_Kim95) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Kim95[1][1],
		1,
		self.Kim95[2][1],
		2,
		self.Kim95[3][1],
		3,
		self.Kim95[4][1],
		4,
		self.Kim95[5][1],
		5,
		self.Kim95[6][1],
		6
		);
	elseif (szWnd == self.BTN_Moc95) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Moc95[1][1],
		1,
		self.Moc95[2][1],
		2,
		self.Moc95[3][1],
		3,
		self.Moc95[4][1],
		4,
		self.Moc95[5][1],
		5,
		self.Moc95[6][1],
		6
		);
	elseif (szWnd == self.BTN_Thuy95) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Thuy95[1][1],
		1,
		self.Thuy95[2][1],
		2,
		self.Thuy95[3][1],
		3,
		self.Thuy95[4][1],
		4,
		self.Thuy95[5][1],
		5,
		self.Thuy95[6][1],
		6
		);
	elseif (szWnd == self.BTN_Hoa95) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Hoa95[1][1],
		1,
		self.Hoa95[2][1],
		2,
		self.Hoa95[3][1],
		3,
		self.Hoa95[4][1],
		4,
		self.Hoa95[5][1],
		5,
		self.Hoa95[6][1],
		6
		);		
	elseif (szWnd == self.BTN_Tho95) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Tho95[1][1],
		1,
		self.Tho95[2][1],
		2,
		self.Tho95[3][1],
		3,
		self.Tho95[4][1],
		4,
		self.Tho95[5][1],
		5,
		self.Tho95[6][1],
		6
		);	
		
	elseif (szWnd == self.BTN_DiemChau) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.DiemChau[1][1],
		1,
		self.DiemChau[2][1],
		2,
		self.DiemChau[3][1],
		3,
		self.DiemChau[4][1],
		4,
		self.DiemChau[5][1],
		5,
		self.DiemChau[6][1],
		6,
		self.DiemChau[7][1],
		7
		);		
	elseif (szWnd == self.BTN_DongHa) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.DongHa[1][1],
		1,
		self.DongHa[2][1],
		2,
		self.DongHa[3][1],
		3,
		self.DongHa[4][1],
		4,
		self.DongHa[5][1],
		5,
		self.DongHa[6][1],
		6,
		self.DongHa[7][1],
		7
		);	
	elseif (szWnd == self.BTN_KhacDi) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.KhacDi[1][1],
		1,
		self.KhacDi[2][1],
		2,
		self.KhacDi[3][1],
		3,
		self.KhacDi[4][1],
		4,
		self.KhacDi[5][1],
		5,
		self.KhacDi[6][1],
		6,
		self.KhacDi[7][1],
		7
		);	
	elseif (szWnd == self.BTN_NgotLat) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.NgotLat[1][1],
		1,
		self.NgotLat[2][1],
		2,
		self.NgotLat[3][1],
		3,
		self.NgotLat[4][1],
		4,
		self.NgotLat[5][1],
		5,
		self.NgotLat[6][1],
		6,
		self.NgotLat[7][1],
		7
		);	
	elseif (szWnd == self.BTN_TanLang) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		3,
		0,
		self.TanLang[1][1],
		1,
		self.TanLang[2][1],
		2,
		self.TanLang[3][1],
		3
		);	
	
		---------------New------------------
	
	elseif (szWnd == self.BTN_Up) then
		local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
		if nMapId== 1536 then
			local tbPos = {}
				tbPos.nMapId = 1536
				tbPos.nX = 1928
				tbPos.nY = 3847
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1537 then
			local tbPos = {}
				tbPos.nMapId = 1537
				tbPos.nX = 2173
				tbPos.nY = 3470
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1538 then
			local tbPos = {}
				tbPos.nMapId = 1538
				tbPos.nX = 1753
				tbPos.nY = 3522
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1539 then
			local tbPos = {}
				tbPos.nMapId = 1539
				tbPos.nX = 1897
				tbPos.nY = 3873
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)		
		end
	
	elseif (szWnd == self.BTN_Down) then
		local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
		if nMapId== 1539 then
			local tbPos = {}
				tbPos.nMapId = 1539
				tbPos.nX = 1478
				tbPos.nY = 3569
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1538 then
			local tbPos = {}
				tbPos.nMapId = 1538
				tbPos.nX = 1468
				tbPos.nY = 3245
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1537 then
			local tbPos = {}
				tbPos.nMapId = 1537
				tbPos.nX = 1692
				tbPos.nY = 3356
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
		elseif nMapId== 1536 then
			local tbPos = {}
				tbPos.nMapId = 1536
				tbPos.nX = 1535
				tbPos.nY = 3663
				Ui.tbLogic.tbAutoPath:GotoPos(tbPos)		
		end	
	end
end

uiTOOL95.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	
	 if szWnd == self.BTN_Kim95 then
		if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1640,3358"});
		elseif nItemId==2 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1676,2914"});	
		elseif nItemId==3 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1624,3180"});		
		elseif nItemId==4 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1455,3256"});	  
		elseif nItemId==5 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1950,3629"});
		elseif nItemId==6 then
			uiTOOL95:BossKim95();			
		end
	 end
	 ----------------------------------
	 if szWnd == self.BTN_Moc95 then
		if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1893,3402"});
		elseif nItemId==2 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1496,3141"});
		elseif nItemId==3 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1711,3781"});	
		elseif nItemId==4 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1747,3228"});
		elseif nItemId==5 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1582,3811"});
		elseif nItemId==6 then
			uiTOOL95:BossMoc95();			
		end
	 end
	 -----------------------------------------
	 if szWnd == self.BTN_Thuy95 then
		if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1555,3488"});
		elseif nItemId==2 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1485,3426"});
		elseif nItemId==3 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1910,3850"});		
		elseif nItemId==4 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1841,3420"});	  
		elseif nItemId==5 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1875,3835"});	
		elseif nItemId==6 then
			uiTOOL95:BossThuy95();			
		end
	 end
	 ---------------------------------------------------------------
	 if szWnd == self.BTN_Hoa95 then
		if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1707,3945"});
		elseif nItemId==2 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1596,3329"});	
		elseif nItemId==3 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1428,3093"});		
		elseif nItemId==4 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1608,3535"});	  
		elseif nItemId==5 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1601,3366"});	
		elseif nItemId==6 then
			uiTOOL95:BossHoa95();			
		end
	 end
	 -------------------------------------------
	 if szWnd == self.BTN_Tho95 then
			if nItemId==1 then
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1905,3280"});
			elseif nItemId==2 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1617,3846"});
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1722,2877"});	
			elseif nItemId==4 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1828,3453"});	  
			elseif nItemId==5 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1588,3085"});	
			elseif nItemId==6 then
				uiTOOL95:BossTho95();		
			end
	 end
 ---------------------------------------------------
	if szWnd == self.BTN_DiemChau then
			if nItemId==1 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1879,3358"});
			elseif nItemId==2 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1774,3267"});	
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1752,3484"});		
			elseif nItemId==4 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1750,3633"});	  
			elseif nItemId==5 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1910,3736"});	
			elseif nItemId==6 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1932,3568"});
			elseif nItemId==7 then
				uiTOOL95:BossDiemChau();			
				
			end
	 end
	 ---------------------------------------------------
	if szWnd == self.BTN_DongHa then
			if nItemId==1 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1900,2842"});
			elseif nItemId==2 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1848,3029"});	
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1920,3129"});		
			elseif nItemId==4 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1805,3304"});	  
			elseif nItemId==5 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1611,3247"});	
			elseif nItemId==6 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1677,2992"});
			elseif nItemId==7 then
				uiTOOL95:BossDongHa();		
			end
	 end
---------------------------------------------------
	if szWnd == self.BTN_KhacDi then
			if nItemId==1 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1863,3435"});
			elseif nItemId==2 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1967,3286"});	
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,2029,3396"});		
			elseif nItemId==4 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1862,3659"});	  
			elseif nItemId==5 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1770,3573"});	
			elseif nItemId==6 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1729,3284"});	
			elseif nItemId==7 then
				uiTOOL95:BossKhacDi();		
			end
	 end
---------------------------------------------------
	if szWnd == self.BTN_NgotLat then
			if nItemId==1 then
			
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1752,3552"});
			elseif nItemId==2 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1932,3730"});
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1944,3401"});		
			elseif nItemId==4 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1860,3280"});	  
			elseif nItemId==5 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1683,3328"});	
			elseif nItemId==6 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1813,3511"});
			elseif nItemId==7 then
				uiTOOL95:BossNgotLat();			
			end
	 end
	 if szWnd == self.BTN_TanLang then
			
			if nItemId==1 then
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",1536,1401,3620"});
			elseif nItemId==2 then -- truyen tong 5 
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",1536,1591,3449"});
			elseif nItemId==3 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,2441,1"});
			end
	 end
end	
function uiTOOL95:BossKim95()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss kim 95 nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossMoc95()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss mộc 95 nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossThuy95()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss thủy 95 nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossHoa95()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss hỏa 95 nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossTho95()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss thổ 95 nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossDiemChau()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss diêm châu nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossDongHa()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss đông hạ nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossKhacDi()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss khắc di nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end
function uiTOOL95:BossNgotLat()
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	if nTeamLeader == 1 then
		SendChannelMsg("Team", "Anh em săn boss ngột lạt nào!!");
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chủ PT mới dùng được chức năng này");
	end
end

function uiTOOL95:ScrReload()
	UiManager:CloseWindow(Ui.UI_TOOL95)
end
