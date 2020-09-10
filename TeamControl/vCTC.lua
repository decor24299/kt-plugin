----------- lên tầng CTC ------------
local self = tbvCTC

local tbvCTC = Map.tbvCTC or {};
Map.tbvCTC = tbvCTC;

local loadCTC1 = 0;
local loadCTC2 = 0;
local loadCTC3 = 0;
local loadCTC4 = 0;

local nTimerCTC1 = 0;
local nTimerCTC2 = 0;
local nTimerCTC3 = 0;
local nTimerCTC4 = 0;

function tbvCTC:CTC1Switch()
	if loadCTC1 == 0 then
		loadCTC1 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Tự Lên tầng 2 Công Thành Chiến <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerCTC1 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTC1,self);
	else
		loadCTC1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự lên tầng 2 Công Thành Chiến <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerCTC1);
		nTimerCTC1 = 0;
	end
end

function tbvCTC:GoToCTC1()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetMapTemplateId() > 1811) and (me.GetMapTemplateId() < 1827) then
		if (pNpc.nTemplateId == 7131) or pNpc.szName == "Vào tầng kế" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Lên Tầng 2  <color>");
			break;
		end
	else	
		loadCTC1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerCTC1);
		nTimerCTC1 = 0;			
		end
	end
end


function tbvCTC:CTC2Switch()
	if loadCTC2 == 0 then
		loadCTC2 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Tự Lên tầng 3 Công Thành Chiến <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerCTC2 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTC2,self);
	else
		loadCTC2 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự lên tầng 3 Công Thành Chiến <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerCTC2);
		nTimerCTC2 = 0;
	end
end

function tbvCTC:GoToCTC2()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetMapTemplateId() > 1826) and (me.GetMapTemplateId() < 1832) then
		if (pNpc.nTemplateId == 7132) or pNpc.szName == "Vào ngai vàng" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Lên Tầng 3  <color>");
			break;
		end
	else	
		loadCTC2 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerCTC2);
		nTimerCTC2 = 0;			
		end
	end
end


function tbvCTC:CTC3Switch()
	if loadCTC3 == 0 then
		loadCTC3 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật nhận bánh <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerCTC3 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTC3,self);
	else
		loadCTC3 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt nhận bánh <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerCTC3);
		nTimerCTC3 = 0;
	end
end

function tbvCTC:GoToCTC3()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetMapTemplateId() < 30) then
		if (pNpc.nTemplateId == 20277) then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(0);
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Nhận bánh  <color>");
			break;
		end
	else	
		loadCTC3 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerCTC3);
		nTimerCTC3 = 0;			
		end
	end
end

function tbvCTC:CTC4Switch()
	if loadCTC4 == 0 then
		loadCTC4 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Đến Tế Tự Đài <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerCTC4 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTC4,self);
	else
		loadCTC4 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Dừng Auto <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerCTC4);
		nTimerCTC4 = 0;
	end
end

function tbvCTC:GoToCTC4()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetMapTemplateId() > 65000) then
		if (pNpc.nTemplateId == 9948) then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			me.AnswerQestion(1);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Đi nào <color>");
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			break;
		end
	else	
		loadCTC4 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerCTC4);
		nTimerCTC4 = 0;			
		end
	end
end

	