local tbAutoPath		= Ui.tbLogic.tbAutoPath or {};	-- 支持重载
Ui.tbLogic.tbAutoPath	= tbAutoPath;

------下面可以自己设置-----
local nKGZD = 0		--0改成1就所有跑点到后都不战斗
local nShangMa = 1	--1改0。那么官方寻路（大地图跑点）不上马，不建议修改！
local nTbClose = 1	--1寻路开始时关闭U面板，0就不关闭寻路面板

--------------------------

local tbFastRunSkill	= { 115, 132, 177, 230, 3016};	-- 所有加跑速主动辅助

local self = tbAutoPath
self.nowM = 0
self.M = 0

-- 当抵达目的地时
function tbAutoPath:OnFinished()
	me.Msg("安全抵达目的地。");
	
	local tbCallBack	= self.tbCallBack;
	
	self:StopGoto("Finish");
	
	if (tbCallBack and tbCallBack[1]) then
		Lib:CallBack(tbCallBack);
	end
	local bIsOpenAutoF = 0;
	local bIsInDialogNpc = 0;
	local nNpcId = tbCallBack[3];
	
	--针对npc寻路
	if type(nNpcId) == "number" then
		local tbNpcList = KNpc.GetAroundNpcList(me,5,16);
		for _, ptmp in pairs(tbNpcList) do
			if ptmp.nKind == 3 then
				bIsInDialogNpc = 1;
				break;
			end
		end
	end


	local nM, nX, nY = me.GetWorldPos();
	--不是对话npc或其他寻路情况
	if bIsInDialogNpc == 0 then
		local tbNpcList = KNpc.GetAroundNpcList(me,20);
		for _, ptmp in pairs(tbNpcList) do
			if ptmp.nKind == 0 then
				if nKGZD == 0 then
					bIsOpenAutoF = 1;
				end	
				if nM == 2316 and nX>1840 and nY<3150 then --孔雀岭
					bIsOpenAutoF = 0;
				end
				break;
			end
		end
	end

	if bIsOpenAutoF == 1 then
		local tbDate =Ui.tbLogic.tbAutoFightData:ShortKey();
		tbDate.nAutoFight = 1;
		tbDate.nPvpMode = 0;
		AutoAi:UpdateCfg(tbDate);
	end
end

tbAutoPath.GotoPos_Bak = tbAutoPath.GotoPos_Bak or tbAutoPath.GotoPos;
function tbAutoPath:GotoPos(tbPos, ...)
	if (UiManager:WindowVisible(Ui.UI_SUPERMAPLINK_UI) == 1) and nTbClose == 1 then
		UiManager:CloseWindow(Ui.UI_SUPERMAPLINK_UI)
	end

	self.nowM = me.nTemplateMapId
	self.M = tbPos.nMapId
	self:GotoPos_Bak(tbPos, ...)
	self:SSgo(tbPos)
end

-- 传送符超时无响应
function tbAutoPath:OnTimer_TransTimeOut()
	local nM, nX, nY = me.GetWorldPos();
	if (nM <= 0 or nX <= 0) then
		return;
	end
	if nM ~= self.nowM then
		self:CloseTimer();
		me.Msg("传送正常，网络较卡！");
	else
		me.Msg("传送符无法使用！！！");
		self:StopGoto("Failed");
	end
end

--上马加跑速
function tbAutoPath:SSgo(tbPos)
	local nM1, nX1, nY1 = me.GetWorldPos();
	-- 尝试上马
	if me.GetNpc().nIsRideHorse == 0 and me.GetEquip(Item.EQUIPPOS_HORSE) and nShangMa == 1 then -- 还没上马而且有坐骑
		if (((tbPos.nX-nX1)^2 + (tbPos.nY-nY1)^2) < 3500) and (nM1 == tbPos.nMapId) then
			--me.Msg("<color=yellow>很近无需上马<color>")
		else
			--Switch("horse");	-- 尝试上马（冷却等原因会导致上马失败）
			local function myhorse()
				if me.GetNpc().nIsRideHorse == 1 or me.nAutoFightState == 1 or self:IsMoving() == 0 then
					return 0
				end
				--Switch("horse");
				return 0
			end
			Ui.tbLogic.tbTimer:Register(50, myhorse);
		end
	end

	-- 尝试加跑速
	local function myclose()
		if nM1 <= 0 or nX1 <= 0 or UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 or self:IsMoving() == 0 then
			return
		end
		for _, nSkillId in ipairs(tbFastRunSkill) do
			if (me.CanCastSkill(nSkillId) == 1) then	-- 可以释放这个技能
				local _, _, nRestTime	= me.GetSkillState(nSkillId);
				if (not nRestTime or nRestTime < Env.GAME_FPS) then
					UseSkill(nSkillId)
				end
				break;
			end
		end
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(20, myclose);
end

-- 功能：是否在移动
function tbAutoPath:IsMoving()
	local nRunning = 0;
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		nRunning = 1;
	end
	return nRunning;
end