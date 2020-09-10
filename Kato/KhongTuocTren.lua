-----Edited by Quốc Huy-----

local self = KhongTuocTren;
local KhongTuocTren	= Map.KhongTuocTren or {}; 
Map.KhongTuocTren	= KhongTuocTren;
local Switch=0
local sTimers = 0
local Dem = 0


function KhongTuocTren.OnTimer()
	if Switch == 0 then	return  end
		--me.Msg("Dem: "..Dem)
		--me.Msg("m: "..m)
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	
	if Dem == 0 then 
		if nMyPosX==1868 and nMyPosY==3007 then
			Dem = 1 
			return Env.GAME_FPS * 1
		else
			--Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1868,3007"});
			me.StartAutoPath(1868,3007)
		end
	end
	if Dem == 1 then 
		Map.tbSuperMapLink:move(1872,3002)
		Dem = 2
		return Env.GAME_FPS * 1	
	end
	if Dem == 2 then
		KhongTuocTren:Switch();
	end
end



function KhongTuocTren:Switch()	
	if Switch == 0 then	
	   Switch = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu đi Server trên<color>");
		sTimers = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,KhongTuocTren.OnTimer); --2
	else
		Dem,Switch,sTimers = 0,0,0
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Stop<color>");
		Ui.tbLogic.tbTimer:Close(sTimers);
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

--local tCmd={ "Map.KhongTuocTren:Switch()", "Switch", "", "", "", "Switch"};
 --      AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--       UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n

--CTC: 1187,1189,3583	7135 Tiệm thuốc Nhận thuốc miễn phí 