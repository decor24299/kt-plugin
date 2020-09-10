local tbMaiDa2 = Ui:GetClass("tbMaiDa2");
tbMaiDa2.state = 0
local Timer =  Env.GAME_FPS * 1.7
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbMaiDa2.Say_bak = tbMaiDa2.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbMaiDa2.Say_bak(uiSayPanel,tbParam)
	if tbMaiDa2.state == 0 then return end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Đá 3 Cạnh") then
			me.AnswerQestion(i-1)		
			break
		--else me.AnswerQestion(i-1)
		--me.AnswerQestion(i-1)
		end
	end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Mài đá 3 cạnh") then
			me.AnswerQestion(i-1)		
			break
		--else me.AnswerQestion(i-2)
		--me.AnswerQestion(i-2)
		end
	end
end

function tbMaiDa2:State()
	if tbMaiDa2.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mài đá 2<color>");
		me.Msg("<color=yellow>Mài đá 2 cạnh")
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.7,tbMaiDa2.OnTimer);
		tbMaiDa2.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 2<color>");
		me.Msg("<color=yellow>Ngừng mài đá 2 cạnh")
		tbMaiDa2.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbMaiDa2.OnTimer()	
	if tbMaiDa2.state == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		me.Msg("<color=yellow>Ngừng mài đá 2 cạnh")
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if (me.GetItemCountInBags(18,1,20383,1) > 0) and (me.GetItemCountInBags(18,1,20382,2) > 0)then
	local tbFind = me.FindItemInBags(18,1,20382,2);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 2 cạnh<color>");
		me.Msg("<color=yellow>Hết Cuốc hoặc Viên đá 2 cạnh")
		SendChannelMsg("Team", "Xong đá 2 rùi!!");
		tbMaiDa2.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end	
	
	--[[local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do		
		if (pNpc.nTemplateId == 20204) or pNpc.szName=="Giếng nước" then					
			AutoAi.SetTargetIndex(pNpc.nIndex)								
		end
	end]]

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
	end
end


Ui:RegisterNewUiWindow("UI_tbMaiDa2", "tbMaiDa2", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_tbMaiDa2):State()", "tbMaiDa2", "", "Ctrl+F2", "Ctrl+F2", "Mài đá 2"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
