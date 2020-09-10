-----Edited by Quốc Huy-----

local self = KhongTuocDuoi;
local KhongTuocDuoi	= Map.KhongTuocDuoi or {}; 
Map.KhongTuocDuoi	= KhongTuocDuoi;
local Switch=0
local sTimers = 0
local Dem = 0

function KhongTuocDuoi.OnTimer()
	if Switch == 0 then	return  end
		--me.Msg("Dem: "..Dem)
		--me.Msg("m: "..m)
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if Dem == 0 then
		if nMyPosX==1678 and nMyPosY==3647 then 
			Dem = 1 
			return Env.GAME_FPS * 1
		else
			--Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1678,3647"});
			me.StartAutoPath(1678,3647);
		end	
	end
	if Dem == 1 then 
		Map.tbSuperMapLink:move(1674,3651)
		Dem = 2
		return Env.GAME_FPS * 1
	end
	
	if Dem == 2 then	
		KhongTuocDuoi:Switch();
	end
end



function KhongTuocDuoi:Switch()	
	if Switch == 0 then	
	   Switch = 1
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu đi server dưới<color>");
		sTimers = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1,18,KhongTuocDuoi.OnTimer); --2
	else
		Dem,Switch,sTimers = 0,0,0
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Stop<color>");
		Ui.tbLogic.tbTimer:Close(sTimers);
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

--local tCmd={ "Map.KhongTuocDuoi:Switch()", "Switch", "", "", "", "Switch"};
 --      AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
  --     UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--alt+n



--CTC: 1187,1189,3583	7135 Tiệm thuốc Nhận thuốc miễn phí 