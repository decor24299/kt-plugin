local tbDa3 = Ui:GetClass("tbDa3");
tbDa3.state = 0
local Dem = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbDa3.Say_bak = tbDa3.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbDa3.Say_bak(uiSayPanel,tbParam)
	if tbDa3.state == 0 then return end
		
		for i = 1,table.getn(tbParam[2]) do
			me.Msg(tostring(tbParam[2][i]))
			if string.find(tbParam[2][i],"Nhận thưởng đá 2 Cạnh")
				or string.find(tbParam[2][i],"Nhận thưởng đá 3 Cạnh") then
				me.AnswerQestion(i-1) 
				me.AnswerQestion(0)
				Dem = Dem + 1
			end	
		end
	
end

function tbDa3:State()
	if tbDa3.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu ăn đá 3<color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,tbDa3.OnTimer);
		tbDa3.state = 1
		
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		tbDa3.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
		UiManager:CloseWindow(Ui.UI_SAYPANEL)	
	end
end

function tbDa3.OnTimer()	
	if Dem == 10 then
		Dem = 0 tbDa3:State()
		return 
	end	
	
		if me.GetItemCountInBags(18,1,20382,3) > 0 then
			local tbFind = me.FindItemInBags(18,1,20382,3);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,20382,2) > 0 then
			local tbFind = me.FindItemInBags(18,1,20382,2);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		else
			tbDa3:State()
		end	
end

Ui:RegisterNewUiWindow("UI_tbDa3", "tbDa3", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_tbDa3):State()", "tbDa3", "", "Shift+F12", "Shift+F12", "Gánh nước"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
