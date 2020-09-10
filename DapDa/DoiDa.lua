local tbMaiDa		= Ui.tbMaiDa or {};
Ui.tbMaiDa	= tbMaiDa
local self			= tbMaiDa 

local CJPath = "\\interface\\";
if UiVersion == 2 then
	CJPath = "\\interface2\\";
end
self.state = 0;
local sTimer = 0
local sTimerOsy = 0
local uiActiveGift = Ui(Ui.UI_ACTIVEGIFT);
local ActiveGift = SpecialEvent.ActiveGift;

local tCmd={"Ui.tbMaiDa:State()", "Ui.tbMaiDa", "", "Shift+I", "Shift+I", "dmm"};
	 AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
function tbMaiDa:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	
	tbMaiDa.Say_bak	= tbMaiDa.Say_bak or uiMsgPad.OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway, nSpeTitle)
		tbMaiDa.Say_bak(uiMsgPad, szChannelName, szName, szMsg, szGateway, nSpeTitle);
		local function fnOnSay()			
			tbMaiDa:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle);
			return 0;
		end

		Ui.tbLogic.tbTimer:Register(1,fnOnSay);
	end
	local uiTaskTips 		= Ui(Ui.UI_TASKTIPS)
	tbMaiDa.Tip_Bak = tbMaiDa.Tip_Bak or uiTaskTips.Begin
	function uiTaskTips:Begin(szTips, nTime)
		tbMaiDa.Tip_Bak(uiTaskTips, szTips, nTime)
		local function fnOnTip()
			tbMaiDa:OnTip(szTips, nTime);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnTip);
	end
end
function tbMaiDa:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle)
	if (self.state == 0) then return end
	local num = ""
	
	if string.find(szMsg, "Nhận được") and szChannelName=="GM" then
		self.state = self.state + 1
	end
end
function tbMaiDa:OnTip(szTips, nTime)
	if self.state == 0 then		
			return
		end
	if string.find(szTips,"Chỉ có thể Đổi trong các thành lớn") then		
		me.Msg("<color=White>Thông báo: <color>"..szTips)
		self:State()
	end
end
function tbMaiDa.CoTheNhan()
	local nActiveGrade = ActiveGift:GetActiveGrade();
	if nActiveGrade >= 60 then
		return true
	end
	return false
end

function tbMaiDa:State()	
	if self.state == 0 then
		sTimerOsy = Ui.tbLogic.tbTimer:Register(1,self.ModifyUi,self);
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.5,self.OnTimer,self);
		me.Msg("<color=yellow>Đồ mài đá <color> Bắt đầu");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu Nhận Đồ Mài Đá<color>");
		self.state = self.state + 1
	else	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimerOsy);
		Ui.tbLogic.tbTimer:Close(sTimer);
		me.Msg("<color=white>Đồ mài đá <color> Kết thúc");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Kết thúc Nhận Đồ Mài Đá<color>");
		self.CloseWindows()
	end	
end

function tbMaiDa.OnTimer()	
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	local nActiveGrade = ActiveGift:GetActiveGrade();
	if (UiManager:WindowVisible(Ui.UI_SYSTEMEX) == 1) then return end
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then return end
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then	return end
	if (self.state == 0) then
		return;
	end
	if (self.state > 0 and self.state < 5) then
		local ChonQua = "Đạt 150 điểm năng động"
		if self.state == 1 then ChonQua = "Đạt 70 điểm năng động"
		elseif self.state == 2 then ChonQua = "Đạt 90 điểm năng động"
		elseif self.state == 3 then ChonQua = "Đạt 120 điểm năng động"
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			if string.find(szQuestion, "Nhan Như Ngọc: Xin chào") then
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Hoạt động trọng điểm") then
						return Env.GAME_FPS * 1.2, me.AnswerQestion(i-1), me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbInfo)), Ui.tbScrCallUi:CloseWinDow();
					end				
				end
			elseif string.find(szQuestion, "Chỗ ta có những hoạt động ") then
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Đồ mài đá") then
						return Env.GAME_FPS * 1.2, me.AnswerQestion(i-1), me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbInfo)), Ui.tbScrCallUi:CloseWinDow();
					end
				end
			elseif string.find(szQuestion, "Điều kiện tham gia") then
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, ChonQua) then
						return Env.GAME_FPS * 1.2, me.AnswerQestion(i-1), me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbInfo)), Ui.tbScrCallUi:CloseWinDow();
					end
				end
			elseif string.find(szQuestion, "Hôm nay ngươi đã tham gia hoạt động này rồi") then
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Kết thúc đối thoại") then
						Ui.tbScrCallUi:CloseWinDow();
						self.state = self.state + 1
					end
				end
			elseif string.find(szQuestion, "Độ năng động trong ngày") then
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Kết thúc đối thoại") then
						Ui.tbScrCallUi:CloseWinDow();
						self:State()
					end
				end
			end
		else
			me.CallServerScript({"ExchangeFuYuan"})
		end
	else
		Ui.tbScrCallUi:CloseWinDow();
		self:State()
	end
end

function tbMaiDa.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
	end
end
function tbMaiDa:Stop()	
	if self.state == 1 then
		self:State();
	end
	return;
end
function tbMaiDa:Start()	
	if self.state == 0 then
		self:State();
	end
	return;
end
