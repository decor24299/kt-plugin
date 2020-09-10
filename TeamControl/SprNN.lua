local DacDuyetPhuong = Ui:GetClass("DacDuyetPhuong");
local uiFightAfter = Ui:GetClass("fightafter");
local NhacNho = Ui:GetClass("NhacNho");

DacDuyetPhuong.state = 0
local Timer = 0
local loadgoham = 0
local Timer_2 = 0

NhacNho.state = 0;
local TimerIn = 0;


local uiSayPanel = Ui(Ui.UI_SAYPANEL)
DacDuyetPhuong.Say_bak = DacDuyetPhuong.Say_bak or uiSayPanel.OnOpen

function uiSayPanel:OnOpen(tbParam)
	DacDuyetPhuong.Say_bak(uiSayPanel,tbParam)
	if DacDuyetPhuong.state == 0 then return end
	for i = 1,table.getn(tbParam[2]) do
		me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Hôm nay,") then
			me.AnswerQestion(i-1)		
		else me.AnswerQestion(i)
		end
	end
end

function DacDuyetPhuong:State()
	if DacDuyetPhuong.state == 0 then
		me.Msg("<color=yellow>Mở auto !!!")
		Timer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,DacDuyetPhuong.OnTimer);
		DacDuyetPhuong.state = 1
	else
		me.Msg("<color=pink>Tắt auto !!!")
		DacDuyetPhuong.state = 0
		Ui.tbLogic.tbTimer:Close(Timer)
		Timer = 0
	end
end

uiFightAfter.OnButtonClick_Bak = uiFightAfter.OnButtonClick;

function DacDuyetPhuong.OnTimer()	
	if DacDuyetPhuong.state == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL)
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự động dừng chương trình [OKE]");
		me.Msg("<color=yellow>Chức năng này chỉ hoạt động trong map nhiệm vụ<color>")
		me.Msg("<color=pink>Auto Tắt !!!")
		Ui.tbLogic.tbTimer:Close(Timer)
		return 
	end	
	if (me.GetMapTemplateId() > 1722 and me.GetMapTemplateId() < 1737) then
		if me.GetItemCountInBags(tbItem) ~= nil then		
			local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
			local tbAroundNpc	= KNpc.GetAroundNpcList(me, 100);
			for _, pNpc in ipairs(tbAroundNpc) do		
				if (pNpc.nTemplateId == 7015) or pNpc.szName=="Tưởng Nhất Bình" then					
					AutoAi.SetTargetIndex(pNpc.nIndex)								
				end
			end
		end
		if UiManager:WindowVisible(Ui.UI_FIGHTAFTER) == 1 then
			Ui(Ui.UI_FIGHTAFTER):OnButtonClick("BtnAward")
			UiManager:CloseWindow(Ui.UI_FIGHTAFTER);
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		end
	else
		DacDuyetPhuong.state = 0;
	end	
end
-----------------------------------------------------------------------
function DacDuyetPhuong:GoHamSwitch()
	if loadgoham == 0 then
		loadgoham = 1;		
		me.Msg("<color=yellow>Bật Vào Hầm !!!<color>");
		Timer_2 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.2,self.GoHamOn,self);
	else
		loadgoham = 0;
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		me.Msg("<color=pink>Tắt tự Vào Hầm !!!<color>");
		Ui.tbLogic.tbTimer:Close(Timer_2);
		Timer_2 = 0;
	end
end

function DacDuyetPhuong:GoHamOn()
	if loadgoham == 0 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		me.Msg("<color=pink>Auto tắt !!!<color>");
		Ui.tbLogic.tbTimer:Close(Timer_2);
		Timer_2 = 0;
		return;
	end
	local nMyMapId	= me.GetMapTemplateId();
	if me.GetMapTemplateId() > 22 and me.GetMapTemplateId() < 30 then		
		SendChannelMsg("NearBy","Vào Hầm chơi đánh NPC !!!<pic=101>");	
	local QuanQuanNhu = Ui(Ui.UI_HOTRO).TimNPC_TEN("Quan Quân Nhu (nghĩa quân)")
		if not QuanQuanNhu then	
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2711);
				if Xnpc then
					me.StartAutoPath(Xnpc,Ynpc)
				end
			return
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(3);
			me.AnswerQestion(0);
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		else
			AutoAi.SetTargetIndex(QuanQuanNhu.nIndex)
		end
		return;
	else		
		me.Msg("<color=pink>Chỉ có thể tự vào khi ở Thành thị<color>");
		loadgoham = 0;
	end
end

function DacDuyetPhuong:TuongNhatBinh()
	if DacDuyetPhuong.state == 0 then
		DacDuyetPhuong:State()
	end
end

local szCmd = [=[
	Ui(Ui.UI_NHACNHO):State();
]=];
--UiShortcutAlias:AddAlias("GM_C7", szCmd);

function NhacNho:State()
	if NhacNho.state == 0 then
		NhacNho.state = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bật <bclr=red><color=yellow>xóa")
		me.Msg("<color=yellow>Bật xóa<color>");
		TimerIn = Ui.tbLogic.tbTimer:Register(35 * Env.GAME_FPS,NhacNho.OnNhacNho);
	else
		NhacNho.state = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt <bclr=blue><color=white>xóa")
		me.Msg("<color=green>Ngừng xóa<color>");
		Ui.tbLogic.tbTimer:Close(TimerIn);
		TimerIn = 0;
	end
end

function NhacNho.OnNhacNho()
	if UiManager:SwitchWindow(Ui.UI_MSGINFO) == 1 then
		UiManager:CloseWindow(Ui.UI_MSGINFO);
	end
	
end

function NhacNho.NhacNho()
	if NhacNho.state == 0 then
		NhacNho:State()
	end
end

-----------------------------------------------------------------------

Ui:RegisterNewUiWindow("UI_DACDUYETPHUONG", "DacDuyetPhuong", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
Ui:RegisterNewUiWindow("UI_NHACNHO", "NhacNho", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_DACDUYETPHUONG):State()", "DacDuyetPhuong", "", "", "", "dmmm"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	tCmd={"Ui(Ui.UI_DACDUYETPHUONG):GoHamSwitch()", "autovaoham", "", "", "", "dmmm"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);