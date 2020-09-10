local tbMaiDa6 = Ui:GetClass("tbMaiDa6");
tbMaiDa6.state = 0
local Timer =  Env.GAME_FPS * 1.7
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbMaiDa6.Say_bak = tbMaiDa6.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbMaiDa6.Say_bak(uiSayPanel,tbParam)
	if tbMaiDa6.state == 0 then return end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Đá 7 Cạnh") then
			me.AnswerQestion(i-1)		
		--else me.AnswerQestion(i-1)
		--me.AnswerQestion(i-1)
		break
		end
	end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Mài đá 7 cạnh") then
			me.AnswerQestion(i-1)		
		--else me.AnswerQestion(i-1)
		--me.AnswerQestion(i-1)
		break
		end
	end
end

function tbMaiDa6:State()
	if tbMaiDa6.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mài đá 6<color>");
		me.Msg("<color=yellow>Mài đá 6 cạnh")
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.7,tbMaiDa6.OnTimer);
		tbMaiDa6.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 6<color>");
		me.Msg("<color=yellow>Ngừng mài đá 6 cạnh")
		tbMaiDa6.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbMaiDa6.OnTimer()	
	if tbMaiDa6.state == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		me.Msg("<color=yellow>Ngừng mài đá 6 cạnh")
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if (me.GetItemCountInBags(18,1,20383,1) > 0) and (me.GetItemCountInBags(18,1,20382,6) > 0)then
	local tbFind = me.FindItemInBags(18,1,20382,6);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 6 cạnh<color>");
		me.Msg("<color=yellow>Hết Cuốc hoặc Viên đá 6 cạnh")
		SendChannelMsg("Team", "Xong đá 6 rùi!!");
		tbMaiDa6.state = 0
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


Ui:RegisterNewUiWindow("UI_tbMaiDa6", "tbMaiDa6", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_tbMaiDa6):State()", "tbMaiDa6", "", "Ctrl+F6", "Ctrl+F6", "Mài đá 6"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
