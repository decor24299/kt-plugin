local TuoiThoNgua		= Ui.TuoiThoNgua or {};
Ui.TuoiThoNgua	= TuoiThoNgua
local self			= TuoiThoNgua 
self.state = 0;
local sTimer = 0

--local tCmd={"Ui.TuoiThoNgua:State()", "Ui.TuoiThoNgua", "", "Shift+G", "Shift+G", "dmm"};
--	 AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
function TuoiThoNgua:State()	
	if self.state == 0 then
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu tăng tuồi thọ ngựa<color>");
		self.state = 1
	else	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		self.CloseWindows()
	end	
end

function TuoiThoNgua.OnTimer()	
	if self.state == 0 then	return  end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				me.AnswerQestion(0)
				TuoiThoNgua:State();
		else
			if me.GetItemCountInBags(18,1,2990,1) > 0 then
				local tbFind = me.FindItemInBags(18,1,2990,1);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				TuoiThoNgua:State();
			end		
		end
end

function TuoiThoNgua.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
	end
end
function TuoiThoNgua:Stop()	
	if self.state == 1 then
		self:State();
	end
	return;
end
function TuoiThoNgua:Start()	
	if self.state == 0 then
		self:State();
	end
	return;
end
