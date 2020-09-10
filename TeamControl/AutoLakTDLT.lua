local AutoLAKLT = Ui:GetClass("AutoLAKLT")

local n = 1-- Số lượng rương thuốc muốn nhận
AutoLAKLT.state = 0
local sTimer = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)

function AutoLAKLT:State()	
	if AutoLAKLT.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 3,18,AutoLAKLT.Timers);
		--me.Msg("<color=white>Nhận quân nhu Lãnh thổ:<color=green> Bắt đầu");
		UiManager:OpenWindow("UI_INFOBOARD", "<color=green>Bật<color=yellow> tự nhận Lak TĐLT<color>");
		--Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Bật tự động <color><bclr> Bắt đầu");
		AutoLAKLT.state = 1
	else
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
		end		
		AutoLAKLT.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		--me.Msg("<color=white>Nhận quân nhu Lãnh thổ:<color> Kết thúc");
		UiManager:OpenWindow("UI_INFOBOARD", "<color=red>Tắt<color=yellow> tự nhận Lak TĐLT<color>");
		--Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=White>Tắt tự động<color><bclr> Kết thúc");
		sTimer = 0		
	end	
end

function AutoLAKLT.GioNhanQuanNhu()
    local nTime = tonumber(GetLocalDate("%H%M"));
	if nTime >= 2000 and nTime < 2130 then 
		return true      
	else
		me.Msg("<color=white>Thông báo:<color> TĐLT chỉ diễn ra từ 20h00 - 21h30 thứ 6 & CN hàng tuần")
		return false        
    end
end

function AutoLAKLT.NgayNhanQuanNhu()
    local nWeekDay	= tonumber(os.date("%w", nNowDate));	
	if nWeekDay == 5 or nWeekDay == 0 then 
		return true
    else
		me.Msg("<color=white>Thông báo:<color> TĐLT chỉ diễn ra từ 20h00 - 21h30 thứ 6 & CN hàng tuần")
		return false        
    end
end

function AutoLAKLT.Soluongruong()
	if (me.GetItemCountInBags(18,1,321,1) < n) and (me.GetItemCountInBags(18,1,322,2) < n) and (me.GetItemCountInBags(18,1,323,3) < n) then
		return true
	else
		--me.Msg("<color=lightgreen>Trong túi có rồi khỏi lấy thêm !!!")
		return false
	end
end

function AutoLAKLT.Timers()	
	if AutoLAKLT.Soluongruong() then
		local LTT = AutoLAKLT.TimNPC_TEN("Quan Lãnh Thổ")
		if LTT then		
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();				
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Quân nhu Lãnh thổ chiến") then
						me.Msg(tostring("<color=white>Chọn: <bclr><color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1.5, me.AnswerQestion(i-1);
					end					
				end
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận quân nhu") then
						me.Msg(tostring("<color=white>Chọn: <bclr><color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1.5, me.AnswerQestion(i-1);
					end					
				end
				if string.find(szQuestion, "Bạn còn được nhận:") then
					for i = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[i],"Nhận Hành Quân Đơn") then
							me.Msg(tostring("<color=white>Chọn: <bclr><color>"..tbAnswers[i]))
							return Env.GAME_FPS * 1.5, me.AnswerQestion(i-1);
						end	
					end
				elseif string.find(szQuestion, "Bạn còn được nhận:") then
					for i = 1,table.getn(tbAnswers) do
						if not string.find(tbAnswers[i],"Nhận Hành Quân Đơn") then
							me.Msg("Đã nhận hết Lak")
							return Env.GAME_FPS * 0.5, AutoLAKLT.Stop();
						end	
					end
				elseif string.find(szQuestion, "Bạn đã nhận xong tất cả quân nhu.") then
					for i = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[i],"Kết thúc đối thoại") then
							me.Msg("Đã nhận hết Lak")
							return Env.GAME_FPS * 0.5, AutoLAKLT.Stop();
						end
					end
				end
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Xác định nhận") then
						me.Msg(tostring("<color=white>Chọn: <bclr><color>"..tbAnswers[i]))
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1), AutoLAKLT.CloseWindows();
					end
				end
			else
				AutoAi.SetTargetIndex(LTT.nIndex)		
			end
		else
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),3406);
			if Xnpc and Xnpc ~= 0 then
				AutoLAKLT.GoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
			else
				AutoLAKLT.GoTo(23,1538,3233)				
			end
			return Env.GAME_FPS * 0.5;
		end
	else
		return Env.GAME_FPS * 0.5, AutoLAKLT.Stop();
	end
	return Env.GAME_FPS * 0.5;
end

---------hết-------------
function AutoLAKLT.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
end

function AutoLAKLT.StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end	
end

function AutoLAKLT.TimNPC_TEN(sName)
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc and pNpc.szName == sName then
			return pNpc
		end
	end
end
local nLastMapId = 0
local nLastMapX = 0 
local nLastMapY = 0
function AutoLAKLT.GoTo(M,X,Y)
	AutoLAKLT.CloseWindows()
	if me.nAutoFightState == 1 then
		AutoLAKLT.StopAutoFight()
	end
	if me.GetNpc().nIsRideHorse == 0 then
		--me.Msg("<color=pink>Tự động lên ngựa")
		Switch("horse")
	end	
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	if nMapId == M and nMyPosX == X and nMyPosY == Y then
		--me.Msg("Đến rồi chạy chi nữa")
		return
	end
	if nLastMapId ~= M or nLastMapX ~= X or nLastMapY ~= Y then
		--me.Msg("<bclr=blue><color=white>Di chuyển")
		nLastMapId = M
		nLastMapX = X
		nLastMapY = Y
	else
		if me.GetNpc().nDoing == 3 then
			return
		end
	end

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	
	local tbPos = {}
	tbPos.nMapId = M
	tbPos.nX = X
	tbPos.nY = Y
	Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
end

function AutoLAKLT.Stop()
	if AutoLAKLT.state == 1 then		
		AutoLAKLT:State()		
	else
		--me.Msg("<bclr=pink><color=white>Muốn chạy auto tự hãy Ấn [Phím tắt] để bật!!!")
	end	
end

Ui:RegisterNewUiWindow("UI_LAKLANHTHO", "AutoLAKLT", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local tCmd={"Ui(Ui.UI_LAKLANHTHO):State()", "LAKTDLT", "", "", "", "LAKTDLT"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);