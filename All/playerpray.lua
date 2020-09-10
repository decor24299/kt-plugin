local uiPlayerPray = Ui(Ui.UI_PLAYERPRAY)
local fastClick = 0
local nFirst    = 0
local nTimerId  = 0
local PRAY_METAL = 7
local PRAY_WOOD  = 3
local PRAY_WATER = 7
local PRAY_FIRE  = 3
local PRAY_EARTH = 5

local PPStart = 2

uiPlayerPray.PRAY_OFFSET_LIST = {
			[1] = {0.5},
			[2] = {0.3},
			[3] = {0.1},
			[4] = {0},
			[5] = {-0.1},
			[6] = {-0.3},
			[7] = {-0.5},
}

local szPath = "\\user\\"

function uiPlayerPray:UpdateControlButtonTxt()
	local nAllElement = me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_SAVEELEMENT);
	local szMsg	= ""
	if (self.FLAG_HANDMOVE == 1) then
		szMsg = "Dừng"
	else
		local nPrayFlag = Task.tbPlayerPray:CheckAllowPray(me);
		if (nPrayFlag == 0) then
			szMsg = "Bắt đầu";
			local tbElement		= self:GetPrayResultElement();
			local tbAward		= Task.tbPlayerPray:GetAward(me, tbElement);
			local nInDirFlag	= me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_INDIRAWARDFLAG);
			if (#tbAward <= 0) then
				if (nAllElement > 0) then
					szMsg = "Tiếp tục"
				end
			else
				if (nInDirFlag >= 1) then
					szMsg = "Kết thúc"
					if PPStart == 2 then
						me.CallServerScript({"ApplyGetPrayAward"})
					end
					AutoAi:CloseUi(Ui.UI_PLAYERPRAY)
				end
			end
		elseif (nPrayFlag > 0) then
			szMsg = "Kết thúc"
			if PPStart == 2 then
				me.CallServerScript({"ApplyGetPrayAward"})
			end
			AutoAi:CloseUi(Ui.UI_PLAYERPRAY)
		end
	end	
	Btn_SetTxt(self.UIGROUP, self.BTN_CONTROL, szMsg);
	if PPStart == 0 then
		return
	end
	if (szMsg == "Bắt đầu") then
		nFirst = 1
	elseif (szMsg == "Tiếp tục") then
		uiPlayerPray:SetHandMoveState()
	elseif (szMsg == "Dừng") then
		local pTime = self:GetPrayTime()
		if (fastClick == 1) or (nFirst == 1) or (pTime <= 0) then
			self:StopPray()
			nFirst = 0
			me.Msg("Dừng ngay")
		else
			-- nTimerId = Ui.tbLogic.tbTimer:Register(pTime * Env.GAME_FPS, self.StopPray, self)
			-- me.Msg("Đang chờ <color=yellow>"..string.format("%.1f", pTime * Env.GAME_FPS).."<color> giây ngừng quay.");
			nTimerId = Ui.tbLogic.tbTimer:Register(pTime * Env.GAME_FPS, self.StopPray)
			me.Msg("Đang chờ "..pTime.." giây ngừng quay.")
		end
	end
end

function uiPlayerPray:GetLastPrayElement()
	local result = 0
	for i = 1, 5 do
		local nElement = Task.tbPlayerPray:GetPrayElement(me, i)
		if (nElement <= 0) then
			break
		end
		result = nElement
	end		
	return result
end

function uiPlayerPray:GetCurPray()
	if nFirst == 1 then
		return 1
	end
	local result = 0
	for i = 1, 5 do
		local nElement = Task.tbPlayerPray:GetPrayElement(me, i)
		if (nElement <= 0) then
			result = i
			break
		end
	end		
	return result
end

function uiPlayerPray:GetPrayTime()
	local nCurPray = self:GetCurPray()
	local pTime = -1
	local pTabFile = KIo.OpenTabFile(szPath.."Pray.txt")
	if pTabFile then
		local nWidth = pTabFile.GetWidth()
		if nCurPray <= nWidth then
			pTime = tonumber(pTabFile.GetStr(1, nCurPray))
		end
	end
	KIo.CloseTabFile(pTabFile)
	local szMsg = ""
	local result = self:GetLastPrayElement()
	if (result == 1) then
		szMsg = "orange>Kim"
	elseif (result == 2) then
		szMsg = "green>Mộc"
	elseif (result == 3) then
		szMsg = "blue>Thủy"
	elseif (result == 4) then
		szMsg = "salmon>Hỏa"
	else
		szMsg = "wheat>Thổ"
	end
	if pTime < 0 then
		if (result == 1) then
			pTime = PRAY_METAL
		elseif (result == 2) then
			pTime = PRAY_WOOD
		elseif (result == 3) then
			pTime = PRAY_WATER
		elseif (result == 4) then
			pTime = PRAY_FIRE
		else
			pTime = PRAY_EARTH
		end
		local nResultPoint = self.nEndPoint
		local nResultMod   = nResultPoint - math.floor(nResultPoint/7) * 7
		if (nResultMod == 0) then
			nResultMod = 7
		end
		local nPrayOffset  = 0
		-- me.Msg("ResultPoint:"..nResultPoint);
		nPrayOffset = self.PRAY_OFFSET_LIST[nResultMod][1]
		pTime = pTime + nPrayOffset
	end
	if (nFirst == 0) then
		me.Msg("Kết quả: <color="..szMsg.."<color>")
	end
	return pTime
end

function uiPlayerPray:StopPray()
	uiPlayerPray:SetHandMoveState()
	if (nTimerId ~= 0) then
		Ui.tbLogic.tbTimer:Close(nTimerId)
		nTimerId = 0
	end
end

function uiPlayerPray:Switch(nStatus)
	if nStatus then
		if PPStart == nStatus then
			return
		end
		PPStart = nStatus
	else
		PPStart = PPStart + 1
	end
	if PPStart > 2 then
		PPStart = 0
	end
	if PPStart == 0 then
		me.Msg("<bclr=blue><color=White>Tắt tự quay chúc phúc [Ctrl+5]<color>")
	elseif PPStart == 1 then
		me.Msg("<bclr=red><color=yellow>Bật tự quay chúc phúc [Ctrl+5]<color>")
	elseif PPStart == 2 then
		SysMsg("<bclr=0,0,200><color=white>Bật tự động quay và nhận thưởng<color><bclr>")
	end
end

local szCmd = [=[
	Ui(Ui.UI_PLAYERPRAY):Switch();
]=];
UiShortcutAlias:AddAlias("GM_S5", szCmd);