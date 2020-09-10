local tbTTP = Ui:GetClass("tbTTP");
tbTTP.state = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbTTP.Say_bak = tbTTP.Say_bak or uiSayPanel.OnOpen
local idphu = 0
function uiSayPanel:OnOpen(tbParam)
	tbTTP.Say_bak(uiSayPanel,tbParam)
	if tbTTP.state == 0 then return end
end

function tbTTP:State()
	if tbTTP.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu <color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,tbTTP.OnTimer);
		tbTTP.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng <color>");
		tbTTP.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbTTP.OnTimer()	
	if tbTTP.state == 0 then
--		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		UiManager:CloseWindow(Ui.UI_IBSHOP)
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if me.nBindCoin >= 1500 then  
		idphu = 310
	elseif me.nBindCoin >= 400 then  
		idphu = 309
	end	
	if  (me.GetItemCountInBags(18,1,195,1) < 1) and me.nBindCoin >= 400 then
		
		if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
			if Ui(Ui.UI_IBSHOP).m_nZoneType ~= 3 then
				Ui(Ui.UI_IBSHOP):OnButtonClick("BtnBindGoldSection");
				Ui(Ui.UI_IBSHOP):OnButtonClick("BtnType4");
			else
				if	me.IbCartIsEmpty() ~= 1 then
					me.IbCart_Commit(2)	
				else
					me.IbCart_AddWare(idphu,2);
				end
			end
		else
			UiManager:OpenWindow(Ui.UI_IBSHOP);
		end
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng<color>");
		SendChannelMsg("Team", "Đã hết đồng khóa hoặc đã có TTP trong hành trang");
		tbTTP.state = 0
		UiManager:CloseWindow(Ui.UI_IBSHOP)
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end	

	
end

Ui:RegisterNewUiWindow("UI_tbTTP", "tbTTP", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_tbTTP):State()", "tbTTP", "", "Shift+O", "Shift+O", "TTP"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
