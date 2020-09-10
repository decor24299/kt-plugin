local NLHN		= Ui.NLHN or {};
Ui.NLHN	= NLHN
local self			= NLHN 

local CJPath = "\\interface\\";
if UiVersion == 2 then
	CJPath = "\\interface2\\";
end
self.state = 0;
local sTimer = 0
local sTimerOsy = 0
local uiActiveGift = Ui(Ui.UI_ACTIVEGIFT);
local ActiveGift = SpecialEvent.ActiveGift;

local szCmd = [=[
	Ui.NLHN:State();
]=];

function NLHN:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	NLHN.Say_bak	= NLHN.Say_bak or uiMsgPad.OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway, nSpeTitle)
		NLHN.Say_bak(uiMsgPad, szChannelName, szName, szMsg, szGateway, nSpeTitle);
		local function fnOnSay()			
			NLHN:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1,fnOnSay);
	end
	local uiTaskTips 		= Ui(Ui.UI_TASKTIPS)
	NLHN.Tip_Bak = NLHN.Tip_Bak or uiTaskTips.Begin
	function uiTaskTips:Begin(szTips, nTime)
		NLHN.Tip_Bak(uiTaskTips, szTips, nTime)
		local function fnOnTip()
			NLHN:OnTip(szTips, nTime);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnTip);
	end
end
function NLHN:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle)
	if (self.state == 0) then return end
	
end
function NLHN:OnTip(szTips, nTime)
	if self.state == 0 then		
			return
		end
	if string.find(szTips,"Xem ra ngươi cũng biết không ít, cho ngươi vào.") then		
		me.Msg("<color=White>Thông báo: <color>"..szTips)
		self:State()
		SendChannelMsg("Team", "Xong!!");
	end
end

function NLHN:State()	
	if self.state == 0 then
		sTimerOsy = Ui.tbLogic.tbTimer:Register(1,self.ModifyUi,self);
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.5,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<color=Yellow>Trả bài <color> Bắt đầu <pic=78>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật Trả bài <color><bclr> Bắt đầu");
		self.state = 1
	else	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimerOsy);
		Ui.tbLogic.tbTimer:Close(sTimer);
		UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Trả bài <color> Kết thúc <pic=80>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt trả bài<color><bclr> Kết thúc");
		self.CloseWindows()
	end	
end

function NLHN.OnTimer()	
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if (UiManager:WindowVisible(Ui.UI_SYSTEMEX) == 1) then return end
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then return end
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then	return end
	if (self.state == 0) then
		return;
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() > 65500 then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"<color=yellow>Bắt đầu khiêu chiến") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1);
				end					
			end
			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"<color=yellow>Bắt đầu trả lời") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1);
				end					
			end
			
			for i = 1,table.getn(tbAnswers) do
				if string.find(tbAnswers[i],"B") then
					me.Msg(tostring(""..tbAnswers[i]))
					return Env.GAME_FPS * 1, me.AnswerQestion(i-1);--, Ui.tbScrCallUi:CloseWinDow(), NLHN.Stop();
				end					
			end
		else
			if (pNpc.nTemplateId == 9966) then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			break;
			end
		end						
	else
		--return Env.GAME_FPS * 1, Ui.tbScrCallUi:CloseWinDow(), NLHN.Stop();
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimerOsy);
		Ui.tbLogic.tbTimer:Close(sTimer);
		UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Trả bài <color> Kết thúc <pic=80>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt trả bài<color><bclr> Kết thúc");
		self.CloseWindows()
	end
end
end

function NLHN.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
	end
end
function NLHN:Stop()	
	if self.state == 1 then
		self:State();
	end
	return;
end
function NLHN:Start()	
	if self.state == 0 then
		self:State();
	end
	return;
end
