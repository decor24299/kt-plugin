Ui.UI_TULUYENCHAU				= "UI_TULUYENCHAU";
local TuLuyenChau			= Ui.tbWnd[Ui.UI_TULUYENCHAU] or {};
TuLuyenChau.UIGROUP			= Ui.UI_TULUYENCHAU;
Ui.tbWnd[Ui.UI_TULUYENCHAU]	= TuLuyenChau
local self = TuLuyenChau

self.state = 0
local sTimer = 0
local nDelay = Env.GAME_FPS * 1.5
local sDelay = Env.GAME_FPS * 0.5


local szCmd = [=[
	Ui(Ui.UI_TULUYENCHAU):State();
]=];
UiShortcutAlias:AddAlias("GM_S3", szCmd);

local tbHoi_Chon = {
{"Đặt tay lên cảm thấy khí huyết cuộn dâng.","<color=yellow>Ta muốn mở tu luyện",1},
{"Đặt tay lên cảm thấy khí huyết cuộn dâng.","Ta muốn mở 0.5 giờ.",1},
{"Bạn đã tăng","Kết thúc đối thoại",1},
{"Thời gian tu luyện bạn tích lũy không đủ","Kết thúc đối thoại",0},
}
-- (18,1,16,1)
function TuLuyenChau.TuChau()
	if (me.GetItemCountInBags(18,1,16,1) == 1) then
		return true
	else
		me.Msg(KItem.GetNameById(18,1,16,1).." <color=lightgreen> không mang bên mình !!!")
		return false
	end
end

function TuLuyenChau.TimerTuChau()
	local tbItem = Item:GetClass("xiulianzhu");
		if (tbItem:GetReTime() > 0) then
		-- if (tbItem:GetRemainTime() > 0) then
			return true
		else
			me.Msg(KItem.GetNameById(18,1,16,1).." <color=lightgreen> của bạn đã hết thời gian tích lũy !!!")				
			return false
		end	
	
end

function TuLuyenChau:State()	
	if self.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(nDelay, self.OnTimer, self);
		me.Msg("<color=yellow>Tự mở Tu Luyện Châu<color> Bắt đầu");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự mở Tu Luyện Châu<color><pic=78>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật tự động <color><bclr> Bắt đầu");
		self.state = 1
	else
		self:CloseSay()	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		me.Msg("<color=white>Tự mở Tu Luyện Châu<color> Kết thúc");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự mở Tu Luyện Châu<color><pic=80>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt tự động<color><bclr> Kết thúc");
		sTimer = 0
	end	
end

function TuLuyenChau.OnTimer()	
	if (self.state == 0) then
		return
	end
	if UiManager.hlWaTimeId ~= 0 and me.nFightState == 0 then
		return
	end	
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer()
	local _, _, nRestTime = me.GetSkillState(332)	
	if TuLuyenChau.TimerTuChau() and TuLuyenChau.TuChau() then		
		if (not nRestTime or nRestTime < nDelay) then
			local tbFind = me.FindItemInBags(18,1,16,1)
			local Count = me.GetItemCountInBags(18,1,16,1)		
			for _, tbItem in pairs(tbFind) do	
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
					me.UseItem(tbItem.pItem);
				else					
					for i = 1, table.getn(tbHoi_Chon) do
						if string.find(szQuestion,tbHoi_Chon[i][1]) then
							me.Msg("<color=White>Hỏi : <color>"..szQuestion)		
							if tbHoi_Chon[i][3] == 1 then	
								for j = 1,table.getn(tbAnswers) do
									if string.find(tbAnswers[j],tbHoi_Chon[i][2]) then
										me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[j]))
										return nDelay, me.AnswerQestion(j-1), sDelay, self:CloseSay();
									end
								end
							elseif tbHoi_Chon[i][3] == 0 then
								return sDelay, self:State()
							end
						end
					end
				end	
			end
		end		
	else		
		return sDelay, self:State()
	end
end

function TuLuyenChau.CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
end

function TuLuyenChau:Start()	
	if self.state == 0 then	
		TuLuyenChau:State()
	end	
end

function TuLuyenChau:Stop()	
	if self.state == 1 then	
		TuLuyenChau:State()
	end	
end