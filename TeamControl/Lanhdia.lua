Ui.UI_LANHDIA				= "UI_LANHDIA";
local lanhdia			= Ui.tbWnd[Ui.UI_LANHDIA] or {};
lanhdia.UIGROUP			= Ui.UI_LANHDIA;
Ui.tbWnd[Ui.UI_LANHDIA]	= lanhdia

local self			= lanhdia 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function lanhdia:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color> Chuẩn bi vào Lãnh địa gia tộc");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đang trong lãnh địa rồi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function lanhdia.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if me.GetMapTemplateId() < 65500 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"<color=yellow>Lãnh địa gia tộc") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1);
				end					
			end
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"Đồng ý") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1), Ui.tbScrCallUi:CloseWinDow(), lanhdia.Stop();
				end					
			end
		else
			local tbItem = me.FindItemInBags(18,1,195,1)[1]; -- vo han truyen tong phu
			if tbItem then
			me.UseItem(tbItem.pItem);
			end
		end						
	else
		return Env.GAME_FPS * 1, Ui.tbScrCallUi:CloseWinDow(), lanhdia.Stop();
	end
end

-------------------------------------------------------------------


function lanhdia.Stop()
	if self.state == 1 then		
		lanhdia:State()		
	end	
	
	if self.state1 == 1 then		
		lanhdia:State1()		
	end	
	
end
