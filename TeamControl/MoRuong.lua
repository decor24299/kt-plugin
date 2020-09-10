local tbMoRuong = Ui:GetClass("tbMoRuong");
tbMoRuong.state = 0
local Timer =  Env.GAME_FPS * 0.5
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbMoRuong.Say_bak = tbMoRuong.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbMoRuong.Say_bak(uiSayPanel,tbParam)
	if tbMoRuong.state == 0 then return end	
end

function tbMoRuong:State()
	if tbMoRuong.state == 0 then
		tbMoRuong.state = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mở rương TBĐ<color>");
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,tbMoRuong.OnTimer);
	else
		tbMoRuong.state = 0
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbMoRuong.OnTimer()	
	if tbMoRuong.state == 0 then 
		return
	end
		
		if me.GetItemCountInBags(18,1,20415,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,20415,1); -- DTT kinh ghiệm đơn
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,1681,1) > 0 then	
			local tbFind = me.FindItemInBags(18,1,1681,1); --Qua 2 thiết mộc chân
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,330,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,330,1); --Rương Hoàng Kim
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,331,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,331,1); --Rương Bạch Ngân
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,332,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,332,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,20445,1) > 0 then		
			local tbFind = me.FindItemInBags(18,1,20445,1); -- quang vu tinh hoa
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,20608,1) > 0 then	
			local tbFind = me.FindItemInBags(18,1,20608,1); -- Hộp quà tây hạ
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,20624,1) > 0 then	
			local tbFind = me.FindItemInBags(18,1,20624,1); -- Hộp quà Vinh Dự bạch Hổ đường
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,1868,8) > 0 then	
			local tbFind = me.FindItemInBags(18,1,1868,8);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,1868,5) > 0 then	
			local tbFind = me.FindItemInBags(18,1,1868,5);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,1868,6) > 0 then	
			local tbFind = me.FindItemInBags(18,1,1868,6);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		elseif me.GetItemCountInBags(18,1,244,1) > 0 then
			local tbFind = me.FindItemInBags(18,1,244,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		else
			tbMoRuong:State();
		end	
	end

Ui:RegisterNewUiWindow("UI_tbMoRuong", "tbMoRuong", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
--local tCmd={"Ui(Ui.UI_tbMoRuong):State()", "tbMoRuong", "", "Shift+F12", "Shift+F12", "Gánh nước"};
--	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
