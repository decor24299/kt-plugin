local tbQuyNguyenLenh = Ui:GetClass("tbQuyNguyenLenh");
tbQuyNguyenLenh.state = 0

local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbQuyNguyenLenh.Say_bak = tbQuyNguyenLenh.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbQuyNguyenLenh.Say_bak(uiSayPanel,tbParam)
	if tbQuyNguyenLenh.state == 0 then 
		return 
	end
		for i = 1,table.getn(tbParam[2]) do
			me.Msg(tostring(tbParam[2][i]))
			if string.find(tbParam[2][i],"Kết thúc đối thoại") then
				me.AnswerQestion(i-1)
				tbQuyNguyenLenh:State()
			end	
		end
	
end

function tbQuyNguyenLenh:State()
	if tbQuyNguyenLenh.state == 0 then
		tbQuyNguyenLenh.state = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ăn Quy Nguyên Lệnh<color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,tbQuyNguyenLenh.OnTimer);
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		tbQuyNguyenLenh.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	end
end

function tbQuyNguyenLenh.OnTimer()	
	if tbQuyNguyenLenh.state == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	

	if me.GetItemCountInBags(18,1,20301,1) > 0 then	
		local tbFind = me.FindItemInBags(18,1,20301,1); -- Thiên niên linh qua
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end		
	elseif me.GetItemCountInBags(18,1,20302,1) > 0 then	
		local tbFind = me.FindItemInBags(18,1,20302,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
	elseif me.GetItemCountInBags(18,1,20302,2) > 0 then		
		local tbFind = me.FindItemInBags(18,1,20302,2);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
	else
		tbQuyNguyenLenh:State();
	end		
end

Ui:RegisterNewUiWindow("UI_tbQuyNguyenLenh", "tbQuyNguyenLenh", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--[[
local tCmd={"Ui(Ui.UI_tbQuyNguyenLenh):State()", "tbQuyNguyenLenh", "", "Shift+F10", "Shift+F10", "Gánh nước"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
--]]