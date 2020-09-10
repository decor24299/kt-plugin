-- ====================== 文件信息 ======================
-- 文 件 名　：AutoCastLeftSkill.lua
-- 创 建 者　：蓬莱岛主
-- 创建时间　：2009-10-09
-- 功    能  ：自动释放左键技能
-- 最近修改  ：※无痕※
-- 修改时间　：2010-01-23
-- 注意事项　：请保留以上说明，以体现对原作者和修改者的尊重
-- ======================================================

local uiCheckTeacher = Ui(Ui.UI_CHECKTEACHER);


local nCastState = 0;
local nCastTimerId = 0;
local nCastTime = 0.3;

function uiCheckTeacher:Switch()
	if nCastState == 0 then
		nCastState = 1;
		me.Msg("<color=green>bat<color>");
		assert(nCastTimerId == 0);
		nCastTimerId = Timer:Register(nCastTime * Env.GAME_FPS, self.AutoCast, self);
	else
		nCastState = 0;
		me.Msg("<color=yellow>tat<color>");
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
	end
end

function uiCheckTeacher:AutoCast()
	if (nCastTimerId ~= 0) then
		UseSkill(me.nLeftSkill);
	end
end

