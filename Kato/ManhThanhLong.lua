local ManhThanhLong = Ui:GetClass("ManhThanhLong");
ManhThanhLong.state = 0
local Dem = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
ManhThanhLong.Say_bak = ManhThanhLong.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	ManhThanhLong.Say_bak(uiSayPanel,tbParam)
	if ManhThanhLong.state == 0 then return end
		
		for i = 1,table.getn(tbParam[2]) do
			me.Msg(tostring(tbParam[2][i]))
			if string.find(tbParam[2][i],"Mảnh Thanh Long") then
				me.AnswerQestion(i-1) 
				break
			end	
		end
	
end

function ManhThanhLong:State()
	if ManhThanhLong.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mở mảnh thanh long<color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,ManhThanhLong.OnTimer);
		ManhThanhLong.state = 1
		
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		ManhThanhLong.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	end
end

function ManhThanhLong.OnTimer()	
	if Dem == 10 then
		Dem = 0 ManhThanhLong:State()
		return 
	end	
	
		if me.GetItemCountInBags(18,1,20691,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,20691,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		else
			ManhThanhLong:State()
		end	
end

Ui:RegisterNewUiWindow("UI_ManhThanhLong", "ManhThanhLong", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_ManhThanhLong):State()", "ManhThanhLong", "", "Shift+F12", "Shift+F12", "Gánh nước"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
