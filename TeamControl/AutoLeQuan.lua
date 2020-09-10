local AutoLQ = Ui:GetClass("AutoLQ")
local AutoLQ2 = Ui:GetClass("AutoLQ2")
local UiScrCallUi = Ui.tbScrCallUi
AutoLQ.state = 0
local sTimer = 0

AutoLQ2.state = 0
local sTimer2 = 0

local uiSayPanel = Ui(Ui.UI_SAYPANEL)

function AutoLQ:State()	
	if AutoLQ.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,AutoLQ.Timers);
		me.Msg("<color=yellow>Tự đổi bạc <color> Bắt đầu");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự động Đổi bạc tại Lễ Quan <color><pic=78>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật tự động <color><bclr> Bắt đầu");
		AutoLQ.state = 1
	else
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
		end		
		AutoLQ.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		me.Msg("<color=white>Tự đổi bạc <color> Kết thúc");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự động Đổi bạc tại Lễ Quan <color><pic=80>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt tự động<color><bclr> Kết thúc");
		sTimer = 0		
	end	
end

function AutoLQ2:State()	
	if AutoLQ2.state == 0 then	
		sTimer2 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,AutoLQ2.Timers);
		me.Msg("<color=yellow>Tự nhận lương <color> Bắt đầu");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự động Nhận lương tại Lễ Quan <color><pic=78>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật tự động <color><bclr> Bắt đầu");
		AutoLQ2.state = 1
	else
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
		end		
		AutoLQ2.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer2);
		me.Msg("<color=white>Tự nhận lương <color> Kết thúc");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự động Nhận lương tại Lễ Quan <color><pic=80>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt tự động<color><bclr> Kết thúc");
		sTimer2 = 0		
	end	
end

function AutoLQ.CoTheDoi()
	local nLastXchgWeek	= me.GetTask(2080, 1);
	local nThisWeek		= Lib:GetLocalWeek(GetTime()) + 1
	if nLastXchgWeek ~= nThisWeek then	
		return true      
	else
		me.Msg("Tuần này đã đổi rồi")
		return false        
    end
end

local tbChon = {
{"Lễ Quan: Đến thật đúng lúc, ta có hoạt động cho ngươi.","Ta muốn hỏi chuyện khác",1},
{"Xin chào, ta có thể giúp được gì?","Nhận phúc lợi",1},
{"Chọn phúc lợi: ","Bạc khóa đổi bạc",1},
{"Lễ Quan: Người chơi đủ điều kiện có thể ","Đổi",1},
{"Bạn đã dùng bạc khóa đổi thành công","Kết thúc đối thoại",0},
{"Danh vọng của ngươi không đủ ","Kết thúc đối thoại",0},
{"Tuần này ngươi đã đổi,","Kết thúc đối thoại",0},
{"Tài khoản của ngươi đang bị khóa, không thể thực hiện thao tác này!","Kết thúc đối thoại",0}
}

local tbChon2 = {
{"Lễ Quan: Đến thật đúng lúc, ta có hoạt động cho ngươi.","Ta muốn hỏi chuyện khác",1},
{"Xin chào, ta có thể giúp được gì?","Nhận phúc lợi",1},
{"Chọn phúc lợi: ","Nhận lương",1},
{"Muốn nhận?","Ta muốn nhận lương",0},
{"Tuần này bạn đã nhận lương rồi.","Kết thúc đối thoại",0},
{"Tài khoản của ngươi đang bị khóa, không thể thực hiện thao tác này!","Kết thúc đối thoại",0},
{"Đáng tiếc! Thứ hạng của ngươi chưa đạt","Kết thúc đối thoại",0}
}

function AutoLQ.Timers()	
	if (AutoLQ.state == 0) then	
		return
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if AutoLQ.CoTheDoi() then
		local LQ = Ui.tbScrCallUi:TimNPC_TEN("Lễ Quan")
		if LQ then		
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();				
				for i = 1, table.getn(tbChon) do
					if string.find(szQuestion,tbChon[i][1]) then
						me.Msg("<color=White>Hỏi : <color>"..szQuestion)						
						if tbChon[i][3] == 0 then 
							for k = 1,table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbChon[i][2]) then								
									me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), AutoLQ.Stop(), AutoLQ2.Start();
								end
							end
						elseif tbChon[i][3] == 1 then
							for k = 1,table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbChon[i][2]) then								
									me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
								end
							end
						end
					end
				end
			else
				AutoAi.SetTargetIndex(LQ.nIndex)		
			end
		else
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2601);
			if Xnpc and Xnpc ~= 0 then
				Ui.tbScrCallUi:StartGoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
			else
				Ui.tbScrCallUi:StartGoTo(24,1721,3521)				
			end
		end
	else
		AutoLQ.state = 0
	end
end

function AutoLQ2.CoTheDoi()
	if nWeek == nLastWeek then	
		return true      
	else		
		me.Msg("Đã đổi")
		return false        
    end
end

function AutoLQ2.Timers()	
	if (AutoLQ2.state == 0) then	
		return
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if AutoLQ2.CoTheDoi() then
		local LQ = UiScrCallUi:TimNPC_TEN("Lễ Quan")
		if LQ then		
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();				
				for i = 1, table.getn(tbChon2) do
					if string.find(szQuestion,tbChon2[i][1]) then
						me.Msg("<color=White>Hỏi : <color>"..szQuestion)						
						if tbChon2[i][3] == 0 then 
							for k = 1,table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbChon2[i][2]) then								
									me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), AutoLQ2.Stop();
								end
							end
						elseif tbChon2[i][3] == 1 then
							for k = 1,table.getn(tbAnswers) do
								if string.find(tbAnswers[k],tbChon2[i][2]) then								
									me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
									return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), Ui.tbScrCallUi:CloseWinDow();
								end
							end
						end
					end
				end
			else
				AutoAi.SetTargetIndex(LQ.nIndex)		
			end
		else
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2601);
			if Xnpc and Xnpc ~= 0 then
				UiScrCallUi:StartGoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
			else
				UiScrCallUi:StartGoTo(24,1721,3521)				
			end
		end
	else
		AutoLQ2.state = 0
	end
end

---------hết-------------
function AutoLQ.Start()
	if AutoLQ.state == 0 then		
		AutoLQ:State()	
	end
end

function AutoLQ.Stop()
	if AutoLQ.state == 1 then		
		AutoLQ:State()
	end	
end

function AutoLQ2.Start()
	if AutoLQ2.state == 0 then		
		AutoLQ2:State()	
	end
end

function AutoLQ2.Stop()
	if AutoLQ2.state == 1 then		
		AutoLQ2:State()		
	end	
end

Ui:RegisterNewUiWindow("UI_LEQUAN", "AutoLQ", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
Ui:RegisterNewUiWindow("UI_LEQUAN2", "AutoLQ2", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local tCmd={"Ui(Ui.UI_LEQUAN2):State()", "LEQUAN2", "", "Alt+L", "Alt+L", "Lequan2"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);