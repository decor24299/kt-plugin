

local self = AutoXuyenSon

local tbAutoXuyenSon = Map.tbAutoXuyenSon or {};
Map.tbAutoXuyenSon = tbAutoXuyenSon;

local tbItem = Item:GetClass("kingame_qianxiang")

local loadMaXS = 0
local nTimerMa = 0

local loadMrXS = 0
local nTimerMr = 0

--local loadRgt = 0
--local nTimerGt = 0

local szCmd = [=[
	Map.tbAutoXuyenSon:MaXSSwitch();
]=];

function tbAutoXuyenSon:MaXSSwitch()
	if loadMaXS == 0 then
		loadMaXS = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tự vào Ải Gia tộc <color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerMa = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS,self.GoToMaXS,self);
	else
		loadMaXS = 0
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt Tự vào Ải Gia tộc <color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerMa);
		nTimerMa = 0;
	end
end

function tbAutoXuyenSon:GoToMaXS()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 300);
	for _, pNpc in ipairs(tbAroundNpc) do
		if me.GetMapTemplateId() < 65500 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			me.Msg("<color=pink>Vị trí của bạn không đúng Auto sẽ ngưng<color>");
			loadMaXS = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
			Ui.tbLogic.tbTimer:Close(nTimerMa);
			nTimerMa = 0;			
		else
			if (pNpc.szName=="Mã Xuyên Sơn") then 				
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự vào Ải Gia tộc bắt đầu <color>");
				AutoAi.SetTargetIndex(pNpc.nIndex);
				me.AnswerQestion(0)
				me.AnswerQestion(0)
				break;
			end		
		end			
	end
end	

--------

local szCmd = [=[
	Map.tbAutoXuyenSon:MrXSSwitch();
]=];

function tbAutoXuyenSon:MrXSSwitch()
	if loadMrXS == 0 then
		loadMrXS = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tự nhận rương Ải Gia tộc <color>");
		me.Msg("<color=yellow>Tụ bật<color>");
		nTimerMr = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS,self.GoToMrXS,self);
	else
		loadMrXS = 0
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt Tự nhận rương Ải Gia tộc <color>");
		me.Msg("<color=yellow>Tự tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerMr);
		nTimerMr = 0;		
		UiManager:CloseWindow(Ui.UI_SAYPANEL);			
	end
end

function tbAutoXuyenSon:GoToMrXS()	
	if me.GetItemCountInBags(18,1,1332,1) == 0 then				
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
		me.Msg("<color=pink>Không mang túi tiền làm sao mà đổi<color>");
		loadMrXS = 0
		Ui.tbLogic.tbTimer:Close(nTimerMr);
		nTimerMr = 0;	
	elseif me.GetItemCountInBags(18,1,1332,1) == 1 then		
		local nCount = me.GetTask(KinGame2.TASK_GROUP_ID, KinGame2.TASK_GOLD_COIN); --đếm số lượng Đồng tiền cổ
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);		
		for _, pNpc in ipairs(tbAroundNpc) do
			if nCount < 100 then --giới hạn đổi
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
				me.Msg("<color=pink>Đồng tiền cổ không đủ<color>");
				loadMrXS = 0
				Ui.tbLogic.tbTimer:Close(nTimerMr);
				nTimerMr = 0;
				UiManager:CloseWindow(Ui.UI_SAYPANEL);				
			elseif me.GetMapTemplateId() == 23 or me.GetMapTemplateId() == 24 or me.GetMapTemplateId() == 25 or me.GetMapTemplateId() == 26 or me.GetMapTemplateId() == 27 or me.GetMapTemplateId() == 28 or me.GetMapTemplateId() == 29 then 				
				if (pNpc.szName=="Mã Xuyên Sơn") then				
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự nhận rương Ải Gia tộc bắt đầu <color>");
					--AutoAi.SetTargetIndex(pNpc.nIndex);				
					--me.AnswerQestion(2)
					--me.AnswerQestion(0)]]
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2955,Ải gia tộc,4,1"});
					break;
				end
			elseif me.GetMapTemplateId() > 65500 then
				if (pNpc.szName=="Mã Xuyên Sơn") then				
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Tự nhận rương Ải Gia tộc bắt đầu <color>");
					AutoAi.SetTargetIndex(pNpc.nIndex);				
					me.AnswerQestion(3)
					me.AnswerQestion(0)
					--Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",65744,2955,Ta muốn dùng Tiền đồng tiền cổ đổi phần thưởng,1"});
					break;
				end
			else
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình !!!");
				me.Msg("<color=pink>Vị trí của bạn không đúng<color>");
				loadMrXS = 0
				Ui.tbLogic.tbTimer:Close(nTimerMr);
				nTimerMr = 0;					
			end		
		end 			
	end
end	

-------------------------------------------end---------------------------------------------------

local tCmd={"Map.tbAutoXuyenSon:MaXSSwitch()", "MaXS", "", "Shift+1", "Shift+1", "MaXS"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
local tCmd={"Map.tbAutoXuyenSon:MrXSSwitch()", "MrXS", "", "Shift+2", "Shift+2", "MaXS"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
