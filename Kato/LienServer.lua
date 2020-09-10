Ui.UI_Server				= "UI_Server";
local Server			= Ui.tbWnd[Ui.UI_Server] or {};
Server.UIGROUP			= Ui.UI_Server;
Ui.tbWnd[Ui.UI_Server]	= Server

local self			= Server 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function Server:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color> Chuẩn bi báo danh liên server");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function Server.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if me.GetMapTemplateId() < 65500 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"<color=yellow>Mông Cổ Tây Hạ liên server") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1);
				end					
			end
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"Báo danh Biện Kinh") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1), Ui.tbScrCallUi:CloseWinDow(), Server.Stop();
				end					
			end
		else
			local tbItem = me.FindItemInBags(18,1,195,1)[1]; -- vo han truyen tong phu
			if tbItem then
			me.UseItem(tbItem.pItem);
			end
		end						
	else
		return Env.GAME_FPS * 0.5, Ui.tbScrCallUi:CloseWinDow(), Server.Stop();
	end
end

-------------------------------------------------------------------


function Server.Stop()
	
	self.state1 = 1 
	Server:State1()		
end
