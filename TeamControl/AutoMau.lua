--Lấy máu: TDLT, CTC--
local self = AutoMau

local tbAutoMau = Map.tbAutoMau or {};
Map.tbAutoMau = tbAutoMau;

local n = 2

local loadLayMau1 = 0
local loadLayMau2 = 0
local loadLayMau3 = 0

local nTimerM1 = 0
local nTimerM2 = 0
local nTimerM3 = 0

local szCmd = [=[
	Map.tbAutoMau:LayMau1Switch();
]=];

function tbAutoMau:LayMau1Switch()
	if loadLayMau1 == 0 then
		loadLayMau1 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật - Tự lấy rương máu Công Thành Chiến<color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerM1 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToLayMau1,self);
	else
		loadLayMau1 = 0;
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt - Tự lấy rương máu Công Thành Chiến<color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerM1);
		nTimerM1 = 0;
	end
end

function tbAutoMau:GoToLayMau1()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetItemCountInBags(18,1,20111,1) < n) then
		if (me.GetMapTemplateId() < 1811) and (me.GetMapTemplateId() > 1831) then
			--me.Msg("<color=pink>Đây có phải là nơi có máu đâu<color>");
			loadLayMau1 = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
			Ui.tbLogic.tbTimer:Close(nTimerM1);
			nTimerM1 = 0;		
		else
			if  (pNpc.szName=="Tiệm thuốc") or (pNpc.nTemplateId == 7135) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự lấy rương máu Công Thành Chiến<color>");
				me.AnswerQestion(0)
				me.AnswerQestion(0)
				break;
			end
		end
	else
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		--me.Msg("<color=pink>Nhận rương máu hoàn thành<color>");
		loadLayMau1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		me.Msg("<color=pink>Nhận rương máu thành công<color>");
		SendChannelMsg("NearBy", "<color=pink>Lấy máu xong rồi, chiến thôi<pic=82>");
		Ui.tbLogic.tbTimer:Close(nTimerM1);
		nTimerM1 = 0;
		end
	end	
end 

local szCmd = [=[
	Map.tbAutoMau:LayMau2Switch();
]=];

function tbAutoMau:LayMau2Switch()
	if loadLayMau2 == 0 then
		loadLayMau2 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tự lấy rương máu Lãnh thổ <color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerM2 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToLayMau2,self);
	else
		loadLayMau2 = 0;
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt Tự lấy rương máu Lãnh thổ <color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerM2);
		nTimerM2 = 0;
	end
end

function tbAutoMau:GoToLayMau2()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 500);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetItemCountInBags(18,1,1783,4) < n) and (me.GetItemCountInBags(18,1,1784,4) < n) and (me.GetItemCountInBags(18,1,1785,4) < n) then
		if me.GetMapTemplateId() < 23 or  me.GetMapTemplateId() > 29 then
			me.Msg("<color=pink>Đây có phải là nơi có máu đâu<color>");
			loadLayMau2 = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
			Ui.tbLogic.tbTimer:Close(nTimerM2);
			nTimerM2 = 0;			
		else
			if  (pNpc.szName=="Quan Lãnh Thổ") or (pNpc.nTemplateId == 3406) then
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự lấy rương máu Lãnh thổ bắt đầu<color>");
				--AutoAi.SetTargetIndex(pNpc.nIndex);
				--me.AnswerQestion(0)
				--me.AnswerQestion(0)
				--me.AnswerQestion(0)
				--me.AnswerQestion(0)
				--me.AnswerQestion(0)
				if  me.nFaction ~= 9 then
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406,Quân nhu Lãnh thổ chiến,1,1,1,1"});
					--me.AnswerQestion(0)
					--me.AnswerQestion(0)
					--me.AnswerQestion(0)
				break;
				else
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3406,Quân nhu Lãnh thổ chiến,2,3"});
					--me.AnswerQestion(2)
					--me.AnswerQestion(0)
					--me.AnswerQestion(0)
				end
			end
		end	
	else
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		loadLayMau2 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		me.Msg("<color=pink>Nhận rương máu thành công<color>");
		SendChannelMsg("NearBy", "<color=pink>Lấy máu xong rồi, chiến thôi<pic=82>");
		Ui.tbLogic.tbTimer:Close(nTimerM2);
		nTimerM2 = 0;			
		end
	end	
end 

local szCmd = [=[
	Map.tbAutoMau:LayMau3Switch();
]=];

function tbAutoMau:LayMau3Switch()
	if loadLayMau3 == 0 then
		loadLayMau3 = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật - Tự lấy Quân lệnh<color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerM3 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.GoToLayMau3,self);
	else
		loadLayMau3 = 0;
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt - Tự lấy Quân lệnh<color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerM3);
		nTimerM3 = 0;
	end
end

function tbAutoMau:GoToLayMau3()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
	if (me.GetItemCountInBags(18,1,1673,1) < 1) and  (me.GetItemCountInBags(18,1,1674,1) < 1) then
		if (me.GetMapTemplateId() == 2148) or (me.GetMapTemplateId() == 2150) then
			if  (pNpc.szName=="Ba Đồ") or (pNpc.nTemplateId == 10048) or (pNpc.nTemplateId == 10051) then
				AutoAi.SetTargetIndex(pNpc.nIndex);
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự lấy Quân Lệnh<color>");
				me.AnswerQestion(0)
				--me.AnswerQestion(0)
				break;
			end
		else	
			loadLayMau3 = 0;
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
			me.Msg("<color=pink>Đây có phải là bản đồ Khắc Di Môn đâu <color>");
			Ui.tbLogic.tbTimer:Close(nTimerM3);
			nTimerM3 = 0;					
		end
	else
		loadLayMau3 = 0;
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		SendChannelMsg("NearBy", "<color=pink>Lấy Quân lệnh xong rồi<pic=82>");
		Ui.tbLogic.tbTimer:Close(nTimerM3);
		nTimerM3 = 0;
	end
	end	
end
-------------------------------------------end---------------------------------------------------
local --tCmd={"Map.tbAutoMau:LayMau1Switch()", "LayMau1", "", "Shift+G", "Shift+G", "LayMau1"};
	--AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	--UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
	tCmd={"Map.tbAutoMau:LayMau2Switch()", "LayMau2", "", "Shift+4", "Shift+4", "LayMau2"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);