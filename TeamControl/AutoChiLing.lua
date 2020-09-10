-----Edited by Quốc Huy-----

local self = tbAutoChiLing;
local tbAutoChiLing	= Map.tbAutoChiLing or {}; 
Map.tbAutoChiLing	= tbAutoChiLing;


local GuessSwitch = 1;
local Guess2Switch = 1;
local TeamLeaderGetBox=0;

local MainPlayer="";

local nLenh1 =0;
local nLenh2 =0;
local nLenh3 =0;
local nTimerIdGoHome =0;
local nTimerIdDotLua =0;
local nGoHome =0;
local nChoseTime=0.6;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local nCheckMap1TimerId=0;
local nCheckMap2TimerId=0;
local nCheckMap3TimerId=0;
local nChose3TimerId=0;
local nAutoTaskTimerId=0;
local i,j,k,a,b,c

function tbAutoChiLing:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbAutoChiLing.Say_bak	= tbAutoChiLing.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbAutoChiLing.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()			
			tbAutoChiLing:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Timer:Register(1, fnOnSay);
	end

end

tbAutoChiLing.Init =function(self)
	self:ModifyUi();
end

function tbAutoChiLing:OnSay(szChannelName, szName, szMsg, szGateway)	
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
	
	if (GuessSwitch == 0) then
		return;
	end

	if string.find(szMsg,"Triệu tập::") and szName~=me.szName and stype then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn giúp đở<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Đến", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn, bạn có đến không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
				-- me.Msg(tbPosInfo.szLink)
				Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";	
		tbMsgInfo:AddMsg(szKey, tbMsg, "Đến", "Không", "...");
	elseif string.find(szMsg,"PK.:.Bang") and szName~=me.szName and stype=="Bang" then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn bật PK Bang<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Bật", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn bật PK Bang, bạn có bật không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				SendChannelMsg("Tong","Đã chuyển PK Bang-Gia Tộc");
				SendChannelMsg("Kin","Đã chuyển PK Bang Hội-Gia Tộc!");
				me.nPkModel = Player.emKPK_STATE_TONG;
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";		
		tbMsgInfo:AddMsg(szKey, tbMsg, "Bật", "Không", "...");
		elseif string.find(szMsg,"PK.:.Phe") and szName~=me.szName and stype=="Đồng Đội" then
		me.Msg("<color=yellow>"..stype.."<color><color=green> ["..szName.."]<color><color=white> gọi bạn bật PK Phe<color>")
		local pos={};
		pos=self:Split(szMsg,"::");
		local tbMsg = {};
		tbMsg.szTitle = stype.." Gọi...";
		tbMsg.nOptCount = 2;
		tbMsg.tbOptTitle = { "Bật", "Không" };
		tbMsg.nTimeout = 10;
		tbMsg.szMsg = szName.." gọi bạn bật PK Phe, bạn có bật không ?";
		function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
			if (nOptIndex == 0) then
			elseif (nOptIndex == 1) then
				SendChannelMsg("Team","Đã chuyển PK Phe !");
				me.nPkModel = Player.emKPK_STATE_CAMP;
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = pos[2]
			elseif (nOptIndex == 2) then
			end
		end
		local szKey = "MsgBoxExample";		
		tbMsgInfo:AddMsg(szKey, tbMsg, "Bật", "Không", "...");
	end	
	if string.find(szMsg,"3") and stype=="Đồng Đội" then
		if me.GetMapTemplateId() < 65500 then
		return
		end
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nTemplateId == 4223) then  
				AutoAi.SetTargetIndex(pNpc.nIndex);
				break;
			end
		end
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bắt đầu mở Quang Ảnh Thạch");
	elseif string.find(szMsg,"Luyện.:.Công") and stype=="Đồng Đội" then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=white>Đồng đội gọi bật [Luyện Công]<color>");
		me.Msg("<color=yellow>Đồng đội gọi bật [Luyện Công]<color>")
	end	
	---------------------------He Thong--------------------
	if  string.find(szMsg,"Tất cả bật tự động đánh") and stype=="Đồng Đội" then	
		if me.nAutoFightState ~= 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			--Map.tbAutoAim:KaiGuanTBGJ();
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");	
		end
	end
	
	if  string.find(szMsg,"Tất cả dừng mọi hoạt động") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
			if me.nAutoFightState == 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
		Map.tbAutoAim:AutoFollowStop();
		UiManager:StopBao();
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Tất cả bật hộ tống") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() > 65500 or Guess2Switch == 1 then
		Map.tbAutoAim:AutoFollowStart();
		--Map.tbAutoAim:SuperFollow();
		--Ui(Ui.UI_SERVERSPEED):AutoFollow()
		--Map.AutoTheo:OnOpen();
				return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	---------------------------HLVM------------------------
	if ( string.find(szMsg,"VAOHL") or string.find(szMsg,"Anh em Vào HLVM nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,3,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,3,2"});
			return;			
		end
	end
	
	if ( string.find(szMsg,"BDHLVM") or string.find(szMsg,"Anh em BDHLVM nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,3,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,3,1"});
			return;			
		end
	end
		
	if  string.find(szMsg,"Rừng Gai") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
			Ui.RungGaiHL:RRungGai();
		end
	end
	
	if  string.find(szMsg,"Tầng 2") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
				Map.tbAutoQuanDoanh:tang2();
				Map.tbAutoAim:AutoFollowStop();
			end
	end
	
	if  string.find(szMsg,"Tầng 4") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hải Lăng!");
			return;
		else 
				Map.tbSuperCall:AutoPuFireStop();
				Map.tbAutoAim:AutoFollowStop();
				Map.tbAutoQuanDoanh:tang4();
		end
	end
	
	if  string.find(szMsg,"Tất cả trả nhiệm vụ HLVM") or string.find(szMsg,"nvHLVM") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
		    Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4237,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4237,1"});
			return;
		end
	end
	
	if  string.find(szMsg,"Tất cả đoán số 0") or string.find(szMsg,"so0") and stype=="Đồng Đội" then	
		     Map.tbInputZero:InputZeroSwitch();
    end

	----------------------BMS-------------------------
		
	if ( string.find(szMsg,"VAOBMS") or string.find(szMsg,"Anh em Vào BMS nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,2,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,2,2"});
			return;
		end
	end
	
	if ( string.find(szMsg,"BDBMS") or string.find(szMsg,"Anh em BDBMS nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,2,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,2,1"});
			return;
		end
	end
	
	if  string.find(szMsg,"Có bao nhiêu NKT rồi") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbTool:NKT();
		end
	end


	if  string.find(szMsg,"Có bao nhiêu ĐBC rồi") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbTool:DBC();
		end
	end

	
	if  string.find(szMsg,"Anh em ra chỗ cổ vương nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:DanhBossBMS();
		end
	end
	
	if  string.find(szMsg,"Anh em quit khỏi BMS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Bách Man Sơn!");
			return;
		else 
			Map.tbAutoQuanDoanh:QuitBMS1();	
		end
	end
	
	if  string.find(szMsg,"Tất cả trả nhiệm vụ BMS") or string.find(szMsg,"nvBMS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
		    Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4139,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4139,1"});
			return;
		end
	end
	
	--------------------------------HPNS-------------------------
	
	if ( string.find(szMsg,"VAOHS") or string.find(szMsg,"Anh em Vào HSPN nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,1,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,1,2"});
			return;
		end
	end
	
	if ( string.find(szMsg,"BDHSPN") or string.find(szMsg,"Anh em BDHSPN nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,1,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,1,1"});
			return;
		end
	end
	
	if  string.find(szMsg,"Anh em cùng nhau bắt chuột nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoEgg:AutoPick();
		end
	end
	
	if  string.find(szMsg,"Anh em vượt rào nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Ui.VuotRaoHS:JumpSwitch();
		end
	end
	
	if  string.find(szMsg,"Anh em tìm nghĩa quân nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:TimNghiaQuan();
		end
	end	
	
	if  string.find(szMsg,"Anh em lấy gỗ phong nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoEgg1:AutoPick();
		end
	end
	
	if  string.find(szMsg,"Anh em hái thảo dược nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoEgg2:AutoPick();
		end
	end
	
	if  string.find(szMsg,"Anh em báo cáo đạo cụ nào") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbTool:DaoJu();
		end
	end
	
	if  string.find(szMsg,"Anh em quit khỏi HPNS") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ hoạt động trong Hậu Phục Ngưu Sơn!");
			return;
		else 
				Map.tbAutoQuanDoanh:QuitHPNS1();
		end
	end

	if  string.find(szMsg,"Tất cả trả nhiệm vụ HSPN") or string.find(szMsg,"nvHSPN") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
		    Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4041,1"});
			else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4041,1"});
			return;
		end
	end
	
	-------------------------------NLHN---------------------------
	
	if ( string.find(szMsg,"BDNLHN") or string.find(szMsg,"Anh em báo danh Ngạc Luân Hà Nguyên nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,4,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,4,1"});
			return;
		end
	end
	
	if  (string.find(szMsg,"VAONL") or string.find(szMsg,"Anh em vào Ngạc Luân Hà Nguyên nào!!")) and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4038,4,2"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,4038,4,2"});
			return;			
		end
	end
	if  (string.find(szMsg,"ROINL") or string.find(szMsg,"Anh em rời khỏi Ngạc Luân Hà Nguyên nào!!")) and stype=="Đồng Đội" then	
		Map.tbvCTTK:CTTK10Switch();
	end
	if  string.find(szMsg,"Anh em đến Tế Tự Đài nào!!") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC4Switch();
	end
	if  string.find(szMsg,"Anh em trả bài nào!!") and stype=="Đồng Đội" then	
		Ui.NLHN:State();
	end
	if  string.find(szMsg,"Anh em bắt ngựa nào!!") and stype=="Đồng Đội" then
	Map.AutoQD:OnSwitch();
	end
	
	if  string.find(szMsg,"Anh em trả nhiệm vụ Ngạc Luân Hà Nguyên nào!!") or string.find(szMsg,"TNVNLHN") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 29 then
		    Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,9981,1"});
			else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,9981,1"});
			return;
		end
	end
	-------------------------------Khác--------------------------
	if  string.find(szMsg,"Anh em vào TDC 1 nào!!") and stype=="Đồng Đội" then	
		
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,1"});
		return;
	
	end
	
	if  string.find(szMsg,"Anh em vào TDC 2 nào!!") and stype=="Đồng Đội" then	
		
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237,2"});
		return;
	
	end
	
	if  string.find(szMsg,"Anh em lấy rương máu TDC nào!!") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
			if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3234,Nhận thuốc miễn phí hôm nay,1"});
			else
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3234,Nhận thuốc miễn phí hôm nay,3"});
			end
		return;
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Nhận thưởng tháng TDC") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3319,4"});
		--UiManager.tbLinkClass["npcpos"]:OnClick(",0,3319,4,1");
		return;
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end

    if  string.find(szMsg,"Nhận lại sổ thu thập thẻ") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3319,1"});
		return;
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end

    if  string.find(szMsg,"Đổi thẻ bí bảo") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Ui(Ui.UI_THEBIBAOTDC):State()
		return;
	else
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		return;
		end
	end

    if  string.find(szMsg,"Đổi bạc khóa tại Thương Hội") and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		Ui(Ui.UI_BACTHUONGHOI):State();
		return;
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end
	
	if  string.find(szMsg,"Trả máu Phúc Lợi!!") and stype=="Đồng Đội" then	
	AutoAi:ReclaimXiaoYaoXiang();	
		return;
		
	end
		
	if  (string.find(szMsg,"canmdt") or string.find(szMsg, "Anh em cán Lak Ma Đao Thạch cấp 7 nào!!")) and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		local tbFind = me.FindItemInBags(18,1,66,7); -- ma dao thach c7
			me.UseItem(tbFind[1].pItem);
			SendChannelMsg("Team", "Đã cắn Ma Đao Thạch");
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	end
end

    if (string.find(szMsg,"lak10") or string.find(szMsg, "Anh em cán Lak 10 nào!!")) and stype=="Đồng Đội" then
    if Guess2Switch == 1 then
        local tbFind = me.FindItemInBags(18,1,384,1); -- van vat qui nguyen don
            me.UseItem(tbFind[1].pItem);
            SendChannelMsg("Team", "Đã cắn lak 10");
    else
        me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
    end
end

    if (string.find(szMsg,"lak1c") or string.find(szMsg, "Anh em Cắn Lak 1 skill nào!!")) and stype=="Đồng Đội" then
    if Guess2Switch == 1 then
        local tbFind = me.FindItemInBags(18,2,20246,6); -- Mông cổ tây hạ Lak 1 skill
            me.UseItem(tbFind[1].pItem);
            SendChannelMsg("Team", "Đã cắn lak 1 skill TK");
    else
        me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
    end
end

    if (string.find(szMsg,"lakpd") or string.find(szMsg, "Anh em cán Lak phản đòn nào!!")) and stype=="Đồng Đội" then
    if Guess2Switch == 1 then
        local tbFind = me.FindItemInBags(18,2,20246,4); -- Mông Cổ Tây Hạ lak phản đòn
            me.UseItem(tbFind[1].pItem);
            SendChannelMsg("Team", "Đã cắn lak phản đòn TK");
    else
        me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
    end
end

    if (string.find(szMsg,"lakktc") or string.find(szMsg, "Anh em cắn Lak kháng tất cả nào!!")) and stype=="Đồng Đội" then
    if Guess2Switch == 1 then
        local tbFind = me.FindItemInBags(18,2,20246,2); -- Mông cổ tây hạ kháng tất cả
            me.UseItem(tbFind[1].pItem);
            SendChannelMsg("Team", "Đã cắn lak kháng tất cả TK");
    else
        me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
    end
end
	
	--------BHD lien server-------
	if  string.find(szMsg,"Anh em vào BHĐ Liên Server nào!!") and stype=="Đồng Đội" then	
			if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2654,1,1"});
			else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,2654,1,1"});		
		return;
			end
	end
	
	
if  string.find(szMsg,"Anh em đi ghép HT nào!!") and stype=="Đồng Đội" then	
	Ui(Ui.UI_COMPOSE):SwitchCompose();
--UiManager:hexuan();
		return;
		
	end
	
if  string.find(szMsg,"Anh em chạy BVĐ nào!!") and stype=="Đồng Đội" then	
		--tbSuperBao.Started();
		UiManager:StartBao();

		return;
		
	end
	---mộng cảnh---
if  string.find(szMsg,"Anh em vào Mộng Cảnh thôi!!!") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,20178,Vào mộng cảnh Phó Thụy Lỗi"});
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
if  string.find(szMsg,"Anh em rời khỏi Mộng Cảnh thôi!!!") and stype=="Đồng Đội" then	
		if me.GetMapTemplateId() < 65500 then
			me.Msg("<color=lightgreen>Chỉ Hoạt động trong Mộng Cảnh");
		else 
				Map.tbvCTTK:CTTK4Switch();
				
		end
	end
if  string.find(szMsg,"Anh Em ơi Train trong Mộng Cảnh!!!") and stype=="Đồng Đội" then	
		 
				Map.tbvCTTK:CTTK5Switch();
		
	end
	------------------- Lâu Lan Cổ Thành ---------
	if string.find(szMsg,"Anh em nhận nhiệm vụ lâu lan!!") and stype=="Đồng Đội" then	
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7139,1"});
	end
	if string.find(szMsg,"Anh em vào lâu lan!!") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7139,1"});
	end
	if string.find(szMsg,"Anh em rời khỏi lâu lan!!") and stype=="Đồng Đội" then	
		Map.tbvCTTK:CTTK7Switch();
	end
	if string.find(szMsg,"Anh em nhận thưởng lâu lan!!") and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7139,1"});
		
	end
	------------ CKP------------
	if  (string.find(szMsg,"aeckp") or string.find(szMsg,"Anh em mua CKP nào!!")) and stype=="Đồng Đội" then	
		 
				Ui(Ui.UI_tbCKP):State();
		
	end
	------------ Năng động ------------
	if  (string.find(szMsg,"aenangdong") or string.find(szMsg,"Anh em nhận điểm năng động nào!!")) and stype=="Đồng Đội" then
				Ui(Ui.UI_tbNangDong):State();
	end
	------------------------
	if ( string.find(szMsg,"Anh em mua kim tê nào") or string.find(szMsg,"muakimte")) and stype=="Đồng Đội" then
		        Map.Toolngt:OnSwitchMuaKimTe();   			
	end
	----------- Thần Trùng Trấn-----------
	if  string.find(szMsg,"lbttt") and stype=="Đồng Đội" then	
		me.CallServerScript({"PlayerCmd", "GetTreasureTimes", 3, 1});		
	end
	if  string.find(szMsg,"nvttt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2150,9986,1"});
	end
	if  string.find(szMsg,"vaottt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2150,9986,1,1"});
	end
	if  string.find(szMsg,"thuongttt") and stype=="Đồng Đội" then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2625,1"});
	end
	--------------- Thời quang lệnh -------------
	if  (string.find(szMsg,"lbtql") or string.find(szMsg,"Anh em nhận Lệnh bài TQL nào!!")) and stype=="Đồng Đội" then	
		
		me.CallServerScript({"PlayerCmd", "GetTreasureTimes", 3, 2});		
		
	end
	if  (string.find(szMsg,"nvtql") or string.find(szMsg,"Anh em nhận nhiệm vụ TQL nào!!")) and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615,1"});
		
	end
	if ( string.find(szMsg,"vaotql") or string.find(szMsg,"Anh em Vào TQL nào!!")) and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615,1,1"});
		
	end
	if  (string.find(szMsg,"roitql") or string.find(szMsg,"Anh em Rời khỏi TQL nào!!")) and stype=="Đồng Đội" then	
		 
			Map.tbvCTTK:CTTK8Switch();
		
	end
	if string.find(szMsg,"Anh em nhận thưởng TQL!!") and stype=="Đồng Đội" then	
		 
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,9615,1"});
		
	end
	if string.find(szMsg,"Anh em điểm truyền tống 2!!") and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:move(1306,3074);
		
	end
	if (me.IsDead() == 1) or (string.find(szMsg,"Đã bị trọng thương!")) then
		local am,ax,ay = me.GetWorldPos();
		local szdead =","..am..","..ax..","..ay 
		KIo.WriteFile("\\interface2\\Kato\\TDLT.txt",szdead);
		--me.SendClientCmdRevive(0);
	end
	------------------ VAGT + nhận thưởng ------
	if  string.find(szMsg,"Anh Em ơi Vào Ải gia tộc chơi đê!!!") and stype=="Đồng Đội" then	
			Map.tbAutoXuyenSon:MaXSSwitch();
		
	end
	
	if  string.find(szMsg,"Anh em đi đổi tiền nào!!!") and stype=="Đồng Đội" then	
		 
				Map.tbAutoXuyenSon:MrXSSwitch();
	end	
	
	if  string.find(szMsg,"Xong ải gia tộc rồi ra thôi!!!") and stype=="Đồng Đội" then
				Map.tbvCTTK:CTTK6Switch();
			
	end
	
	if  string.find(szMsg,"Anh em vào lãnh địa gia tộc nào !!") and stype=="Đồng Đội" then	
		Ui(Ui.UI_LANHDIA):State1()
			
	end
	
	if  string.find(szMsg,"anh em mở tu châu") and stype=="Đồng Đội" then	
	    if Guess2Switch == 1 then	
			Ui(Ui.UI_TULUYENCHAU):Start()
			return;
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  string.find(szMsg,"Anh em rời khỏi lãnh địa gia tộc nào !!") and stype=="Đồng Đội" then	
			me.CallServerScript({"UseUnlimitedTrans", 6}); 
			
	end
	
	if  string.find(szMsg,"Anh em nhận lương nào !!") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			me.CallServerScript({"ApplyKinGetSalary"});
			UiManager:OnButtonClick("zBtnAccept");
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end	

	if  string.find(szMsg,"Anh em trồng cây nào!!") and stype=="Đồng Đội" then	
			Map.tbKinZhongZhi:Switch();
			
	end	
	
	if  (string.find(szMsg,"aelothong") or string.find(szMsg,"Anh em lên bem con boss cuối nào!!")) and stype=="Đồng Đội" then	
			Map.tbvCTTK:CTTK9Switch();
			
	end
	-----------------báo boss---
	if  string.find(szMsg,"Anh em bật/tắt báo boss nào!!") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.uiDetector:Switch();	
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	------------- vứt nguyên liệu TDC + đổi thẻ TDC ----------
	if string.find(szMsg,"Anh em xả rác nào <pic=94>!!!") and stype=="Đồng Đội" then
		if Guess2Switch == 1 then
			--AutoAi:SwitchAutoThrowAway(1,0,0);
			AutoAi:SwitchAutoThrowAway3();
			return;
		else
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if string.find(szMsg,"Anh em bán rác HT nào <pic=94>!!!") and stype=="Đồng Đội" then
        if Guess2Switch == 1 then
		   Map.tbbanrac:banrac();
		else
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end	
	
	if string.find(szMsg,"Lưu điểm về thành") and stype=="Đồng Đội" then	
	    if Guess2Switch == 1 then
		    UiManager.tbLinkClass["npcpos"]:OnClick(",0,2599,1");
	    else 
		    me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end
	
	if  string.find(szMsg,"Anh em nhận NVCM nào !!") and stype=="Đồng Đội" then	
		 
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2261,11017,1"});
		
	end
	
	if  (string.find(szMsg,"hoisinh") or string.find(szMsg,"Anh em Hồi Sinh")) and stype=="Đồng Đội" then	
		 
				Ui(Ui.UI_tbHoiSinh):State();
				
	end
	
	if  (string.find(szMsg,"Anh em nhận túi quân hưởng nào !!") or string.find(szMsg,"Anh em nhận túi quân hưởng nào !!")) and stype=="Đồng Đội" then	
		 
				Ui(Ui.UI_TuiQuanHuong):_Start()
				
	end
	
	if  (string.find(szMsg,"Anh em CHECK SKILL") or string.find(szMsg,"checkskill")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.HoTroPKz:OnSwitch()
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  (string.find(szMsg,"Anh em mở mail") or string.find(szMsg,"momail")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Ui.tbWnd[Ui.UI_TOOLS2]:SwitchDelMails()
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  (string.find(szMsg,"anh em nhận NV đọc sách nào") or string.find(szMsg,"docsach")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.tbFightAim:Fight_Clock();
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	-----------------TĐLT-------------------
    if  string.find(szMsg,"Anh em lấy rương máu TDLT nào!!") and stype=="Đồng Đội" then
       if  me.nFaction ~= 9 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406,Quân nhu Lãnh thổ chiến,1,1,1,1"});
		else
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406,Quân nhu Lãnh thổ chiến,2,3"});
		end
	end
	
	if  (string.find(szMsg,"Anh em nhận Lak TDLT nào!!") or string.find(szMsg,"laktd")) and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Ui(Ui.UI_LAKLANHTHO):State();
		else 
			me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
	if  (string.find(szMsg,"canlak") or string.find(szMsg, "Anh em cắn Lak TDLT nào!!")) and stype=="Đồng Đội" then	
	if Guess2Switch == 1 then
		local tbFind = me.FindItemInBags(18,1,321,1); -- lak tdlt tieu
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Tiểu");
		end
		local tbFind = me.FindItemInBags(18,1,322,2); -- lak tdlt trung
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Trung");
		end
		local tbFind = me.FindItemInBags(18,1,323,3); -- lak tdlt dai
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			SendChannelMsg("Team", "Đã cắn Lak Đại");
		end
	else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
	    end
    end

    if  string.find(szMsg,"Nhận thưởng TDLT mau thôi") and stype=="Đồng Đội" then	
				tbAutoChiLing:ThuongTD();
	end
	
  	if  string.find(szMsg,"Anh em nhan,tra nv hiep khach nao!!") and stype=="Đồng Đội" then	
	if (me.GetMapTemplateId() == 24) or  (me.GetMapTemplateId() == 29) then	
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7346,1,1"});
		return;
	else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",29,7346,1,1"});
		return;
        end
    end

	if  string.find(szMsg,"Anh em lấy rương máu Tống Kim!!") and stype=="Đồng Đội" then	
		
			tbAutoChiLing:LayRuongTK();
		
	end
	
	if  string.find(szMsg,"Anh em mở rương máu Phúc Lợi!!") and stype=="Đồng Đội" then	
		AutoAi:MoRuongThuocPL();
		return;
		
	end
	-------------TK-----------
	if  string.find(szMsg,"Anh em vào MÔNG CỔ nào") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
	Map.tbvCTTK:CTTK1Switch()
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	
    if  string.find(szMsg,"Anh em vào TÂY HẠ nào") and stype=="Đồng Đội" then	
	    if Guess2Switch == 1 then
	Map.tbvCTTK:CTTK2Switch()
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end
	-------------------CTC--------------------
	if  (string.find(szMsg,"dictc") or string.find(szMsg,"Anh em đi CTC!!")) then	
		if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7137,1"});
		else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7137,1"});		
		end	
	end
	
	if  (string.find(szMsg,"thuongctc") or string.find(szMsg,"Anh em nhận thưởng CTC!!")) then	
		if (me.GetMapTemplateId() > 22) and  (me.GetMapTemplateId() < 30) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7137,2,4,1"});
		else
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,7137,2,4,1"});		
		end	
	end
	
	if  (string.find(szMsg,"vaoctc") or string.find(szMsg,"Anh em vào thiết phù thành!!")) then	
		if (me.GetMapTemplateId() > 1608) and  (me.GetMapTemplateId() < 1651) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,7136,1"});
		else
		me.Msg("<color=lightgreen>Bạn không đứng trong Đảo Anh Hùng");
		end	
	end
	
	if  (string.find(szMsg,"roictc") or string.find(szMsg,"Anh em rời khỏi thiết phù thành!!")) then	
		if (me.GetMapTemplateId() > 1608) and  (me.GetMapTemplateId() < 1651) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3698,1"});
		else
		me.Msg("<color=yellow>Bạn không đứng trong Đảo Anh Hùng");
		end	
	end
	
	if  (string.find(szMsg,"mauctc") or string.find(szMsg,"Anh em lấy máu CTC!!")) then	
		Map.tbAutoMau:LayMau1Switch();
	end
	
	if  string.find(szMsg,"Anh em Lên tầng hai nào!!") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC1Switch();
	end
	
	if  string.find(szMsg,"Anh em Lên tầng ba nào!!") and stype=="Đồng Đội" then	
		Map.tbvCTC:CTC2Switch();
	end
	
	-------------------Khắc Di Môn------------
	if ( string.find(szMsg,"roikdm") or string.find(szMsg,"Anh em rời bản đồ khắc di môn nào !!")) and stype=="Đồng Đội" then	
		if (me.GetMapTemplateId() == 2148) or  (me.GetMapTemplateId() == 2150) then
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2597,2,2"});
		else
	me.Msg("<color=lightgreen>Bạn không đứng trong Hậu Doanh chiến trường Khắc Di Môn");	
		end	
	end
	
	if  string.find(szMsg,"Anh em nhận Quân Lệnh nào!!") and stype=="Đồng Đội" then	
		
			--Map.AutoNvKDM:OnSwitch();
			Map.tbAutoMau:LayMau3Switch();
		
	end
	
	if  string.find(szMsg,"Anh em làm nhiệm vụ Khắc Di Môn nào!!") and stype=="Đồng Đội" then	
		
			Map.AutoNvKDM:OnSwitch();
			--Map.tbAutoMau:LayMau3Switch();
		
	end
	--------------thoát game----------
	if  string.find(szMsg,"thoatgame") and stype=="Đồng Đội" then	
		
			Exit();
		
	end
------LMPK---

    if  string.find(szMsg,"Anh em vào Hầm thôi!!!") and stype=="Đồng Đội" then	
		if Guess2Switch == 1 then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2711"});
				me.CallServerScript({"PlayerCmd", "EnterTreasure"});
		return;
		else 
		me.Msg("<color=lightgreen>Phải bật hỗ trợ PT [Alt+N] mới sử dụng được");
		end
	end

    if string.find(szMsg,"Đi qua nào !!!") then--diem truyen tong
    local s=szMsg;
    self:OpenPanel5();
    Timer:Register(Env.GAME_FPS*nChoseTime,self.Chose);
    end 

	------------mua mau--------------------------------------------
	if  string.find(szMsg,"Anh em đi mua máu nào!!") and stype=="Đồng Đội" then	
		tbAutoChiLing:MuaMau();
	end
	
	if  string.find(szMsg,"Anh em đi mua thức ăn!!") and stype=="Đồng Đội" then	
		tbAutoChiLing:MuaCai1();
	end
	if  string.find(szMsg,"Tất cả bât nhặt đồ nhanh") and stype=="Đồng Đội" then
		Map.tbAutoEgg:FastPick();
	end	
	---------------------------------------------
	if  string.find(szMsg,"Tất cả bật tự buff") and stype=="Đồng Đội" then
	Map.tbAutoAsist:Asistswitch();
	--Map.tbAutoAim:AutoFollowStart();
	end
	
	-------------------------------het---------------------------
	if string.find(szMsg,"mời <color=yellow>"..me.szName.."<color>") then	
		local s=szMsg;	
		self:OpenPanel();		
		Timer:Register(Env.GAME_FPS*nChoseTime,self.Chose2);    
	end
	
	if  string.find(szMsg,"trò chơi kết thúc") then
		if ( nChose3TimerId > 0 ) then
			Timer:Close(nChose2TimerId);
			nChose3TimerId=0;
		end
            	Timer:Register(Env.GAME_FPS*1.5, self.OpenPanel);  
		nChose3TimerId=Timer:Register(10,self.Chose3,self);
		Timer:Register(15,self.AutoFollow2);
        end
	
	if  string.find(szMsg,"Rương Hoàng Kim") then		
		Timer:Close(nChose3TimerId);
		nChose3TimerId=0;				
		Timer:Register(Env.GAME_FPS*1.5, self.OpenPanel);  		
		Timer:Register(Env.GAME_FPS*nChoseTime*5,self.Chose1);
		Timer:Register(15,self.AutoFollow3);		
    end

    ----------------------Thần Kí Thạch----------------------------
if  (string.find(szMsg,"nhandomaida") or string.find(szMsg,"Anh em Nhận đồ mài đá!!")) and stype=="Đồng Đội" then
		Ui.tbMaiDa:State();
	end	
if  (string.find(szMsg,"aedamot") or string.find(szMsg,"Anh em đập đá 1 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa1):State();
	end
if  (string.find(szMsg,"aedahai") or string.find(szMsg,"Anh em đập đá 2 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa2):State()
	end	
if  (string.find(szMsg,"aedaba") or string.find(szMsg,"Anh em đập đá ba cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa3):State()
	end	
if ( string.find(szMsg,"aedabon") or string.find(szMsg,"Anh em đập đá 4 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa4):State()
	end	
if ( string.find(szMsg,"aedanam") or string.find(szMsg,"Anh em đập đá 5 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa5):State()
	end	
if  (string.find(szMsg,"aedasau") or string.find(szMsg,"Anh em đập đá 6 cạnh!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMaiDa6):State()
	end	
    -------------------
	if  string.find(szMsg,"gohome1") and stype=="Đồng Đội" then
		me.CallServerScript({"UseUnlimitedTrans", 24});
	end
	if  string.find(szMsg,"gohome2") and stype=="Đồng Đội" then
		if Ui(Ui.UI_TEAM):IsTeamLeader() ~= 1 then
			me.CallServerScript({"UseUnlimitedTrans", 24});
		end	
	end
	local AutoOpenPet_Setting = Ui:GetClass("AutoOpenPet");
	local tbSettingOpenPet = AutoOpenPet_Setting:Load(AutoOpenPet_Setting.DATA_KEY) or {};
	if  (string.find(szMsg,"teammopet1") or string.find(szMsg,"pet 1")) and stype=="Đồng Đội" then
		nLenh1 =tbSettingOpenPet.nLenh1 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh1});
	end	
	if   (string.find(szMsg,"teammopet2") or string.find(szMsg,"pet 2")) and stype=="Đồng Đội" then
		nLenh2 =tbSettingOpenPet.nLenh2 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh2});
	end	
	if   (string.find(szMsg,"teammopet3") or string.find(szMsg,"pet 3")) and stype=="Đồng Đội" then
		nLenh3 =tbSettingOpenPet.nLenh3 or 0;
		me.CallServerScript({ "PartnerCmd", "CallPartner", nLenh3});
	end
	
	if  (string.find(szMsg,"Anh em sửa đồ nào") or string.find(szMsg,"suado")) and stype=="Đồng Đội" then
		Map.Toolngt:RepairAll();
		return 1
	end	

	if  string.find(szMsg,"stopdotlua") and stype=="Đồng Đội" then
		Ui.tbLogic.tbTimer:Close(nTimerIdDotLua);
		nTimerIdDotLua=0;
		me.CallServerScript({"ApplyAutoEventOnOff"});
		UiManager:CloseWindow(Ui.UI_AUTOEVENTBUT);
	end
	if  string.find(szMsg,"dotlua1") and stype=="Đồng Đội" then
		nTimerIdDotLua=Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1, self.DotLua, self);
	end
	-------------Di chuyen Boss 95 -------------------------
	if  (string.find(szMsg,"bkim") or string.find(szMsg,"Anh em săn boss kim 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossKim95):State1();
	end
	if  (string.find(szMsg,"bmoc") or string.find(szMsg,"Anh em săn boss mộc 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossMoc95):State1();
	end
	if  (string.find(szMsg,"bthuy") or string.find(szMsg,"Anh em săn boss thủy 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossThuy95):State1();
	end
	if  (string.find(szMsg,"bhoa") or string.find(szMsg,"Anh em săn boss hỏa 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossHoa95):State1();
	end
	if  (string.find(szMsg,"btho") or string.find(szMsg,"Anh em săn boss thổ 95 nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossTho95):State1();
	end
----------------------Di chuyen Boss long hồn -------------------------
	if  (string.find(szMsg,"bdc") or string.find(szMsg,"Anh em săn boss diêm châu nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossDiemChau):State1();
	end
	if  (string.find(szMsg,"bdh") or string.find(szMsg,"Anh em săn boss đông hạ nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossDongHa):State1();
	end
	if  (string.find(szMsg,"bkd") or string.find(szMsg,"Anh em săn boss khắc di nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossKhacDi):State1();
	end
	
	if  (string.find(szMsg,"bnl") or string.find(szMsg,"Anh em săn boss ngột lạt nào!!")) and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbBossNgotLat):State1();
	end
	----------------auto mc--------------
	
	if  string.find(szMsg,"vaokth") and stype=="Đồng Đội" then
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1785,3626"});
	end
	if  string.find(szMsg,"nhiemvukt") and stype=="Đồng Đội" then
		Ui.tbKhongTuoc:State();
	end
	if  string.find(szMsg,"dilen") and stype=="Đồng Đội" then
		Map.KhongTuocTren:Switch();
	end
	if  string.find(szMsg,"dixuong") and stype=="Đồng Đội" then
		Map.KhongTuocDuoi:Switch();
	end
	if  string.find(szMsg,"khuantoan") and stype=="Đồng Đội" then
		me.CallServerScript({"PlayerCmd", "TravelSend",Travel.TravelPanel:GetPlayerGateway(me)});
	end
	if  string.find(szMsg,"anda") and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbDa3):State();
	end
	if  string.find(szMsg,"moruong") and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbMoRuong):State();
	end
	if string.find(szMsg,"anqnl") and stype=="Đồng Đội" then	
		Ui(Ui.UI_tbQuyNguyenLenh):State();
	end
	if  string.find(szMsg,"muattp") and stype=="Đồng Đội" then	
		 
		Ui(Ui.UI_tbTTP):State();
	end
	if  string.find(szMsg,"muackp") and stype=="Đồng Đội" then	
		 
		Ui(Ui.UI_tbCKP):State();
	end
	if  string.find(szMsg,"banrac") and stype=="Đồng Đội" then	
		Map.tbbanrac:banrac();
	end
	if  string.find(szMsg,"thoatgame") and stype=="Đồng Đội" then	
		Exit();
	end
	if  string.find(szMsg,"anncd") and stype=="Đồng Đội" then	
		Ui(Ui.UI_NGUNGCONGDON):Start();
	end
	if string.find(szMsg,"Anh em rời nhóm nào!!!") then
		Ui(Ui.UI_ToDoiRoi):State1();
	end	
	if  string.find(szMsg,"Anh em mở rương tinh binh lệnh") and stype=="Đồng Đội" then
		Ui.TBLenh:State();	
	end
	if  string.find(szMsg,"momtl") and stype=="Đồng Đội" then
		Ui(Ui.UI_ManhThanhLong):State();	
	end
	if  string.find(szMsg,"mombh") and stype=="Đồng Đội" then
		Ui(Ui.UI_ManhBachHo):State();	
	end
	if  string.find(szMsg,"Anh em tăng tuổi thọ ngựa nào!") and stype=="Đồng Đội" then
		Ui.TuoiThoNgua:State();	
	end
	
end

function tbAutoChiLing:DotLua()
	if UiManager:WindowVisible(Ui.UI_AUTOEVENTBUT) ~=1 then
		local LTVV =  tbAutoChiLing.TimNPC_TEN("Lửa trại vui vẻ");
		if LTVV then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				AutoAi.SetTargetIndex(LTVV.nIndex)
			else	
				me.AnswerQestion(0);
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end	
		else
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",25,1627,3136"});
		end
	else
		Ui.tbLogic.tbTimer:Close(nTimerIdDotLua);
		nTimerIdDotLua=0;
	end	
end

function tbAutoChiLing:OpenPanel5()
local tbAroundNpc = KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do
		if pNpc.szName=="Điểm truyền tống" then
		AutoAi.SetTargetIndex(pNpc.nIndex)
		end
	end
	return 0;
end

function tbAutoChiLing:Chose()
local nId = tbAutoChiLing:GetAroundNpcId(4210)
	if nId then
		return
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(0);
		me.AnswerQestion(0);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
return 0
end

function tbAutoChiLing.TimNPC_TEN(name)
	local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.szName == name then
			return pNpc
		end
	end
end

function tbAutoChiLing:ClosePanel()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	end
end

function tbAutoChiLing:Chose1()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end	
        if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
			me.AnswerQestion(0);		
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
        return 0;
end 

function tbAutoChiLing:Chose2()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end
    if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(2);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);	
	else
		me.AnswerQestion(0);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);	
	end
	if (UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1) and me.GetMapTemplateId() > 65500 then
		me.CallServerScript({ "DlgCmd", "InputNum", c });			
	end
	return 0;	
end 


function tbAutoChiLing:Chose3()
		local nId = tbAutoChiLing:GetAroundNpcId(4210)
		if nId then
			return
		end
        if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and me.GetMapTemplateId() > 65500 then
		me.AnswerQestion(0);		
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
end 

function tbAutoChiLing:AutoTask()	
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		me.AnswerQestion(0);		
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	elseif
		UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD);		
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
	end
end

function tbAutoChiLing:OpenPanel()
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do
		if pNpc.szName=="Du Long" or pNpc.szName=="Lối vào mật thất tầng " or pNpc.szName=="Lối vào Mật Thất 3" or pNpc.szName=="Chú Phù Ấn" then
			AutoAi.SetTargetIndex(pNpc.nIndex)
		end
	end
	return 0;
end

function tbAutoChiLing:AutoFollow2()
	local x2,y2,world = me.GetNpc().GetMpsPos();
	local nMyPosX2   = math.floor(x2/32);
	local nMyPosY2   = math.floor(y2/32);
	if (nMyPosX2 == 1788 and nMyPosY2 == 3293) then	
		me.Msg("<color=yellow>Tự động đi đến điểm Boss tầng 2<color>");		
		me.StartAutoPath(1771,3371);
	end
	if (nMyPosX2 == 1771 and nMyPosY2 == 3371) then				
		--if (me.nAutoFightState ~= 1) then							
				--Ui(Ui.UI_HOTRO):StopAutoFight();	--AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
		for _, pNpc in ipairs(tbAroundNpc) do	
			if pNpc.szName == "Chú Phù Ấn" then
				Ui(Ui.UI_HOTRO):StopAutoFight();	--AutoAi.SetTargetIndex(pNpc.nIndex)
			end		
			return 0;
		end
	end 
end

function tbAutoChiLing:AutoFollow3()
	local x3,y3,world = me.GetNpc().GetMpsPos();
	local nMyPosX3   = math.floor(x3/32);
	local nMyPosY3   = math.floor(y3/32);
	if (nMyPosX3 == 1775 and nMyPosY3 == 3490) then	
		me.Msg("<color=yellow>Tự động đi đến điểm Boss tầng 3<color>");
		me.AutoPath(1770,3556);
	end
	if (nMyPosX3 == 1770 and nMyPosY3 == 3556) then		
		--if (me.nAutoFightState ~= 1) then					
				--Ui(Ui.UI_HOTRO):StopAutoFight();	--AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
		for _, pNpc in ipairs(tbAroundNpc) do	
			if pNpc.szName == "Chú Phù Ấn" then
				Ui(Ui.UI_HOTRO):StopAutoFight();	--AutoAi.SetTargetIndex(pNpc.nIndex)
			end
			return 0;
		end
	end 
end

function tbAutoChiLing:GuessSwitch()
	if GuessSwitch == 0 then
		GuessSwitch = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật: <bclr=red><color=yellow>Hổ trợ Quân Doanh [Alt+M]")
		me.Msg("<color=yellow>-Bật chức năng hổ trợ giúp đở Đội-Bang-Gia Tộc <color>");
		me.Msg("<color=yellow>-Bật chức năng hổ trợ Hải Lăng Vương Mộ <color>");
	else
		GuessSwitch = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt: <bclr=blue><color=white>Hổ trợ Quân Doanh [Alt+M]")
		me.Msg("<color=green>-Ngừng chức năng hổ trợ gọi giúp đở Đội-Bang-Gia Tộc <color>");
		me.Msg("<color=green>-Ngừng chức năng hổ trợ hổ trợ Hải Lăng Vương Mộ <color>");
		Timer:Close(nAutoTaskTimerId);
		nAutoTaskTimerId=0;
		Timer:Close(nCheckMap1TimerId);
		nCheckMap1TimerId=0;
		Timer:Close(nCheckMap2TimerId);
		nCheckMap2TimerId=0;
		Timer:Close(nCheckMap3TimerId);
		nCheckMap3TimerId=0;
		Timer:Close(nChose3TimerId);
		nChose3TimerId=0;
		self.StopRun();
		Timer:Close(nDetectorTimerId);
		nDetectorTimerId=0;
	end
end

function tbAutoChiLing:Guess2Switch()
	if Guess2Switch == 0 then
		Guess2Switch = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật <bclr=Black><color=yellow>hỗ trợ ngoài quân doanh [Alt+N]")
		me.Msg("<color=yellow>Bật hỗ trợ điều khiển tổ đội<color>");
	else
		Guess2Switch = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt <bclr=Black><color=white>hỗ trợ ngoài quân doanh [Alt+N]")
		me.Msg("<color=green>Ngừng chỗ trợ điều khiển tổ đội<color>");
	end
end

function tbAutoChiLing:Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

function tbAutoChiLing:GetAroundNpcId(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end

    local BDStart     = 0;
	local nBDTimerId = 0;
	local nBDTime    = 0.5;
	local nBDState   = 0;
	function tbAutoChiLing:OnBDTimer()
		if (nBDState == 0) then
		return 0
		end
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
			for _, pNpc in ipairs(tbAroundNpc) do		
				if (pNpc.nTemplateId == 2503) then  	
				AutoAi.SetTargetIndex(pNpc.nIndex)
				me.AnswerQestion(0);
				me.AnswerQestion(0);
				break;
				elseif (pNpc.nTemplateId == 2506) then  	
				AutoAi.SetTargetIndex(pNpc.nIndex)
				me.AnswerQestion(0);
				me.AnswerQestion(0);
				break;
			
				end
			
			
			end
			if  (me.GetMapTemplateId() > 185) or (me.GetMapTemplateId() < 182) then
				tbMember:AutoBD();
				AutoAi.SetTargetIndex(0)
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
			end
	end	

function AutoAi:MoRuongThuocPL()
	local tbSetting = Map.tbAutoQuanDoanh:Load(Map.tbAutoQuanDoanh.DATA_KEY) or {};
	local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
	local nPlanNum = tonumber (tbSetting.nNeedB) or 100; 
	local nCountFree = me.CountFreeBagCell(); 
	local nDangCo = (me.GetItemCountInBags(17,13,1,4) + me.GetItemCountInBags(17,13,3,4)) ;	
	if ((nCountFree - nFreeNum) > (nPlanNum - nDangCo)) then
		nPlanNum = (nPlanNum - nDangCo);
		else
		nPlanNum = (nCountFree - nFreeNum) ;
	end	
	local tbFindp	= {1783, 1784, 1785, 20111, 241, 242};
	local tbFindl	= {1, 2, 3, 4, 5};
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc Phúc lợi<color>");
	for _, nFindp in ipairs(tbFindp) do
		for _, nFindl in ipairs(tbFindl) do
			local tbFind = me.FindItemInBags(18,1,nFindp,nFindl)[1];
			if tbFind then
				local pItem = tbFind.pItem;
				local g = pItem.nGenre;
				local d = pItem.nDetail;
				local p = pItem.nParticular;
				local l = pItem.nLevel;
				AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
			end
		end
	end
end


function AutoAi:TraRuongThuocPL()
	local nPlanNum = (me.GetItemCountInBags(17,13,1,4) + me.GetItemCountInBags(17,13,3,4)) ; 
	local tbFindp	= {1783, 1784, 1785, 241, 242};
	local tbFindl	= {1, 2, 3, 4, 5};
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật trả rương thuốc Phúc lợi<color>");
	for _, nFindp in ipairs(tbFindp) do
		for _, nFindl in ipairs(tbFindl) do
			local tbFind = me.FindItemInBags(18,1,nFindp,nFindl)[1];
			if tbFind then
				local pItem = tbFind.pItem;
				local g = pItem.nGenre;
				local d = pItem.nDetail;
				local p = pItem.nParticular;
				local l = pItem.nLevel;
				AutoAi:StartTraRuongThuoc(g,d,p,l,nPlanNum);
			end
		end
	end
end

---------------tra , mở ,thuoc---------------------
local uiTextInput = Ui(Ui.UI_TEXTINPUT);
local nTimerId = 0;
local nTraDaoTimerId = 0;
local nMoDaoTimerId = 0;
local nLastOpenTime = 0;
local nWaitTime = 5; 

function AutoAi:StartTraRuongThuoc(g,d,p,l,n)
	if nTimerId == 0 then
		me.Msg("Bắt đầu trả ...");
		nTimerId	= Ui.tbLogic.tbTimer:Register(18, AutoAi.TraRuong, AutoAi, g, d, p, l, n);
	end
end

function AutoAi:StopTraRuongThuoc()
	if nMoDaoTimerId > 0 then
		--me.Msg("<color=yellow>Tắt tự mở rương thuốc<color>");
		Ui.tbLogic.tbTimer:Close(nTraDaoTimerId);
		nMoDaoTimerId = 0;
	end
end

function AutoAi:TraRuong(g,d,p,l,n)
	local nCurTime = GetTime();
	local nDiff = nCurTime - nLastOpenTime;
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then		
		return; 
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		me.CallServerScript({ "DlgCmd", "InputNum", n });
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
	end
	if nLastOpenTime > 0 and nDiff < nWaitTime then
		return; 
	end
	if nLastOpenTime > 0 and nDiff >= nWaitTime then			
		AutoAi:DungTraRuong(); 
		nLastOpenTime = 0;
		return;
	end
	local tbItem = me.FindItemInBags(g,d,p,l)[1];
	if tbItem then
		me.UseItem(tbItem.pItem);
		nLastOpenTime = nCurTime;
		me.AnswerQestion(1);
		Ui.tbLogic.tbTimer:Register(18, AutoAi.CloseSay);
	end
end

function AutoAi:DungTraRuong()
	if nTimerId > 0 then
		me.Msg("Trả hôp đầu ...");
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end


function AutoAi:StartMoRuongThuoc(g,d,p,l,n)
	if nTimerId == 0 then
		me.Msg("Bắt đầu mở ...");
		nTimerId	= Ui.tbLogic.tbTimer:Register(18, AutoAi.MoRuong, AutoAi, g, d, p, l, n);
	end
end

function AutoAi:StopMoRuongThuoc()
	if nMoDaoTimerId > 0 then
		--me.Msg("<color=yellow>Tắt tự mở rương thuốc<color>");
		Ui.tbLogic.tbTimer:Close(nMoDaoTimerId);
		nMoDaoTimerId = 0;
	end
end

function AutoAi:MoRuong(g,d,p,l,n)
	local nCurTime = GetTime();
	local nDiff = nCurTime - nLastOpenTime;
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then		
		return; 
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		me.CallServerScript({ "DlgCmd", "InputNum", n });
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
	end
	if nLastOpenTime > 0 and nDiff < nWaitTime then
		return; 
	end
	if nLastOpenTime > 0 and nDiff >= nWaitTime then			
		AutoAi:DungMoRuong(); 
		nLastOpenTime = 0;
		return;
	end
	local tbItem = me.FindItemInBags(g,d,p,l)[1];
	if tbItem then
		me.UseItem(tbItem.pItem);
		nLastOpenTime = nCurTime;
		me.AnswerQestion(0);
		Ui.tbLogic.tbTimer:Register(18, AutoAi.CloseSay);
	end
end

function AutoAi:DungMoRuong()
	if nTimerId > 0 then
		me.Msg("Mở hôp cuối ...");
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end

local szCmd = [=[
		AutoAi:MoRuongThuocPL();      
	]=];
UiShortcutAlias:AddAlias("GM_S2", szCmd);

function AutoAi:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	return 0;
end
-------------------------------


tbAutoChiLing.ThuongTD=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_ThuongTD, self);
end

tbAutoChiLing.OnTimer_ThuongTD = function(self)
	local nId =  tbAutoChiLing:GetAroundNpcId(3406)
				
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbAutoChiLing:ThuongTD1()
		return 0
	
	else
	tbAutoChiLing:fnfindNpc(3406,"Quan Lãnh Thổ");
	return 0
	end
end

tbAutoChiLing.ThuongTD1=function(self)
	
	local nId =  tbAutoChiLing:GetAroundNpcId(3406) 		
	
	if nId then
		AutoAi.SetTargetIndex(nId);
		
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				
							me.AnswerQestion(1);
							me.AnswerQestion(0);
							me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
							--me.AnswerQestion(0);
				
				Ui.tbLogic.tbTimer:Register(20, CloseWindow2);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end

------------------------------------
tbAutoChiLing.LayRuongTK=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_LayRTK, self);
end

tbAutoChiLing.OnTimer_LayRTK = function(self)
	local nId =  tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
				
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbAutoChiLing:LayRuongTK1()
		return 0
	elseif me.GetMapTemplateId() == 182 then
					if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",182,2504,6,1"});
					return 0
					else
					Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",182,2504,6,3"});
					return 0
					end
	elseif me.GetMapTemplateId() == 185 then
					if me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",185,2507,6,1"});
					return 0
					else
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",185,2507,6,3"});
					return 0
						end
	else
	me.Msg("<color=pink>không tìm thấy quan quân nhu tống kim");
	return 0
	end
end

tbAutoChiLing.LayRuongTK1=function(self)
	
	local nId =  tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
	local cId = 0
		if me.nFaction == 9 then
		cId = 2
		end
	
	if nId then
		AutoAi.SetTargetIndex(nId);
		
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				
							me.AnswerQestion(5);
							me.AnswerQestion(cId);
					
							
					
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end
----------------------------------------------------------------


tbAutoChiLing.MuaMau=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_Mau, self);
end

tbAutoChiLing.OnTimer_Mau = function(self)
		local nId = tbAutoChiLing:GetAroundNpcId(3564) or tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
				or tbAutoChiLing:GetAroundNpcId(7373) or tbAutoChiLing:GetAroundNpcId(2443) or tbAutoChiLing:GetAroundNpcId(2447) or tbAutoChiLing:GetAroundNpcId(10036)
				or tbAutoChiLing:GetAroundNpcId(9674) or tbAutoChiLing:GetAroundNpcId(3230)
		if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbAutoChiLing:MuaMau1();
		return 0
	else
		Map.tbAutoChiLing:fnfindNpc(3564,"Trương Trảm Kinh");
		return
	end
end


function tbAutoChiLing:MuaMau1()
			local nBac
			local uId = 680
			if me.nFaction == 9 then      --武当 
			uId = 690;  -- 690 五花玉露丸
			end
			local nHPLvId
			local tbSetting = Map.tbAutoQuanDoanh:Load(Map.tbAutoQuanDoanh.DATA_KEY) or {};
			local nFreeNum = tonumber (tbSetting.nFreeBag) or 2
			local nCBuyHP = tonumber (tbSetting.nNeedB) or 50
			local nCountFree = me.CountFreeBagCell();	
			local nBacE = 0;			
			local nId = tbAutoChiLing:GetAroundNpcId(3564) or tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
				or tbAutoChiLing:GetAroundNpcId(7373) or tbAutoChiLing:GetAroundNpcId(2443) or tbAutoChiLing:GetAroundNpcId(2447) or tbAutoChiLing:GetAroundNpcId(10036)
				or tbAutoChiLing:GetAroundNpcId(9674) or tbAutoChiLing:GetAroundNpcId(3230)
				if (nCountFree > nFreeNum) then
					if nId   then
						AutoAi.SetTargetIndex(nId);	
						local function fnbuy()
							local nCountHP = (me.GetItemCountInBags(17,1,1,4) + me.GetItemCountInBags(17,3,1,5));
							if nCountHP < nCBuyHP then
								if ((nCountFree - nFreeNum) > (nCBuyHP - nCountHP)) then
									local bOK, szMsg = me.ShopBuyItem(uId, nCBuyHP - nCountHP);
								else
									local bOK, szMsg = me.ShopBuyItem(uId, nCountFree - nFreeNum);
								end
							end
							UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
							if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
							UiManager:CloseWindow(Ui.UI_SHOP);
							end
							
						return 0
						end
						local function CloseWindow3()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
							UiManager:CloseWindow(Ui.UI_ITEMBOX);
							end
						return 0
						end
						local function fnCloseSay3()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
								if (me.GetMapTemplateId() > 187) and (me.GetMapTemplateId() < 196) 
								or (me.GetMapTemplateId() > 262) and (me.GetMapTemplateId() < 272)
								or	(me.GetMapTemplateId() > 289) and (me.GetMapTemplateId() < 298)
								or (me.GetMapTemplateId() > 1634) and (me.GetMapTemplateId() < 1644)
								or (me.GetMapTemplateId() > 19999) and (me.GetMapTemplateId() < 20018)
								then
							
								me.AnswerQestion(1);
								else
								me.AnswerQestion(0);
								end
							
								Ui.tbLogic.tbTimer:Register(15, CloseWindow3);
								Ui.tbLogic.tbTimer:Register(40, fnbuy);
								return 0
							end																			
						end
					Ui.tbLogic.tbTimer:Register(36, fnCloseSay3);
					end
				else 
				me.Msg("<color=pink>Đã có đủ thuốc ,ko cần mua ");
				end
end

-------------------------thức ăn-------------------
tbAutoChiLing.MuaCai1=function(self)
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_Cai, self);
end

tbAutoChiLing.OnTimer_Cai = function(self)
	local nId = tbAutoChiLing:GetAroundNpcId(3566) or tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
				or tbAutoChiLing:GetAroundNpcId(7373) or tbAutoChiLing:GetAroundNpcId(2443) or tbAutoChiLing:GetAroundNpcId(2447) or tbAutoChiLing:GetAroundNpcId(10036)
				or tbAutoChiLing:GetAroundNpcId(9674) or tbAutoChiLing:GetAroundNpcId(3230)
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbAutoChiLing:MuaCai()
		return 0
	else
	tbAutoChiLing:fnfindNpc(3566,"Đại lão Bạch");
		return 0;
	end
end




tbAutoChiLing.MuaCai=function(self)
	print("Bắt đầu mua thức ăn")
	local nId = tbAutoChiLing:GetAroundNpcId(3566) or tbAutoChiLing:GetAroundNpcId(2613) or tbAutoChiLing:GetAroundNpcId(2614)
				or tbAutoChiLing:GetAroundNpcId(7373) or tbAutoChiLing:GetAroundNpcId(2443) or tbAutoChiLing:GetAroundNpcId(2447) or tbAutoChiLing:GetAroundNpcId(10036)
				or tbAutoChiLing:GetAroundNpcId(9674) or tbAutoChiLing:GetAroundNpcId(3230)
	local nCBuyCai = 5
	if nId then
		AutoAi.SetTargetIndex(nId);
		local function fnMaiCai()
		local nCaiLevel,nCaiID
                                if me.nLevel<30 then
									nCaiLevel=1
                                    nCaiID = 821
								end
								if (me.nLevel> 29) and (me.nLevel<50) then
								nCaiLevel=2
                                  nCaiID = 822
								end
								if (me.nLevel> 49) and (me.nLevel<70) then
								nCaiLevel=3
                                 nCaiID = 823
								end
								if (me.nLevel>69) and (me.nLevel < 90) then
								nCaiLevel =4
								nCaiID = 824
								end
								if me.nLevel >= 90 then
								nCaiLevel = 5
								nCaiID = 825
								end
				local nCount_Cai = me.GetItemCountInBags(19,3,1,nCaiLevel);
				if nCount_Cai < nCBuyCai then
				local pItem = KItem.GetItemObj(825);
				local bOK, szMsg = me.ShopBuyItem(nCaiID, nCBuyCai -nCount_Cai);
				end
				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_SHOP);
				end
		return 0
		end
			local function CloseWindow2()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			UiManager:CloseWindow(Ui.UI_ITEMBOX);
			end
			return 0
			end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				if (me.GetMapTemplateId() > 187) and (me.GetMapTemplateId() < 196) 
							or (me.GetMapTemplateId() > 262) and (me.GetMapTemplateId() < 272)
							or	(me.GetMapTemplateId() > 289) and (me.GetMapTemplateId() < 298)
							or (me.GetMapTemplateId() > 1634) and (me.GetMapTemplateId() < 1644)
							or (me.GetMapTemplateId() > 19999) and (me.GetMapTemplateId() < 20018)
							then
							me.AnswerQestion(4);
					elseif 	(me.GetMapTemplateId() == 182) or (me.GetMapTemplateId() == 185)	then
							me.AnswerQestion(3);
					elseif 	(me.GetMapTemplateId() == 1536) or (me.GetMapTemplateId() == 1538) then
							me.AnswerQestion(1);
					else 
						me.AnswerQestion(0);
				end	
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
				Ui.tbLogic.tbTimer:Register(40, fnMaiCai);
			return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end

tbAutoChiLing.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end
tbAutoChiLing.fnfindNpc = function(self, nNpcId, szName)
	local nMyMapId	= me.GetMapTemplateId();
	local nTargetMapId;
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		nTargetMapId = nMyMapId;
	elseif nCityId then
		nTargetMapId = nCityId
	else
		nTargetMapId = 5
	end
	if (nMyMapId == 556 or nMyMapId == 558 or nMyMapId == 559) and (nNpcId == 3566 or nNpcId == 3564) then 
		nTargetMapId = nMyMapId;
	end

	local nX1, nY1;
	nX1, nY1 = KNpc.ClientGetNpcPos(nTargetMapId, nNpcId);


	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = szName..","..nTargetMapId..","..nX1..","..nY1
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) or nSetPhu == 0 then	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nTargetMapId,nX=nX1,nY=nY1})
	else
		local tbFind = me.FindItemInBags(unpack({18,1,nSetHTPId,1}));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			return;
		end
		self.fnfindNpc(nNpcId, szName);
	end	
end




local tCmd={ "Map.tbAutoChiLing:GuessSwitch()", "GuessSwitch", "", "alt+M", "alt+M", "GuessSwitch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n
local tCmd={ "Map.tbAutoChiLing:Guess2Switch()", "Guess2Switch", "", "alt+N", "alt+N", "Guess2Switch"};
       AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n

tbAutoChiLing:Init();

--CTC: 1187,1189,3583	7135 Tiệm thuốc Nhận thuốc miễn phí 