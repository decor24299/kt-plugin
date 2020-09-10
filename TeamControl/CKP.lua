local tbCKP = Ui:GetClass("tbCKP");
tbCKP.state = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbCKP.Say_bak = tbCKP.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbCKP.Say_bak(uiSayPanel,tbParam)
	if tbCKP.state == 0 then return end
end

function tbCKP:State()
	if tbCKP.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu <color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,tbCKP.OnTimer);
		tbCKP.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng <color>");
		tbCKP.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbCKP.OnTimer()	
	if tbCKP.state == 0 then
--		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		UiManager:CloseWindow(Ui.UI_IBSHOP)
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if me.nBindCoin >= 200 and (me.GetItemCountInBags(18,1,85,1) < 1)then
		if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
			if Ui(Ui.UI_IBSHOP).m_nZoneType ~= 3 then
				Ui(Ui.UI_IBSHOP):OnButtonClick("BtnBindGoldSection");
				Ui(Ui.UI_IBSHOP):OnButtonClick("BtnType4");
			else
				if	me.IbCartIsEmpty() ~= 1 then
					me.IbCart_Commit(2)	
				else
					me.IbCart_AddWare(319,2);
				end
			end
		else
			UiManager:OpenWindow(Ui.UI_IBSHOP);
		end
	--if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
	--	UiManager:CloseWindow(Ui.UI_IBSHOP)
	--end
end


Ui:RegisterNewUiWindow("UI_tbCKP", "tbCKP", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_tbCKP):State()", "tbCKP", "", "Shift+O", "Shift+O", "CKP"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
