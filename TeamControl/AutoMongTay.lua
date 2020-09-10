-----------lấy Máu TK
local AutoMongTay = Ui:GetClass("AutoMongTay");
local self			= AutoMongTay

AutoMongTay.statemc = 0
AutoMongTay.stateth = 0
local Timermc = 0
local Timerth = 0
local n = 2

local uiSayPanel = Ui(Ui.UI_SAYPANEL)

local tbMapName = {
{"Báo Danh_Mông Cổ (Phượng Tường 1)",182},
{"Báo Danh_Tây Hạ (Phượng Tường 1)",185},
{"Cửu Khúc Chiến (Phượng Tường 1)",188},
{"Ngũ Trượng Nguyên Chiến (Phượng Tường 1)",191},
{"Bàn Long Cốc Chiến (Phượng Tường 1)",194},
{"Gia Dụ Quan Chiến-Phượng Tường 1",1638},
{"Kỳ Thủy Kiều Chiến-Phượng Tường 1",20003},
{"Tân Gia Dụ Quan Chiến-Phượng Tường 1",20012},
}

local tbChon = {
{"Ta muốn nhận quân nhu","Ta muốn nhận quân nhu"},
{"Nhận quân nhu","Nhận quân nhu"},
{"Hồi Huyết Đơn","Càn Khôn Tạo Hóa Hoàn"}
}

local tbChon2 = {
{"Hãy chọn trận muốn tham gia","Phượng Tường",1},
{"Điểm tích lũy tính năng lần trước","Đồng ý",1},
{"Hiện tại quân sô hai bên là","Kết thúc đối thoại",1},
{"Ngoài ra, mỗi ngày các ngươi còn được nhận Quân nhu phục vụ tác chiến","Ta muốn gia nhập quân",0},
{"Xin chào, hoan nghênh gia nhập quân","Đồng ý",0},
{"Ngươi muốn vào tính năng bây giờ sao","Ta muốn vào tính năng",0},
{"Đại quân tuần tra tính năng vẫn chưa","Kết thúc đối thoại",0}
}

function AutoMongTay:StateMC()
	if AutoMongTay.statemc == 0 then
		me.Msg("<color=yellow>Mở auto")
		Timermc = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,self.NhanThuocMC,self);
		AutoMongTay.statemc = 1
	else
		me.Msg("<color=pink>Tắt auto")
		AutoMongTay.statemc = 0
		Ui.tbLogic.tbTimer:Close(Timermc)
		Timermc = 0		
	end
end

function AutoMongTay:StateTH()
	if AutoMongTay.stateth == 0 then
		me.Msg("<color=yellow>Mở auto")
		Timerth = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,self.NhanThuocTH,self);
		AutoMongTay.stateth = 1
	else
		me.Msg("<color=pink>Tắt auto")
		AutoMongTay.stateth = 0
		Ui.tbLogic.tbTimer:Close(Timerth)
		Timerth = 0		
	end
end

function AutoMongTay.CoTheNhanThuoc()
	for i = 59, 61 do
		local tbFind = me.FindItemInBags(18,1,i,1);
		local count = me.GetItemCountInBags(18,1,i,1)
		if (count < n) then
			return true		
		else
			Ui.tbScrCallUi:CloseWinDow()
			me.Msg("<color=white>Đã có đủ : <color>"..count.." "..KItem.GetNameById(18,1,i,1).."<color=yellow> trong hành trang")
			return false
		end
	end	
end

-- function AutoMongTay.MapTK()
	-- local nMapId = me.nTemplateMapId
	-- for i = 1, table.getn(tbMapName) do
		-- if string.find(tbMapName[i][1]) == GetMapNameFormId(nMapId) then
			-- return true		
		-- else		
			-- Ui.tbScrCallUi:CloseWinDow()
			-- me.Msg("<color=white>Map : <color>"..GetMapNameFormId(nMapId).."<color=yellow> là không đúng")
			-- return false
		-- end
	-- end
-- end

function AutoMongTay.NhanThuocMC()	
	if (AutoMongTay.statemc == 0) then
		return 
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer()
	if AutoMongTay.CoTheNhanThuoc() then--and AutoMongTay.MapTK() then
		local QQN = Ui.tbScrCallUi:TimNPC_TEN("Quan Quân Nhu (Mông Cổ)")
		if QQN then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				AutoAi.SetTargetIndex(QQN.nIndex);								
			else
				me.Msg("<color=White>Hỏi : <color>"..szQuestion)
				for i = 1,table.getn(tbChon) do
					if me.nFaction~=9 then
						for k = 1, table.getn(tbAnswers) do
							if string.find(tbAnswers[k],tbChon[i][1]) then
								me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
								return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
							end
						end
					else
						for k = 1, table.getn(tbAnswers) do
							if string.find(tbAnswers[k],tbChon[i][2]) then
								me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
								return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
							end
						end
					end
				end
			end
		else			
			local Xnpc, Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2613)
			if Xnpc then
				Ui.tbScrCallUi:StartMove(Xnpc*32, Ynpc*32)
			end
		end
	else		
		AutoMongTay.statemc = 0					
	end	
end

function AutoMongTay.NhanThuocTH()	
	if (AutoMongTay.stateth == 0) then
		return 
	end
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer()
	if AutoMongTay.CoTheNhanThuoc() then--and AutoMongTay.MapTK() then
		local QQN = Ui.tbScrCallUi:TimNPC_TEN("Quan Quân Nhu (Tây Hạ)")
		if QQN then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				AutoAi.SetTargetIndex(QQN.nIndex);								
			else
				me.Msg("<color=White>Hỏi : <color>"..szQuestion)
				for i = 1,table.getn(tbChon) do
					if me.nFaction~=9 then
						for k = 1, table.getn(tbAnswers) do
							if string.find(tbAnswers[k],tbChon[i][1]) then
								me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
								return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
							end
						end
					else
						for k = 1, table.getn(tbAnswers) do
							if string.find(tbAnswers[k],tbChon[i][2]) then
								me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
								return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
							end
						end
					end
				end
			end
		else			
			local Xnpc, Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2614)
			if Xnpc then
				Ui.tbScrCallUi:StartMove(Xnpc*32, Ynpc*32)
			end
		end
	else		
		AutoMongTay.stateth = 0					
	end	
end
----------------------------------------------------------------
function AutoMongTay.RoiMapTk23h()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	if nWorldPosX < 1630 then
		Ui.tbScrCallUi:MoveTo(1617*32, 3147*32)
	elseif nWorldPosX > 1983 then
		Ui.tbScrCallUi:MoveTo(2005*32, 2750*32)	
	end
end
----------------------------------------------------------------
AutoMongTay.switchMC = 0
local TimerMauMC = 0
AutoMongTay.switchTH = 0
local TimerMauTH = 0
----------------------------------------------------------------
function AutoMongTay:SwitchMC()
	if AutoMongTay.switchMC == 0 then
		me.Msg("<color=yellow>Mở auto")
		TimerMauMC = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,self.MuaThuocMC,self);
		AutoMongTay.switchMC = 1
	else		
		me.Msg("<color=pink>Tắt auto")
		AutoMongTay.switchMC = 0
		Ui.tbLogic.tbTimer:Close(TimerMauMC)
		TimerMauMC = 0
		Ui.tbScrCallUi:CloseWinDow()
	end
end

function AutoMongTay:SwitchTH()
	if AutoMongTay.switchTH == 0 then
		me.Msg("<color=yellow>Mở auto")
		TimerMauTH = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,self.MuaThuocTH,self);
		AutoMongTay.switchTH = 1
	else		
		me.Msg("<color=pink>Tắt auto")
		AutoMongTay.switchTH = 0
		Ui.tbLogic.tbTimer:Close(TimerMauTH)
		TimerMauTH = 0
		Ui.tbScrCallUi:CloseWinDow()
	end
end

function AutoMongTay.MuaThuocMC()	
	if (AutoMongTay.switchMC == 0) then
		return 
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	local nMyMapId	= me.GetMapTemplateId();
	local lvl = 1
	if me.nLevel >= 90 then
		lvl = 5
	elseif me.nLevel >= 70 then
		lvl = 4
	elseif me.nLevel >= 50 then
		lvl = 3
	elseif me.nLevel >= 30 then
		lvl = 2
	end
	local O_Trong = me.CountFreeBagCell()
	local nCountHP
	if me.nFaction == 9 then
		nCountHP = me.GetItemCountInBags(17,3,1,lvl)
	else
		nCountHP = me.GetItemCountInBags(17,1,1,lvl)
	end
	if AutoMongTay.MapTK() and O_Trong > 2 then
		SendChannelMsg("NearBy","Đi mua Nicotine !!!<pic=99>")
		local QQN = Ui.tbScrCallUi:TimNPC_TEN("Quan Quân Nhu (Mông Cổ)")
		if QQN then				
			if UiManager:WindowVisible(Ui.UI_SHOP) ~= 1 then					
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.Msg("<color=White>Hỏi : <color>"..szQuestion)
					for k = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[k], "Ta muốn mua thuốc") then								
							me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
							return Env.GAME_FPS * 1, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
						end
					end
				else
					AutoAi.SetTargetIndex(QQN.nIndex);										
				end
			else
				if me.nFaction ~= 9 then					
					local bOK, szMsg = me.ShopBuyItem(675 + lvl,O_Trong - 2)
					UiManager:CloseWindow(Ui.UI_SHOP);
				else
					local bOK, szMsg = me.ShopBuyItem(685 + lvl,O_Trong - 2)
					UiManager:CloseWindow(Ui.UI_SHOP);
				end
			end
		else
			local Xnpc, Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2613)
			if Xnpc then
				Ui.tbScrCallUi:MoveTo(Xnpc*32, Ynpc*32)
			end
		end					
	else
		self:SwitchMC()
	end
end

function AutoMongTay.MuaThuocTH()	
	if (AutoMongTay.switchTH == 0) then
		return 
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	local nMyMapId	= me.GetMapTemplateId();
	local lvl = 1
	if me.nLevel >= 90 then
		lvl = 5
	elseif me.nLevel >= 70 then
		lvl = 4
	elseif me.nLevel >= 50 then
		lvl = 3
	elseif me.nLevel >= 30 then
		lvl = 2
	end
	local O_Trong = me.CountFreeBagCell()
	local nCountHP
	if me.nFaction == 9 then
		nCountHP = me.GetItemCountInBags(17,3,1,lvl)
	else
		nCountHP = me.GetItemCountInBags(17,1,1,lvl)
	end
	if AutoMongTay.MapTK() and O_Trong > 2 then
		SendChannelMsg("NearBy","Đi mua Nicotine !!!<pic=99>")
		local QQN = Ui.tbScrCallUi:TimNPC_TEN("Quan Quân Nhu (Tây Hạ)")
		if QQN then				
			if UiManager:WindowVisible(Ui.UI_SHOP) ~= 1 then					
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.Msg("<color=White>Hỏi : <color>"..szQuestion)
					for k = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[k], "Ta muốn mua thuốc") then								
							me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
							return Env.GAME_FPS * 1, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
						end
					end
				else
					AutoAi.SetTargetIndex(QQN.nIndex);										
				end
			else
				if me.nFaction ~= 9 then					
					local bOK, szMsg = me.ShopBuyItem(675 + lvl,O_Trong - 2)
					UiManager:CloseWindow(Ui.UI_SHOP);
				else
					local bOK, szMsg = me.ShopBuyItem(685 + lvl,O_Trong - 2)
					UiManager:CloseWindow(Ui.UI_SHOP);
				end
			end						
		else
			local Xnpc, Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2614)
			if Xnpc then
				Ui.tbScrCallUi:MoveTo(Xnpc*32, Ynpc*32)
			end
		end					
	else
		self:SwitchTH()
	end
end
----------------------------------------------------------------
local loadvaomong = 0
local loadvaotay = 0

local TimerMg	= 0
local TimerTy	= 0
-----------------vào mông cổ------------------------------------
function AutoMongTay:VaoMCSwitch()
	if loadvaotay == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		me.Msg("<color=pink>Tắt Vào Tây !!!")
		loadvaotay = 0
		Ui.tbLogic.tbTimer:Close(TimerTy)
		TimerTy = 0
	end
	if loadvaomong == 0 then
		me.Msg("<color=yellow>Mở auto")
		TimerMg = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,self.GotoMC,self);
		loadvaomong = 1
	else
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		me.Msg("<color=pink>Tắt auto")
		loadvaomong = 0
		Ui.tbLogic.tbTimer:Close(TimerMg)
		TimerMg = 0
	end
end

function AutoMongTay:GotoMC()	
	if (loadvaomong == 0) then
		return 
	end	
	local nMyMapId	= me.GetMapTemplateId();
	SendChannelMsg("NearBy","Đi báo danh Mông Cổ !!!<pic=99>")
	if me.GetMapTemplateId() == 24 then
	local HieuUyMoBinhMongCo = Ui.tbScrCallUi:TimNPC_TEN("Hiệu Úy Mộ Binh Mông Cổ")
		if not HieuUyMoBinhMongCo then			
			me.StartAutoPath(1787,3513)				
			return
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0);
			me.AnswerQestion(0);
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		else
			AutoAi.SetTargetIndex(HieuUyMoBinhMongCo.nIndex);
		end
		return;
	else
		SendChannelMsg("NearBy","Đả vô Mông Cổ !!!<pic=99>")
		me.Msg("<color=pink>Auto Tắt !!!")
		loadvaomong = 0
	end
end
-----------------vào tay hạ------------------------------------
function AutoMongTay:VaoTHSwitch()
	if loadvaomong == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		me.Msg("<color=pink>Tắt Vào Mông !!!")
		loadvaomong = 0
		Ui.tbLogic.tbTimer:Close(TimerMg)
		TimerMg = 0
	end
	if loadvaotay == 0 then
		me.Msg("<color=yellow>Mở auto")
		TimerTy = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,self.GotoTH,self);
		loadvaotay = 1		
	else
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		me.Msg("<color=pink>Tắt auto")
		loadvaotay = 0
		Ui.tbLogic.tbTimer:Close(TimerTy)
		TimerTy = 0
	end
end

function AutoMongTay:GotoTH()
	if (loadvaotay == 0) then
		return 
	end
	local nMyMapId	= me.GetMapTemplateId();
	SendChannelMsg("NearBy","Đi báo danh Tây Hạ !!!<pic=99>")
	if me.GetMapTemplateId() == 24 then
	local HieuUyMoBinhTayHa = Ui.tbScrCallUi:TimNPC_TEN("Hiệu Úy Mộ Binh Tây Hạ")
		if not HieuUyMoBinhTayHa then			
			me.StartAutoPath(1795,3521)			
			return
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0);
			me.AnswerQestion(0);
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		else
			AutoAi.SetTargetIndex(HieuUyMoBinhTayHa.nIndex);
		end
		return;
	else
		SendChannelMsg("NearBy","Đả vô Tây Hạ !!!<pic=99>")
		me.Msg("<color=pink>Auto Tắt !!!")
		loadvaotay = 0
	end
end
---------hết-------------

function AutoMongTay:GetToNpcDistance(x1,y1,x2,y2)
	local dx = x1 - x2;
	local dy = y1 - y2;
	local nDistance = math.sqrt(dx^2 + dy^2);
	return nDistance;
end

function AutoMongTay:MoveTo(x,y)
	local _, nX, nY	= me.GetWorldPos();
	local nDx		= x - nX + MathRandom(-2, 2);
	local nDy		= y - nY + MathRandom(-2, 2);
	local nDir		= math.fmod(64 - math.atan2(nDx, nDy) * 32 / math.pi, 64);
	MoveTo(nDir, 0);
end
-----------------------------------------------------
function AutoMongTay:StopAll()
	me.Msg("<color=pink>AutoMongTay StopAll !!!")
	if AutoMongTay.statemc == 1 then Ui(Ui.Ui_MONGTAY):StateMC()
	elseif AutoMongTay.stateth == 1 then Ui(Ui.Ui_MONGTAY):StateTH()
	elseif loadvaotay == 1 then Ui(Ui.Ui_MONGTAY):VaoTHSwitch()
	elseif loadvaomong == 1 then Ui(Ui.Ui_MONGTAY):VaoMCSwitch()
	elseif AutoMongTay.switchMC == 1 then Ui(Ui.Ui_MONGTAY):SwitchMC()
	elseif AutoMongTay.switchTH == 1 then Ui(Ui.Ui_MONGTAY):SwitchTH()
	end
	return
end
-----------------------------------------------------
Ui:RegisterNewUiWindow("Ui_MONGTAY", "AutoMongTay", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});