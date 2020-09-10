local tbMaiDa5 = Ui:GetClass("tbMaiDa5");
tbMaiDa5.state = 0
local Timer =  Env.GAME_FPS * 1.7
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
tbMaiDa5.Say_bak = tbMaiDa5.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	tbMaiDa5.Say_bak(uiSayPanel,tbParam)
	if tbMaiDa5.state == 0 then return end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Đá 6 Cạnh") then
			me.AnswerQestion(i-1)		
		--else me.AnswerQestion(i-1)
		--me.AnswerQestion(i-1)
		break
		end
	end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Mài đá 6 cạnh") then
			me.AnswerQestion(i-1)		
		--else me.AnswerQestion(i-1)
		--me.AnswerQestion(i-1)
		break
		end
	end
end

function tbMaiDa5:State()
	if tbMaiDa5.state == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mài đá 5<color>");
		me.Msg("<color=yellow>Mài đá 5 cạnh")
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.7,tbMaiDa5.OnTimer);
		tbMaiDa5.state = 1
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 5<color>");
		me.Msg("<color=yellow>Ngừng mài đá 5 cạnh")
		tbMaiDa5.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

function tbMaiDa5.OnTimer()	
	if tbMaiDa5.state == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		me.Msg("<color=yellow>Ngừng mài đá 5 cạnh")
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if (me.GetItemCountInBags(18,1,20383,1) > 0) and (me.GetItemCountInBags(18,1,20382,5) > 0)then
	local tbFind = me.FindItemInBags(18,1,20382,5);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
		end
	else
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Ngừng mài đá 5 cạnh<color>");
		me.Msg("<color=yellow>Hết Cuốc hoặc Viên đá 5 cạnh")
		SendChannelMsg("Team", "Xong đá 5 rùi!!");
		tbMaiDa5.state = 0
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


Ui:RegisterNewUiWindow("UI_tbMaiDa5", "tbMaiDa5", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_tbMaiDa5):State()", "tbMaiDa5", "", "Ctrl+F5", "Ctrl+F5", "Mài đá 5"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
