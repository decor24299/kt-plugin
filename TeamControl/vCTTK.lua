--vào Mông Cổ - Tây Hạ - Phó bản--
local self = tbvCTTK

local tbvCTTK = Map.tbvCTTK or {};
Map.tbvCTTK = tbvCTTK;

local loadCTTK1 = 0;
local loadCTTK2 = 0;
local loadCTTK3 = 0;
local loadCTTK4 = 0;
local loadCTTK5 = 0;
local loadCTTK6 = 0;
local loadCTTK7 = 0;
local loadCTTK8 = 0;
local loadCTTK9 = 0;
local loadCTTK10 = 0;

local nTimerId2 = 0;
local nTimerId3 = 0;
local nTimerId4 = 0;
local nTimerId5 = 0;
local nTimerId6 = 0;
local nTimerId7 = 0;
local nTimerId8 = 0;
local nTimerId9 = 0;
local nTimerId10 = 0;
local nTimerId11 = 0;

local szCmd = [=[
	Map.tbvCTTK:CTTK1Switch();
]=];

function tbvCTTK:CTTK1Switch()
	if loadCTTK1 == 0 then
		loadCTTK1 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật vào Mông Cổ <color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerId2 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK1,self);
	else
		loadCTTK1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự vào Mông Cổ <color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId2);
		nTimerId2 = 0;
	end
end

function tbvCTTK:GoToCTTK1()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() == 24 then
		if (pNpc.nTemplateId == 2503) or pNpc.szName == "Hiệu Úy Mộ Binh Mông Cổ" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Vào Mông Cổ <color>");
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;
		end			
	else	
		loadCTTK1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId2);
		nTimerId2 = 0;
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK2Switch();
]=];

function tbvCTTK:CTTK2Switch()
	if loadCTTK2 == 0 then
		loadCTTK2 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật vào Tây Hạ<color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId3 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK2,self);
	else
		loadCTTK2 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự vào Tây Hạ <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId3);
		nTimerId3 = 0;
	end
end

function tbvCTTK:GoToCTTK2()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() == 24 then
		if (pNpc.nTemplateId == 2506) or pNpc.szName == "Hiệu Úy Mộ Binh Tây Hạ" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào Tây Hạ <color>");
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK2 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId3);
		nTimerId3 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK3Switch();
]=];

function tbvCTTK:CTTK3Switch()
	if loadCTTK3 == 0 then
		loadCTTK3 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật vào Mộng Cảnh <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId4 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK3,self);
	else
		loadCTTK3 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự vào Mộng Cảnh <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId4);
		nTimerId4 = 0;
	end
end

function tbvCTTK:KiemTraDaTraNhiemVuBMS()	
	--For Test
	--[[me.Msg(tostring("countTest="..countTest));
	if countTest < 50 then
		countTest = countTest + 1;
		
		return 0;
	else
		return 1;
	end]]
	--End test
	
	local tbPlayerTask = Task:GetPlayerTask(me)
	for i = 0,5 do	
		local tbTask = tbPlayerTask.tbTasks[333+i]
		if (tbTask) and string.find(tbTask.tbReferData.szName,"Cổ Họa") then
			local tbCurTags = tbTask.tbCurTags;					
			local szRefSubTaskName = tbTask.tbReferData.szName;
			local tbSubTaskData = tbTask.tbSubData;
			if (tbTask.nCurStep == 2) or tbTask.nCurStep == -1 then
				return 0;			
			end;
		end
	end
	
	return 1;
end

function tbvCTTK:GoToCTTK3()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() == 24 then
		if (pNpc.nTemplateId == 20178) or pNpc.szName == "Phó Thụy Lỗi" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào Mộng Cảnh <color>");
			me.AnswerQestion(0)
			--me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK3 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId4);
		nTimerId4 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK4Switch();
]=];

function tbvCTTK:CTTK4Switch()
	if loadCTTK4 == 0 then
		loadCTTK4 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật rời Mộng Cảnh <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId5 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK4,self);
	else
		loadCTTK4 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự rời Mộng Cảnh <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId5);
		nTimerId5 = 0;
	end
end

function tbvCTTK:GoToCTTK4()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	--if string.find(GetMapNameFormId(nMyMapId),"Quán Trọ Long Môn(Mộng Cảnh)") then
	if me.GetMapTemplateId() > 65540 then
		if (pNpc.nTemplateId == 20177) or pNpc.szName == "Phó Thụy Lỗi" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Rời khỏi Mộng Cảnh <color>");
			me.AnswerQestion(0)
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			break;
		end
	else	
		loadCTTK4 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId5);
		nTimerId5 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK5Switch();
]=];

function tbvCTTK:CTTK5Switch()
	if loadCTTK5 == 0 then
		loadCTTK5 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Train Mộng Cảnh <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId6 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK5,self);
	else
		loadCTTK5 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự Train Mộng Cảnh <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId6);
		nTimerId6 = 0;
		me.AutoFight(0)
	end
end

function tbvCTTK:GoToCTTK5()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() == 24 then
		if (pNpc.nTemplateId == 20178) or pNpc.szName == "Phó Thụy Lỗi" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Vào Mộng Cảnh train đi <color>");
			me.AnswerQestion(0)
			--me.AnswerQestion(0)
			break;
		end
	else
		if me.GetMapTemplateId() > 65540 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Vào Mộng Cảnh train đi <color>");
			if me.GetNpc().IsRideHorse() == 1 then
				Switch([[horse]]);
			end
			me.StartAutoPath(1608,3216)
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu đánh quái<color>");						
			--AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			me.AutoFight(1)			
		else		
			loadCTTK5 = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
			Ui.tbLogic.tbTimer:Close(nTimerId6);
			nTimerId6 = 0;	
			me.AutoFight(0)	
			end
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK6Switch();
]=];

function tbvCTTK:CTTK6Switch()
	if loadCTTK6 == 0 then
		loadCTTK6 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật rời Ải Gia tộc <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId7 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK6,self);
	else
		loadCTTK6 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự rời Ải Gia tộc <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId7);
		nTimerId7 = 0;
	end
end

function tbvCTTK:GoToCTTK6()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	--if string.find(GetMapNameFormId(nMyMapId),"Quán Trọ Long Môn(Mộng Cảnh)") then
	if me.GetMapTemplateId() > 65540 then
		if (pNpc.nTemplateId == 9594) or pNpc.szName == "Lối ra" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Rời khỏi Ải gia tộc <color>");
			me.AnswerQestion(0)
--			me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK6 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId7);
		nTimerId7 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK7Switch();
]=];

function tbvCTTK:CTTK7Switch()
	if loadCTTK7 == 0 then
		loadCTTK7 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Tự rời Lâu Lan Cổ Thành <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId8 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK7,self);
	else
		loadCTTK7 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự rời Lâu Lan Cổ Thành <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId8);
		nTimerId8 = 0;
	end
end

function tbvCTTK:GoToCTTK7()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() == 2013 then
		if (pNpc.nTemplateId == 7369) or pNpc.szName == "Xa Phu Lâu Lan" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Rời khỏi Lâu Lan Cổ Thành <color>");
			me.AnswerQestion(0)
--			me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK7 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId8);
		nTimerId8 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK8Switch();
]=];

function tbvCTTK:CTTK8Switch()
	if loadCTTK8 == 0 then
		loadCTTK8 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Tự rời Thời Quang Lệnh <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId9 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK8,self);
	else
		loadCTTK8 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự rời Thời Quang Lệnh <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId9);
		nTimerId9 = 0;
	end
end

function tbvCTTK:GoToCTTK8()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() > 65500 then --- 65797
		if (pNpc.nTemplateId == 9596) or pNpc.szName == "Cửa truyền tống" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Rời khỏi Thời Quang Lệnh <color>");
			me.AnswerQestion(6)
			me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK8 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId9);
		nTimerId9 = 0;			
		end
	end
end
------------
local szCmd = [=[
	Map.tbvCTTK:CTTK9Switch();
]=];

function tbvCTTK:CTTK9Switch()
	if loadCTTK9 == 0 then
		loadCTTK9 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật Đi Lộ Thông Ải Gia Tộc <color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId10 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK9,self);
	else
		loadCTTK9 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt Đi Lộ Thông Ải Gia Tộc <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId10);
		nTimerId10 = 0;
	end
end

function tbvCTTK:GoToCTTK9()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 200);
	for _, pNpc in ipairs(tbAroundNpc) do
	if me.GetMapTemplateId() > 65000 then  --2087
		if (pNpc.nTemplateId == 9595) or pNpc.szName == "Lộ Trình Phi" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Đi Lộ Thông đến boss cuối <color>");
			me.AnswerQestion(4)
--			me.AnswerQestion(0)
			break;
		end
	else	
		loadCTTK9 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId10);
		nTimerId10 = 0;			
		end
	end
end

local szCmd = [=[
	Map.tbvCTTK:CTTK10Switch();
]=];

function tbvCTTK:CTTK10Switch()
	if loadCTTK10 == 0 then
		loadCTTK10 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=Yellow>Bật rời Nhạc Luân<color>");
		me.Msg("<color=yellow>Tự bật<color>");
		nTimerId11 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToCTTK10,self);
	else
		loadCTTK10 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự rời Ngạc Luân <color>");
		me.Msg("<color=blue>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId11);
		nTimerId11 = 0;
	end
end

function tbvCTTK:GoToCTTK10()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	--if string.find(GetMapNameFormId(nMyMapId),"Quán Trọ Long Môn(Mộng Cảnh)") then
	if me.GetMapTemplateId() > 65000 then
		if (pNpc.nTemplateId == 9976) or pNpc.szName == "A Ngai" then
			AutoAi.SetTargetIndex(pNpc.nIndex);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Rời khỏi Ngạc Luân <color>");
			me.AnswerQestion(0)
--			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			break;
		end
	else	
		loadCTTK10 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tự động dừng chương trình !!!");
		Ui.tbLogic.tbTimer:Close(nTimerId11);
		nTimerId10 = 0;			
		end
	end
end
--------------------------------------end---------------------------------
local tCmd={"Map.tbvCTTK:CTTK1Switch()", "CTTK1", "", "Shift+5", "Shift+5", "CTTK1"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbvCTTK:CTTK2Switch()", "CTTK2", "", "Shift+6", "Shift+6", "CTTK2"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbvCTTK:CTTK3Switch()", "CTTK3", "", "Shift+7", "Shift+7", "CTTK3"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbvCTTK:CTTK4Switch()", "CTTK4", "", "Shift+8", "Shift+8", "CTTK4"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbvCTTK:CTTK5Switch()", "CTTK5", "", "Shift+9", "Shift+9", "CTTK5"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbvCTTK:CTTK6Switch()", "CTTK6", "", "Shift+3", "Shift+3", "CTTK6"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
		tCmd={"Map.tbvCTTK:CTTK7Switch()", "CTTK7", "", "Shift+0", "Shift+0", "CTTK7"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
