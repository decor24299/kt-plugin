local AutoNCD = Ui:GetClass("AutoNCD")

AutoNCD.state = 0;
local TimerIt = 0;

local szCmd = [=[
	Ui(Ui.UI_NGUNGCONGDON):Start();
]=];
--UiShortcutAlias:AddAlias("GM_C8", szCmd);

local tbHoi_Chon = {
{"Hôm nay đã dùng <color=yellow>6<color> Ngưng Công Đơn, không thể dùng tiếp.","Kết thúc đối thoại"}
}

function AutoNCD:State()
	if AutoNCD.state == 0 then
		AutoNCD.state = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật <bclr=red><color=yellow>Ăn Ngưng Công Đơn []")
		me.Msg("<color=yellow>Bật Ăn Ngưng Công Đơn<color>");
		TimerIt = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,18,AutoNCD.Eat);
	else
		AutoNCD.state = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt <bclr=blue><color=white>Ăn Ngưng Công Đơn []")
		me.Msg("<color=green>Ngừng Ăn Ngưng Công Đơn<color>");
		Ui.tbLogic.tbTimer:Close(TimerIt);
		TimerIt = 0;		
	end
end

function AutoNCD:Start()
	if AutoNCD.state == 0 then
		AutoNCD:State();
	end
end

function AutoNCD.Eat()	
	if (AutoNCD.state == 0) then
		return;
	end	
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	local tbFind = me.FindItemInBags(18,1,20281,1)
	--local Count = me.GetItemCountInBags(18,1,20281,1)
	for j, tbItem in pairs(tbFind) do
		if tbFind then	
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				return Env.GAME_FPS * 1.5, me.UseItem(tbItem.pItem);
			else			
				for i = 1,table.getn(tbHoi_Chon) do
					if string.find(szQuestion,tbHoi_Chon[i][1]) then
						me.Msg(tostring("<color=White>Hỏi : <color>"..szQuestion))
						for k = 1, table.getn(tbAnswers) do
							if string.find(tbAnswers[k],tbHoi_Chon[i][2]) then
							me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[k]))
								return Env.GAME_FPS * 1.5, me.AnswerQestion(k-1), AutoNCD.CloseWindows(), AutoNCD:Stop();
							end
						end
					end
				end
			end			
		end
	end	
end

function AutoNCD.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")		
	end
end

function AutoNCD:Stop()			
	if AutoNCD.state == 1 then
		AutoNCD:State();		
	end
end
Ui:RegisterNewUiWindow("UI_NGUNGCONGDON", "AutoNCD", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

--local tCmd={"Ui(Ui.UI_NGUNGCONGDON):State()", "NGUNGCONGDON", "", "", "", "dmm"};
	--AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	--UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);