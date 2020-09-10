Ui.UI_AUTOAIM_UI		= "UI_AUTOAIM_UI";
local uiAutoAimUi		= Ui.tbWnd[Ui.UI_AUTOAIM_UI] or {};
uiAutoAimUi.UIGROUP		= Ui.UI_AUTOAIM_UI;
Ui.tbWnd[Ui.UI_AUTOAIM_UI] 	= uiAutoAimUi;

local KeyDefCfg = {
		[1] 	= {name="", key=""},
		[2] 	= {name="", key=""},
		[3] 	= {name="", key=""},
		[4] 	= {name="", key=""},
		[5] 	= {name="", key=""},
		[6] 	= {name="", key=""},
		[7] 	= {name="", key=""},
		[8] 	= {name="", key=""},
		[9] 	= {name="", key=""},
		[10] 	= {name="", key=""},
		[11] 	= {name="", key=""},
		[12] 	= {name="", key=""},
		[13] 	= {name="", key=""},
		[14] 	= {name="", key=""},
		[15] 	= {name="", key=""},
		[16] 	= {name="", key=""},
		[17] 	= {name="", key=""},
		[18] 	= {name="", key=""},
		[19] 	= {name="", key=""},
		[21] 	= {name="", key=""},
		[22] 	= {name="", key=""},
		[23] 	= {name="", key=""},
		[24] 	= {name="", key=""},
		[25] 	= {name="", key=""},
		[26] 	= {name="", key=""},
		[27] 	= {name="", key=""},
		[28] 	= {name="", key=""},
		[29] 	= {name="", key=""},
		[30] 	= {name="", key=""},
		[31] 	= {name="", key=""},
		[32] 	= {name="", key=""},
		[33] 	= {name="", key=""},
		[34] 	= {name="", key=""},
		[35] 	= {name="", key=""},
		[36] 	= {name="", key=""},
		[37] 	= {name="", key=""},
		[38] 	= {name="", key=""},
		[39] 	= {name="", key=""},
		[40] 	= {name="", key=""},
		[41] 	= {name="", key=""},
		[42] 	= {name="", key=""},
		[43] 	= {name="", key=""},
		[44] 	= {name="", key=""},
		[45] 	= {name="", key=""},
		[46] 	= {name="", key=""},
		[47] 	= {name="", key=""},
		[48] 	= {name="", key=""},
		[49] 	= {name="", key=""},
		[50] 	= {name="", key=""},
		[51] 	= {name="", key=""},
		[52] 	= {name="", key=""},
		
		}

function uiAutoAimUi:Init()
	--self.HealDelay = 0.5;
	self.UserFile	= "\\interface2\\All\\Key.lua";
	--self:LoadSetting();
	self:LoadKeyData();
	self:KeyUpDate();
	--self:UpdateAimCfg();
end

function uiAutoAimUi:LoadKeyData()
	self.KEY_CFG	= {};
	local szKey		= KFile.ReadTxtFile(self.UserFile);
	if (not szKey) then
		for i=1,#KeyDefCfg do
			self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
		end
	else
		local tbMyKeyData	= Lib:Str2Val(szKey);
		for k, v in pairs(tbMyKeyData) do
			self.KEY_CFG[k] = {name=tbMyKeyData[k].nName,key=tbMyKeyData[k].nKey};
		end
	end
end

function uiAutoAimUi:SaveKeyData()
	self.tbUserKeyData ={}
	for i = 1,#KeyDefCfg do
		self.tbUserKeyData[i] = {nName=self.KEY_CFG[i].name,nKey=self.KEY_CFG[i].key};	
	end
	local szKey	= Lib:Val2Str(self.tbUserKeyData);
	KFile.WriteFile(self.UserFile, szKey);
end

function uiAutoAimUi:LoadKeyDefault()
	for i = 1,#KeyDefCfg do
		self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
	end
	self:SaveKeyData()
end

function uiAutoAimUi:KeyLoad()
	for i=1,#KeyDefCfg do
		local nMsg = Edt_GetTxt(self.UIGROUP, self.KEY_CFGSET[i]);
		self.KEY_CFG[i].key = nMsg;
	end
	self:SaveKeyData()
end

function uiAutoAimUi:KeyUpDate()

	local tCmd={ "UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)",	"UI_SUPERMAPLINK_UI",	"", self.KEY_CFG[1].key, self.KEY_CFG[1].key, "SuperMapLink" };
			AddCommand(self.KEY_CFG[1].key, self.KEY_CFG[1].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_TOOL)",	"UI_TOOL",	"", self.KEY_CFG[2].key, self.KEY_CFG[2].key, "Hỗ trợ quân doanh" };
			 AddCommand(self.KEY_CFG[2].key, self.KEY_CFG[2].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
			 
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_TOOLS)",	"UI_TOOLS","", self.KEY_CFG[3].key, self.KEY_CFG[3].key, "Di chuyển nhanh" };
			AddCommand(self.KEY_CFG[3].key, self.KEY_CFG[3].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_TOOLS1)", "UI_TOOLS1", "", self.KEY_CFG[4].key, self.KEY_CFG[4].key, "Tool tự động" };
			AddCommand(self.KEY_CFG[4].key, self.KEY_CFG[4].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Switch([[horse]])",	"SwitchMount",	"C", self.KEY_CFG[5].key, self.KEY_CFG[5].key, "Lên/xuống ngựa" };
			AddCommand(self.KEY_CFG[5].key, self.KEY_CFG[5].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_AutoQuanDoanh)",	"UI_AutoQuanDoanh",	"", self.KEY_CFG[6].key, self.KEY_CFG[6].key, "Điều khiển tổ đội" };
			AddCommand(self.KEY_CFG[6].key, self.KEY_CFG[6].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.pFishing:OnStart()",	"Fish",	"", self.KEY_CFG[7].key, self.KEY_CFG[7].key, "Câu cá" };
			AddCommand(self.KEY_CFG[7].key, self.KEY_CFG[7].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_diaoyu)",	"Diaoyu",	"", self.KEY_CFG[8].key, self.KEY_CFG[8].key, "Lưu tọa độ cá" };
			AddCommand(self.KEY_CFG[8].key, self.KEY_CFG[8].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ [[me.CallServerScript({"UseUnlimitedTrans", 6})]], "GoHome",	"", self.KEY_CFG[9].key, self.KEY_CFG[9].key, "Phù về thôn" };
			AddCommand(self.KEY_CFG[9].key, self.KEY_CFG[9].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.AutoSay)", "AutoSay",	"", self.KEY_CFG[10].key, self.KEY_CFG[10].key, "Tự rao - trả lời" };
			AddCommand(self.KEY_CFG[10].key, self.KEY_CFG[10].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ 'UiManager:SwitchWindow("UI_COMPOSE")', "UI_COMPOSE",	"", self.KEY_CFG[11].key, self.KEY_CFG[11].key, "Ghép HT" };
			AddCommand(self.KEY_CFG[11].key, self.KEY_CFG[11].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoEgg:FastPick()", "Fastpick", "", self.KEY_CFG[12].key, self.KEY_CFG[12].key, "Nhặt đồ nhanh" };
			AddCommand(self.KEY_CFG[12].key, self.KEY_CFG[12].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoEgg:AutoPick()", "AutoPick", "", self.KEY_CFG[13].key, self.KEY_CFG[13].key, "Nhặt vp nhiệm vụ" };
			AddCommand(self.KEY_CFG[13].key, self.KEY_CFG[13].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.Toolngt:OnSwitchMaiDa()", "MaiDa", "", self.KEY_CFG[14].key, self.KEY_CFG[14].key, "Nhận đồ mài đá" };
			AddCommand(self.KEY_CFG[14].key, self.KEY_CFG[14].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK7Switch()", "Laula", "", self.KEY_CFG[15].key, self.KEY_CFG[15].key, "Rời Lâu La" };
			AddCommand(self.KEY_CFG[15].key, self.KEY_CFG[15].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoXuyenSon:MaXSSwitch()", "MSX", "", self.KEY_CFG[16].key, self.KEY_CFG[16].key, "Vào VAGT" };
			AddCommand(self.KEY_CFG[16].key, self.KEY_CFG[16].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoXuyenSon:MrXSSwitch()", "Tien", "", self.KEY_CFG[17].key, self.KEY_CFG[17].key, "Đổi tiền cổ" };
			AddCommand(self.KEY_CFG[17].key, self.KEY_CFG[17].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK6Switch()", "RoiVAGT", "", self.KEY_CFG[18].key, self.KEY_CFG[18].key, "Rời ải gia tộc" };
			AddCommand(self.KEY_CFG[18].key, self.KEY_CFG[18].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoMau:LayMau2Switch()", "LayMau2", "", self.KEY_CFG[19].key, self.KEY_CFG[19].key, "Lấy máu TDLT" };
			AddCommand(self.KEY_CFG[19].key, self.KEY_CFG[19].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	local tCmd={ "Map.tbvCTTK:CTTK1Switch()", "VaoMC", "", self.KEY_CFG[20].key, self.KEY_CFG[20].key, "Vào MC" };
			AddCommand(self.KEY_CFG[20].key, self.KEY_CFG[20].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK2Switch()", "VaoTH", "", self.KEY_CFG[21].key, self.KEY_CFG[21].key, "Vào TH" };
			AddCommand(self.KEY_CFG[21].key, self.KEY_CFG[21].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK3Switch()", "MongCanh", "", self.KEY_CFG[22].key, self.KEY_CFG[2].key, "Vào Mộng cảnh" };
			AddCommand(self.KEY_CFG[22].key, self.KEY_CFG[22].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK4Switch()", "MongCanh2", "", self.KEY_CFG[23].key, self.KEY_CFG[23].key, "Rời Mộng cảnh" };
			AddCommand(self.KEY_CFG[23].key, self.KEY_CFG[23].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbvCTTK:CTTK5Switch()", "MongCanh3", "", self.KEY_CFG[24].key, self.KEY_CFG[24].key, "Train Mộng cảnh" };
			AddCommand(self.KEY_CFG[24].key, self.KEY_CFG[24].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.AutoNvKDM:OnnStep()", "KDM1", "", self.KEY_CFG[25].key, self.KEY_CFG[25].key, "Di chuyển KDM" };
			AddCommand(self.KEY_CFG[25].key, self.KEY_CFG[25].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.AutoNvKDM:OnSwitch()", "KDM2", "", self.KEY_CFG[26].key, self.KEY_CFG[26].key, "Auto KDM" };
			AddCommand(self.KEY_CFG[26].key, self.KEY_CFG[26].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTOFUBEN)", "TrongCay", "", self.KEY_CFG[27].key, self.KEY_CFG[27].key, "Trồng cây gia tộc" };
			AddCommand(self.KEY_CFG[27].key, self.KEY_CFG[27].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_IBSHOP)", "KTC", "", self.KEY_CFG[28].key, self.KEY_CFG[28].key, "TRÂN" };
			AddCommand(self.KEY_CFG[28].key, self.KEY_CFG[28].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoAim:AutoFollow()", "Follow", "", self.KEY_CFG[29].key, self.KEY_CFG[29].key, "Hộ tống" };
			AddCommand(self.KEY_CFG[29].key, self.KEY_CFG[29].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:OpenWindow(Ui.UI_REPOSITORY)", "ruong", "", self.KEY_CFG[30].key, self.KEY_CFG[30].key, "Mở rương từ xa" };
			AddCommand(self.KEY_CFG[30].key, self.KEY_CFG[30].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_STR_TEST)", "testc", self.KEY_CFG[31].key, self.KEY_CFG[31].key, "test cường hóa" };
			AddCommand(self.KEY_CFG[31].key, self.KEY_CFG[31].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_PERESPLUS_SETTING)", "mau", "", self.KEY_CFG[32].key, self.KEY_CFG[32].key, "Xảo thuật chiến đấu" };
			AddCommand(self.KEY_CFG[32].key, self.KEY_CFG[32].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:hhStartWaBao()", "WaBao", "", self.KEY_CFG[33].key, self.KEY_CFG[33].key, "Đào kho báu" };
			AddCommand(self.KEY_CFG[33].key, self.KEY_CFG[33].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbGetIdItem:State()", "getid", "", self.KEY_CFG[34].key, self.KEY_CFG[34].key, "Lấy ID vật phẩm" };
			AddCommand(self.KEY_CFG[34].key, self.KEY_CFG[34].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTODADAO)", "HT", "", self.KEY_CFG[35].key, self.KEY_CFG[35].key, "Truy nã" };
			AddCommand(self.KEY_CFG[35].key, self.KEY_CFG[35].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:StopBao()", "stopBVD", "", self.KEY_CFG[36].key, self.KEY_CFG[36].key, "Dừng BVD" };
			AddCommand(self.KEY_CFG[36].key, self.KEY_CFG[36].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:StartBao()", "StartBVD", "", self.KEY_CFG[37].key, self.KEY_CFG[37].key, "Chạy BVD" };
			AddCommand(self.KEY_CFG[37].key, self.KEY_CFG[37].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa1):State()", "Da1", "", self.KEY_CFG[38].key, self.KEY_CFG[38].key, "Mài đá 1" };
			AddCommand(self.KEY_CFG[38].key, self.KEY_CFG[38].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa2):State()", "Da2", "", self.KEY_CFG[39].key, self.KEY_CFG[39].key, "Mài đá 2" };
			AddCommand(self.KEY_CFG[39].key, self.KEY_CFG[39].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa3):State()", "Da3", "", self.KEY_CFG[40].key, self.KEY_CFG[40].key, "Mài đá 3" };
			AddCommand(self.KEY_CFG[40].key, self.KEY_CFG[40].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa4):State()", "Da4", "", self.KEY_CFG[41].key, self.KEY_CFG[41].key, "mài đá 4" };
			AddCommand(self.KEY_CFG[41].key, self.KEY_CFG[41].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa5):State()", "Da5", "", self.KEY_CFG[42].key, self.KEY_CFG[42].key, "Mài đá 5" };
			AddCommand(self.KEY_CFG[42].key, self.KEY_CFG[42].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_tbMaiDa6):State()", "Da6", "", self.KEY_CFG[43].key, self.KEY_CFG[43].key, "Mài đá 6" };
			AddCommand(self.KEY_CFG[43].key, self.KEY_CFG[43].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbGetIdNpc:GetIdNpc()", "Getidmap", "", self.KEY_CFG[44].key, self.KEY_CFG[44].key, "Lấy tọa độ" };
			AddCommand(self.KEY_CFG[44].key, self.KEY_CFG[44].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.uiDetector:Switch()", "boss", "", self.KEY_CFG[45].key, self.KEY_CFG[45].key, "Báo boss" };
			AddCommand(self.KEY_CFG[45].key, self.KEY_CFG[45].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbAutoAsist:Asistswitch()", "buff", "", self.KEY_CFG[46].key, self.KEY_CFG[46].key, "Buff skill" };
			AddCommand(self.KEY_CFG[46].key, self.KEY_CFG[46].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Ui(Ui.UI_THUONGHOI):State()", "thuonghoi", "", self.KEY_CFG[47].key, self.KEY_CFG[47].key, "Thương hội" };
			AddCommand(self.KEY_CFG[47].key, self.KEY_CFG[47].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "SwitchTipMode()", "tipmode", "", self.KEY_CFG[48].key, self.KEY_CFG[48].key, "hiển thị chi tiết thuộc tính vk thần sa" };
			AddCommand(self.KEY_CFG[48].key, self.KEY_CFG[48].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Map.tbInputZero:InputZeroSwitch()", "so0", "", self.KEY_CFG[49].key, self.KEY_CFG[49].key, "Đoán số 0 HLVM" };
			AddCommand(self.KEY_CFG[49].key, self.KEY_CFG[49].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "Open([[map]], 2)", "minimpa", "", self.KEY_CFG[50].key, self.KEY_CFG[50].key, "Mini Map" };
			AddCommand(self.KEY_CFG[50].key, self.KEY_CFG[50].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
			
	local tCmd={ "UiManager:SwitchWindow(Ui.UI_UNREAL)", "UI_UNREAL", "", self.KEY_CFG[51].key, self.KEY_CFG[51].key, "thanh cong cu" };
			AddCommand(self.KEY_CFG[51].key, self.KEY_CFG[51].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
			UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);		
	
end

uiAutoAimUi:Init();
--LoadUiGroup(Ui.UI_AUTOAIM_UI, "autoFollow.ini");
