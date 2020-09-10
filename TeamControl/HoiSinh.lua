local tbHoiSinh = Ui:GetClass("tbHoiSinh");
tbHoiSinh.state = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbHoiSinh.Say_bak = tbHoiSinh.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbHoiSinh.Say_bak(uiSayPanel,tbParam)
	if tbHoiSinh.state == 0 then return end
end

function tbHoiSinh:State()
	if tbHoiSinh.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu <color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,tbHoiSinh.OnTimer);
		tbHoiSinh.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng <color>");
		tbHoiSinh.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbHoiSinh.OnTimer()	
	if tbHoiSinh.state == 0 then
--		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		UiManager:CloseWindow(Ui.UI_IBSHOP)
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if (me.GetItemCountInBags(18,1,24,1) > 0)then
		me.SendClientCmdRevive(1);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng<color>");		
		tbHoiSinh.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng<color>");		
		tbHoiSinh.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
		Ui(Ui.UI_tbCCTMH):State();
	end	
		

	--if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
	--	UiManager:CloseWindow(Ui.UI_IBSHOP)
	--end
end


Ui:RegisterNewUiWindow("UI_tbHoiSinh", "tbHoiSinh", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_tbHoiSinh):State()", "tbHoiSinh", "", "Shift+O", "Shift+O", "CKP"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
