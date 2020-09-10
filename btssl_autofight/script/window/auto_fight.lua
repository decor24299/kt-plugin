--------------------Edited by Quốc Huy--------------
if not MODULE_GAMECLIENT then
	return
end

local self = AutoAi;
Require("\\interface2\\btssl_autofight\\script\\window\\autofight_setting.lua");

-- local OpenJiuXiang = 1;  -- ÊÇ·ñ¿ª¾ÆÏä
-- self.bAutoOpenXiulian = 1;
local HuoKai = 0;
local nKpink = 0;
local nCanU = 0;


self.nX3=3;  -- 			
self.nY3=3;  -- 			
self.nJX_Time=20; --  	
self.nTalk_on=0;	--   
self.Move_TimeOut=10; -- 
---------------------
self.nEat_Lock=0;		
self.nEat_Red=50;  		
self.nEat_Blue=20;   
self.nEat_Food=45;    
self.life_left = 50;--
self.nCounter = 0;--
self.nLastLife = 0;--
self.nLastMana = 0;--
self.Buff_left = nBuffRet;
self.attack_skill = {}; --
self.auto_fight_pos = {[1] = {}, [2] = {}};	--
self.attack_point = 1;	--
self.auto_pos_index = 0; --
self.pick_item_value = 0;--
self.eat_life_time = 0;--
self.eat_mana_time = 0;--
self.auto_move_counter = 0;--
self.sleep_counter = 0;--
self.no_pick_commonitem = 0;--
self.no_mana = 0;--
self.ncurmana = 1000;--
self.TimeLastFire = 0;--
self.TimeLastRead = 0;--
self.TimeLastWine = 0;--
self.WineUsed = 0;--
self.bAcceptJoinTeam = 0;--
self.bAutoRepair = 0;--
self.nPvpMode = 0;--
AutoAi.LastRepairTime = 0;--
AutoAi.bAutoDrinkWine = 0;--
AutoAi.bAutoOPXLZ = 0;
AutoAi.bReleaseUiState = 0;--
self.EnhancePick	=0;--
self.ObjHuo	=0;--
self.NoCai	=0;
self.fdyx	=0;
self.fdwx	=0;
self.ds	=0;--
self.ds_move=0;--
self.nTime = 5;
self.nRelayTime1 =60;
self.nRelayTime2 =60;
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;
self.nSec6=0;
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0;
self.nYe6=0;
self.nX1=0;
self.nY1=0;
self.TimeLost=0;--
self.IsRead=0;--
self.BookNum=0;--
self.Move_Time=0;--
self.read_now=0;--
local tbBuffSkill	= { 26, 46, 55,	115, 132, 161, 177, 180, 191, 230, 697, 783, 835}
self.szHistory = "\\user\\history\\"
self.szSetting = "\\interface2\\setting\\"
local szPath = "\\user\\"
local Parties = ""
local tbSaveData = Ui.tbLogic.tbSaveData

if not self.nLastFood then
	self.nLastFood = 0;
end
-------------------------------------------------------------------------
local nWuXingSkill ={283,285,287,289,291};

local nLSkill = {
[0]  = {};    -- 无门派
[1]  = {27,24,21,36,33,29};  -- 少林
[2]  = {47,43,38,56,53,50};         -- 天王
[3]  = {66,62,59,72,69};  -- 唐门
[4]  = {83,80,76,93,90,86};  -- 五毒
[5]  = {107,103,99,96};  -- 峨嵋
[6]  = {125,123,120,117,114,111}; -- 翠烟
[7]  = {134,131,128,845,141,140,137}; -- 丐帮
[8]  = {156,151,149,146,143}; -- 天忍
[9]  = {165,162,159,171,169,167}; -- 武当 
[10]  = {188,181,178,175};  -- 昆仑
[11]  = {205,208,211,202,194,198}; -- 明教
[12]  = {232,229,226,223,217,213}; -- 大理
[13]  = {2805,2804,2803,2825,2823,2821}; -- 古墓
[14]  = {3053,3047,3041,3033,3028,3015,3013}; -- 逍遥
};
-------------------------------------------------------------

----------tbAutoAiCfg đã khởi tạo bên autofight.lua
function AutoAi:UpdateCfg(tbAutoAiCfg)
	AutoAi.ProcessHandCommand("auto_fight", tbAutoAiCfg.nAutoFight);
	self.pick_item_value 	= tbAutoAiCfg.nPickValue * 2;
	self.life_left 			= tbAutoAiCfg.nLifeRet;
	self.Buff_left 			= tbAutoAiCfg.nBuffRet;
 	self.no_pick_commonitem = tbAutoAiCfg.nUnPickCommonItem;
	self.bAutoRepair 		= tbAutoAiCfg.nAutoRepair;
	self.bAcceptJoinTeam 	= tbAutoAiCfg.nAcceptTeam;
	self.bAutoDrinkWine 	= tbAutoAiCfg.nAutoDrink;
	self.nPvpMode 			= tbAutoAiCfg.nPvpMode;
	self.ObjHuo 			= tbAutoAiCfg.nAutoObjHuo;
	self.fdyx				= tbAutoAiCfg.nAutoFD;
	self.fdwx				= tbAutoAiCfg.nAutoFDWX;
	self.ds					= tbAutoAiCfg.nAutoRead;
	self.ds_move			= tbAutoAiCfg.nAutoRead_Move;
	----------------------------------------------------
	-- self.nSkill				= tbAutoAiCfg.nSkill;
	-- self.nKnockBack 		= tbAutoAiCfg.nKnockBack;
	self.bAutoOPXLZ 		= tbAutoAiCfg.nAutoXLZ;
	self.nAutoOpenJiuXiang = tbAutoAiCfg.nAutoOpenJiuXiang;
	self.nPKfanji 			= tbAutoAiCfg.nPKfanji;
	-----------------------------------------------------

	for i = 1,6 do	-- for i = 1,5 do
		if self.attack_skill[i] then
			self.attack_skill[i] = nil;
		end
	end
    self.attack_skill[1] = tbAutoAiCfg.nSkill1;
    self.attack_skill[2] = tbAutoAiCfg.nSkill2;
	self.attack_skill[3] = tbAutoAiCfg.nSkill3;
	self.attack_skill[4] = tbAutoAiCfg.nSkill4;
	self.attack_skill[5] = tbAutoAiCfg.nSkill5;
	self.attack_skill[6] = tbAutoAiCfg.nSkill6;

end

function AutoAi:Use_LuckBag()
	local tbFind = me.FindItemInBags(18,1,80,1);
	for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0)
			local function fnCloseSay()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0;
			end
			Ui.tbLogic.tbTimer:Register(18, fnCloseSay);
		end

			return 1;
	end
end

function AutoAi:IsAcceptJoinTeam()
	return self.bAcceptJoinTeam;
end

function AutoAi:CalcRang()
	if (self.attack_point == 2) then
		local a = self.auto_fight_pos[1].x;
		local b = self.auto_fight_pos[1].y;
		local c = self.auto_fight_pos[2].x;
		local d = self.auto_fight_pos[2].y;
		if (a and b and c and d)then
			return math.sqrt((a-c) * (a-c) + (b-d) * (b-d)) + self.ACTIVE_RADIUS;
		end
	end
	return 0;
end

function AutoAi:DoPickUp(nObjId)
	if self.ObjHuo == 1 then
		pPlayer.PickUpItem(nObjId, 0);
	end
	if (not pPlayer) then
		return;
	end
end

function AutoAi:GotGouhuo()
	AutoAi:Pause();
	self.TimeLastFire = GetTime();
	Timer:Register(Env.GAME_FPS * 8, self.DelayResumeAi, self);
end

function AutoAi:Jglj()
	local nHB1 = me.GetTask(2044, 1);
	local nHB2 = me.GetTask(2044, 2);
	local nHB3 = me.GetTask(2044, 3);
	local nHB4 = me.GetTask(2044, 4);
	local nHB5 = me.GetTask(2044, 5);
	local nHB6 = me.GetTask(2044, 6);
	local nHB7 = me.GetTask(2044, 7);
	local nHB8 = me.GetTask(2044, 8);
	local nHB9 = me.GetTask(2044, 9);
	local nHB10 = me.GetTask(2044, 10);
	local nHB = nHB1+nHB2+nHB3+nHB4+nHB5+nHB6+nHB7+nHB8+nHB9+nHB10;
	local tbFind = me.FindItemInBags(20,1,484,1);
	for j, tbItem in pairs(tbFind) do
		if nHB < 10 then
			me.UseItem(tbItem.pItem);
		end
		return 1;
	end
end

function AutoAi:BookInfo()
	local tbFind = me.FindItemInBags(20,1,298,1);	-- Tôn Tử Binh Pháp
	for j, tbItem in pairs(tbFind) do
		self.nYe1= tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec1 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,299,1);	-- Mặc Gia Cơ Quan Thuật 
	for j, tbItem in pairs(tbFind) do
		self.nYe2=tbItem.pItem.GetGenInfo(1);
		local nYear = tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec2 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,544,1);	-- Võ Mục Di Thư
	for j, tbItem in pairs(tbFind) do
		self.nYe3= tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec3 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,545,1);	-- Quỷ Cốc Đạo Thuật
	for j, tbItem in pairs(tbFind) do
		self.nYe4=tbItem.pItem.GetGenInfo(1);
		local nYear = tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec4 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,809,1);	-- Binh pháp 36 kế
	for j, tbItem in pairs(tbFind) do
		self.nYe5=tbItem.pItem.GetGenInfo(1);
		local nYear = tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec5 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,810,1);	-- Khuyết Nhất Môn
	for j, tbItem in pairs(tbFind) do
		self.nYe6=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec6 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end
	return 1;
end

function AutoAi:Read_book_szbf()
	if (me.nLevel >= 90) then
		local nBingShuCount = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
		if (nBingShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,298,1);
			for j, tbItem in pairs(tbFind) do
					AutoAi:Pause();
					me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
					me.UseItem(tbItem.pItem);
					--me.Msg("Đang đọc <color=yellow>Tôn Tử Binh Pháp<color>...");
					if self.nTalk_on==1 then
						UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Tôn Tử Binh Pháp<color><bclr>");
					end
					self.BookNum=1;
					Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
					break;
			end
		end
	end
end
function AutoAi:Read_book_mjjgs()
	if (me.nLevel >= 90) then
		local nJiGuanShuCount = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
		if (nJiGuanShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,299,1);
			for j, tbItem in pairs(tbFind) do
					AutoAi:Pause();
					me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
					me.UseItem(tbItem.pItem);
					--me.Msg("<color=green>Đang đọc <color><color=yellow>Mặc Gia Cơ Quan Thuật<color>...");
					if self.nTalk_on==1 then
						UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Mặc Gia Cơ Quan Thuật<color><bclr>");
					end
					self.BookNum=2;
					Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
					break;
				--end
			end
		end
	end
end
function AutoAi:Read_book_ggds()
	if (me.nLevel >= 110) then
			local tbFind = me.FindItemInBags(20,1,545,1);
			for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
				me.Msg("<color=green>Đang đọc <color><color=yellow>Quỷ Cốc Đạo Thuật<color>...");
				if self.nTalk_on==1 then
				--	me.Msg(string.format("<color=0,255,255>%s<color>",me.szName) .." - -!");
				end
				self.BookNum=4;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
		end
	end
end
function AutoAi:Read_book_wmys()
	if (me.nLevel >= 110) then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
				me.Msg("<color=green>Đang đọc <color><color=yellow>Võ Mục Di Thư<color>...");
				if self.nTalk_on==1 then
				end
				self.BookNum=3;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end

-----------

function AutoAi:Read_book_bf36j()
	if (me.nLevel >= 130) then
			local tbFind = me.FindItemInBags(20,1,809,1);
			for j, tbItem in pairs(tbFind) do
				AutoAi:Pause();
				me.UseItem(tbItem.pItem);
				me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
				if self.nTalk_on==1 then
			        me.Msg("<color=green>Đang đọc <color><color=yellow>Binh pháp 36 kế<color>...");

				end
				self.BookNum=5;
				Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
				break;
			--end
		end
	end
end

function AutoAi:Read_book_qym()
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,810,1);	-- Khuyết Nhất Môn
		for j, tbItem in pairs(tbFind) do
			self:Pause();
			me.UseItem(tbItem.pItem);
			me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH);
			me.Msg("Đang đọc <color=yellow>Khuyết Nhất Môn<color>...");
			self.BookNum=6;
			Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
			break;
		end
	end
end

function AutoAi:AutoRepair()
	if self.bAutoRepair ~= 1 then
		return;
	end
	if AutoAi.LastRepairTime + 60 > GetTime() then		
		return 0;
	end
	local tbItemIndex = {}
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		local pItem = me.GetItem(Item.ROOM_EQUIP,i,0)
		if pItem and pItem.nCurDur <self.nJX_Time *10 then
			for nLevel, tbJinxi in pairs(self.JINXI) do
				local tbFind = me.FindItemInBags(unpack(tbJinxi))
				for _, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
					self.bReleaseUiState = 1;
   					table.insert(tbItemIndex, pItem.nIndex)
   				end
			end
		end
	end
	me.RepairEquipment(3, #tbItemIndex, tbItemIndex)
	self.LastRepairTime = GetTime()
	Timer:Register(Env.GAME_FPS * 1, self.DelayCloseRepairWnd, self)
	return self.bReleaseUiState
end



function AutoAi:HaveJinxi()
	local bKimTe = 0
	for nLevel, tbJinxi in pairs(self.JINXI) do
		local nCount = me.GetItemCountInBags(unpack(tbJinxi))
		if nCount > 0 then
			bKimTe = 1
			break
		end
	end
	return bKimTe
end

function AutoAi:RepairAll()
	if self:HaveJinxi() == 0 then
		return 0
	end
	local tbItemIndex = {}
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		local pItem = me.GetItem(Item.ROOM_EQUIP,i,0)
		if pItem and (pItem.nCurDur < pItem.nMaxDur) then
			for nLevel, tbJinxi in pairs(self.JINXI) do
				local tbFind = me.FindItemInBags(unpack(tbJinxi))
				for _, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
					self.bReleaseUiState = 1;
   					table.insert(tbItemIndex, pItem.nIndex)
   				end
			end
		end
	end
	me.RepairEquipment(3, #tbItemIndex, tbItemIndex)
	self.LastRepairTime = GetTime()
	Timer:Register(Env.GAME_FPS * 1, self.DelayCloseRepairWnd, self)
	return self.bReleaseUiState
end

function AutoAi:DelayCloseRepairWnd()
	if self.bReleaseUiState == 1 then
		UiManager:ReleaseUiState(UiManager.UIS_ITEM_REPAIR);
		self.bReleaseUiState = 0;
	end

	return 0;
end

function AutoAi:DelayResumeAi()
	if self.TimeLastFire + 5 <= GetTime() then
		AutoAi.LockAi(0);
	end
	return 0;
end

function AutoAi:OutReadAi()                                           -------------------------------
	if self.TimeLastRead + 3 <= GetTime() then
		AutoAi:BookInfo();
		AutoAi.AiAutoMoveTo(self.auto_fight_pos[1].x,self.auto_fight_pos[1].y);
		AutoAi.LockAi(0);
		self.IsRead=0;
		self.read_now=0;
	end
	return 0;
end

function AutoAi:AutoDrinkWine()
	if self.bAutoDrinkWine ~= 1 then
		return;
	end
	local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.WINE_SKILL_ID);
	if nSkillLevel and nSkillLevel > 0 and nEndTime and nEndTime > 0 and
		self.TimeLastWine + self.TIME_WINE_EFFECT > GetTime() then
		return 0;
	else
		local nSkillLevel,nStateType,nEndTime,bIsNoClearOnDeath = me.GetSkillState(self.FIRE_SKILL_ID);
		if nSkillLevel and nSkillLevel > 0 then
			AutoAi:DrinkWine();
		end
	end
end

function AutoAi:DrinkWine()
	for i,tbWine in pairs(self.WINES) do
		local tbFind = me.FindItemInBags(unpack(tbWine));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.TimeLastWine = GetTime();
			return 1;
		end
	end
end

function AutoAi:AutoOPXLZ()
	if self.bAutoOPXLZ ~= 1 then
		return;
	end
	local nSkillLevel,nStateType,nEndTime = me.GetSkillState(332);
	if nEndTime and nEndTime > 0 then
		return 0;
	end
	local nSkillLevel = me.GetSkillState(self.FIRE_SKILL_ID);
	if not(nSkillLevel and nSkillLevel > 0) then
		return;
	end
	AutoAi:OpenXiuLian();
end

function AutoAi:OpenXiuLian()
	local tbFind = me.FindItemInBags(18,1,16,1);
	local pItem = tbFind[1].pItem;
	if (not pItem) then
		me.Msg("Không có tu luyện châu!")
		return 0;
	end

	local tbItem = Item:GetClass("xiulianzhu");
	local nRemain = tbItem:GetRemainTime();

	if (nRemain < 0.5) then
		me.Msg("Không đủ thời gian tu luyện châu");
		return;
	end
	me.UseItem(pItem);
	local function fnSelect()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			for i, tbInfo in ipairs(tbAnswers) do
				if string.find(tbInfo, "Ta muốn mở tu luyện") or string.find(tbInfo, "Ta muốn xem các chức năng khác") then
					me.AnswerQestion(i -1);
				end
			end
		end
			local function myopen()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then		
					local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
					for i, tbInfo in ipairs(tbAnswers) do
						if string.find(tbInfo, "Ta muốn mở tu luyện") or string.find(tbInfo, "Ta muốn mở 0.5 giờ") then
							me.AnswerQestion(i -1);
						end
					end
					return 0;
				end
			end
			local function myopen1()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0);
				end
				return 0;
			end

			local function myclose()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0;
			end
		Ui.tbLogic.tbTimer:Register(9, myopen);	-- 延迟选择
		Ui.tbLogic.tbTimer:Register(21, myopen1);	-- 延迟选择
		Ui.tbLogic.tbTimer:Register(33, myclose);	-- 延迟关窗口
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(8, fnSelect);
end

function AutoAi:Pause()
	AutoAi.LockAi(1);
end

function AutoAi:Resume(nStatus)
	AutoAi.LockAi(0);
	if nStatus == self.RESUME_GOUHUO_FIRED then
		self.TimeLastFire = GetTime();
		AutoAi:AutoDrinkWine();
	end
end


function AutoAi:ChangeSkill()
	local function SwitchHorseBySkill(nSkillId)
		local nLevel = me.GetNpc().GetFightSkillLevel(nSkillId);
		if nLevel == 0 then
			return
		end
		local tbS = KFightSkill.GetSkillInfo(nSkillId, -1);
		if not(tbS) then
			return
		end;
		if tbS.nHorseLimited == 1 and me.GetNpc().IsRideHorse() == 1 then
			Switch("horse")
		end
		if tbS.nHorseLimited == 2 and me.GetNpc().IsRideHorse() == 0 then
			Switch("horse")
		end
	end
	for _, nSkillId in ipairs(self.attack_skill) do
		SwitchHorseBySkill(nSkillId);
		if (AutoAi.GetSkillCostMana(nSkillId) > self.ncurmana) then
			self.no_mana = 1;
		end
		if (me.CanCastSkill(nSkillId) == 1) and (me.CanCastSkillUI(nSkillId) == 1) then
			AutoAi.SetActiveSkill(nSkillId, self.MAX_SKILL_RANGE);
			return;
		end
	end
	SwitchHorseBySkill(me.nLeftSkill)
	if (me.CanCastSkill(me.nLeftSkill) == 1) then
		AutoAi.SetActiveSkill(me.nLeftSkill, self.MAX_SKILL_RANGE);
	end;
end

function AutoAi:InitKeepRange()
	local x,y = me.GetNpc().GetMpsPos();
	self.auto_fight_pos[1].x = x;
	self.auto_fight_pos[1].y = y;
	self.auto_fight_pos[2].x = x;
	self.auto_fight_pos[2].y = y;
	self.keep_range = self:CalcRang();
	self.auto_pos_index = 1;
end

function AutoAi:ReadMapList(nCurMapId)
	local pTabFile = KIo.OpenTabFile("\\setting\\map\\maplist.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 3, nHeight do
		local szTextPos	= pTabFile.GetStr(i,1);

		local nTreaMapId 	= pTabFile.GetInt(i, 2);
		if nCurMapId==nTreaMapId then
			KIo.CloseTabFile(pTabFile);
			return szTextPos;
		end
	end
	KIo.CloseTabFile(pTabFile);	
	return 1;
end

function AutoAi:AI_InitAttack(nAttack)
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;
self.nSec6=0;
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0;
self.nYe6=0;
self.nX1=0;
self.nY1=0;
self.TimeLost=0;
self.IsRead=0;
self.BookNum=0;
self.read_now=0;
self.Move_Time=0;
	AutoAi:BookInfo();
	AutoAi.LockAi(0); 
	if (nAttack == 1) then
		Log:Ui_SendLog("Tự động đánh", 1);
		self:ChangeSkill();
	if (nTargetIndex == 1) then
		AutoAi.LockAi(nTargetIndex);
	else
		self:InitKeepRange();
		end
		me.AddSkillEffect(self.HEAD_STATE_SKILLID);
		local x,y = me.GetNpc().GetMpsPos();
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		local szMapName=self:ReadMapList(nCurMapId);
		me.Msg("<bclr=red><color=yellow>Tự động đánh<color>");
		print("AutoAi- Start Attack");
		local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	
			Switch("horse");
		end
	else
		me.RemoveSkillEffect(self.HEAD_STATE_SKILLID);
		me.Msg("<bclr=blue><color=White>Ngừng tự đánh<color>");

		print("AutoAi- Stop Attack");
	end
	AutoAi.ProcessHandCommand("auto_pick", nAttack);
	AutoAi.ProcessHandCommand("auto_drug", nAttack);
end

--------------------------------------------------------------------------------------------------------

function AutoAi:Reading_one()
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 then
		local tbFind = me.FindItemInBags(20,1,298,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_szbf();
				end
			else 
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_szbf();
				end
			end
		end
	end

	if self.nSec0 > self.nSec2 and self.nYe2<10 then
		local tbFind = me.FindItemInBags(20,1,299,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_mjjgs();
				end
			else
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_mjjgs();
				end
			end
		end
	end

	if self.nSec0 > self.nSec3 and self.nYe3<10 then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_wmys();
				end
			else
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_wmys();
				end
			end
		end
	end

	if self.nSec0 > self.nSec5 and self.nYe5<10 then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_bf36j();
				end
			else
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_bf36j();
				end
			end
		end
	end

	if self.nSec0 > self.nSec6 and self.nYe6<10 then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+256*(self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then

					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_qym();
				end
			else
				if nX2>self.nX1-256*(self.nX3-1) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_qym();
				end
			end
		end
	end
	if self.nSec0 > self.nSec4 and self.nYe4<10 then
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			if self.nX1==0 and self.nY1 ==0 then
				self.nX1,self.nY1 = me.GetNpc().GetMpsPos();
			end
			local nX2,nY2=me.GetNpc().GetMpsPos();
			if self.IsRead>=0 then
				if nX2<(self.nX1+(256*self.nX3-1)) and (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1+256*self.nX3,nY2);
					if self.IsRead==0 then
						me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					end
					self.IsRead=1;
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_ggds();
				end
			else
				if nX2>self.nX1-(256*self.nX3-1) and  (nY2<(self.nY1+self.nY3*256) and nY2>(self.nY1-self.nY3*256)) then
					AutoAi.AiAutoMoveTo(self.nX1-(256*self.nX3),nY2);
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
				else
					self.Move_Time=0;
					self.read_now=1;
					self:Read_book_ggds();
				end
			end
		end
	end
end
function AutoAi:Reading_two()
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 then
		local tbFind = me.FindItemInBags(20,1,298,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_szbf();
			end
		end
	end

	if self.nSec0 > self.nSec2 and self.nYe2<10 then
		local tbFind = me.FindItemInBags(20,1,299,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_mjjgs();
			end
		end
	end

	if self.nSec0 > self.nSec3 and self.nYe3<10 then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_wmys();
			end
		end
	end

	if self.nSec0 > self.nSec4 and self.nYe4<10 then
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_ggds();
			end
		end
	end
	if self.nSec0 > self.nSec5 and self.nYe5<10 then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_bf36j();
			end
		end
	end

	if self.nSec0 > self.nSec6 and self.nYe6<10 then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			if self.IsRead==0 then
			self.IsRead=1;
			self:Read_book_qym();
			end
		end
	end
	return 1;
end

-----------------------------------------------------------------------------

function AutoAi:AI_Normal(nFightMode, nCurLife, nCurMana, nMaxLife, nMaxMana) 
		
	if nFightMode == 0 then
		me.AutoFight(0);
		return;
	end
	
	AutoAi:fnOnMoveState();
	AutoAi:AutoDrinkWine();
	AutoAi:AutoRepair();
	self.ncurmana = nCurMana;
	local nCurTime = os.time();
	self.nCounter = self.nCounter + 1; 
	if (nCurLife * 100 / nMaxLife < self.LIFE_RETURN) then
		if self.nPvpMode == 0 then
			AutoAi.Flee();
			print("AutoAi- Flee...");
		end
	end
	if (math.mod(self.nCounter, 18) == 0) then	
		AutoAi:AutoOPXLZ();
	end

	if (math.mod(self.nCounter, 6) == 0) then
		local nFuCount = me.GetTask(2013, 1); 
		local nFuDate = me.GetTask(2013, 2); 
		local nFuLimit = me.GetTask(2013, 3);
		local nNowDate	= GetTime();
		local nDay		= tonumber(os.date("%y%m%d", nNowDate));

		if (nFuDate < nDay) then
			nFuCount = 0;
		end

		if (self.fdyx==1 and self.fdwx~=1) then
			if (nFuCount < nFuLimit) then
				self:Use_LuckBag();

			end
		elseif (self.fdwx==1 and self.fdyx ~=1) then
			self:Use_LuckBag();

		end

		local tbFind = me.FindItemInBags(20,1,483,1);
		for j, tbItem in pairs(tbFind) do
			local nHandBook =tbItem.pItem.GetGenInfo(1);
			if nHandBook<10 then
				self:Jglj();
			end
		end
		if self.ds_move==1 and self.read_now==0 then
			if self.IsRead~=0 then
					self.Move_Time = os.time();
					self.Move_Time=self.Move_Time+1;
				if math.mod(self.Move_Time,self.Move_TimeOut)==0 then
					self.IsRead=0-self.IsRead;
					self.Move_Time=0;
				end
			end
		end
		if self.ds_move==1 then
			self:Reading_one();
		end
	end
	if self.nEat_Lock==1 then
		self.life_left=self.nEat_Red;
	end
		if (nCurLife * 100 / nMaxLife < self.Buff_left) then
		if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then			
			UseSkill(98,GetCursorPos());
		end
	end
	if (nCurLife * 100 / nMaxLife < self.life_left) then
		if (self.nCounter - self.eat_life_time > self.EAT_SLEEP) then
			if (AutoAi.Eat(1) == 0) then
				AutoAi.ReturnCity();
				print("AutoAi- No Red Drug...");
			else
				AutoAi.Eat(1);
			end
			self.eat_life_time = self.nCounter;
		end
	end
	if self.nEat_Lock==1 then
		self.MANA_LEFT=self.nEat_blue;
	end
	local bNoMana = nCurMana * 100 / nMaxMana < self.MANA_LEFT;
	if (bNoMana or self.no_mana == 1) then
		if (self.nCounter - self.eat_mana_time > self.EAT_SLEEP) then
			self.no_mana = 0;
			if AutoAi.Eat(2) == 0 then
				print("AutoAi- No Blue Drug...");
				AutoAi.ReturnCity();
			end
			self.eat_mana_time = self.nCounter;
		end
	end
	if self.nEat_Lock==1 then
		self.EAT_FOOD_LIFE=self.nEat_Food;
	end
	if (bNoMana or nCurLife * 100 / nMaxLife < self.EAT_FOOD_LIFE) then
		if me.IsCDTimeUp(3) == 1 and 0 == AutoAi.Eat(3) then	-- 先吃短效食物
			local nLevel, nState, nTime = me.GetSkillState(self.FOOD_SKILL_ID);
			if (not nTime or nTime < 36) then
				self.nLastFood = nCurTime;
				if 0 == AutoAi.Eat(4) then
					print("AutoAi- No Food...");
				end
			end
		end
	end
	if (math.mod(self.nCounter, 6) == 0) then
		local nSelfIndex = AutoAi.GetSelfIndex();
		for _, nSkillId in ipairs(self.ASSIST_SKILL_LIST[me.nFaction]) do
			local nLevel, nState, nTime = me.GetSkillState(nSkillId);
			if ((not nTime or nTime < 36) and me.CanCastSkill(nSkillId) == 1) then
				if (AutoAi.GetSkillCostMana(nSkillId) > nCurMana) then
					self.no_mana = 1;
					break;
				end
				AutoAi.DoAttack(nSkillId, nSelfIndex);
				self.sleep_counter = 3;
				print("AutoAi- Use Right Skill", nSkillId);
				break; 
			end
		end
		AutoAi:ChangeSkill();
	end
end

function AutoAi:AutoFight()
	if self.IsRead~=0 then
		return 1;
	end
	if (self.sleep_counter > 0) then
		self.sleep_counter = self.sleep_counter - 1;
		return;
	end
	if self.nPvpMode == 1 then
		return;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
  		return
  	end
	local nTargetIndex = 0;
	if self.auto_move_counter <= 0 then
		nTargetIndex = AutoAi.AiFindTarget();
		if (nTargetIndex > 0 and self.KEEP_RANGE_MODE == 1 and self.auto_pos_index > 0) then
			local cNpc = KNpc.GetByIndex(nTargetIndex);
			local x,y,world = cNpc.GetMpsPos();
			local dx = x - self.auto_fight_pos[self.auto_pos_index].x;
			local dy = y - self.auto_fight_pos[self.auto_pos_index].y;
			if (dx and dy)then
				if (self.keep_range and self.keep_range > self.ATTACK_RANGE)then
					self.keep_range = self.keep_range - 50;
				else
					self.keep_range = self.ATTACK_RANGE;
				end
				if (dx * dx + dy * dy > self.keep_range * self.keep_range)then
					nTargetIndex = 0;
				end
			end
		end
		if (nTargetIndex <= 0 and self.auto_pos_index > 0)then
			self.auto_move_counter = 0;
		end
	else
		self.auto_move_counter = self.auto_move_counter - 1;
	end
	if (nTargetIndex > 0) then
		AutoAi.SetTargetIndex(nTargetIndex);
		print("AutoAi- Set Target", nTargetIndex);

		self:ChangeSkill();
	else
		if self.auto_pos_index <= 0 then
			print("AutoAi- Auto Move...");
			AutoAi.AiAutoMove();
		else
			local nx = self.auto_fight_pos[self.auto_pos_index].x;
			local ny = self.auto_fight_pos[self.auto_pos_index].y;
			if (nx == nil or ny == nil) then
				self.auto_pos_index = 0;
				return;
			end
			local x,y,world = me.GetNpc().GetMpsPos();
			local dx = x - nx;
			local dy = y - ny;
			if (self.attack_point == 1) then
				if (dx * dx + dy * dy > self.ATTACK_RANGE * self.ATTACK_RANGE * 0) then
					AutoAi.AiAutoMoveTo(nx, ny);
					print("AutoAi- Auto Move To", nx, ny);
					return;
				else
					AutoAi.Sit();
					if self.ds==1 then
						local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
						self.nSec0 = Lib:GetDate2Time(nDate);
						if (self.nSec0 > self.nSec1 and self.nYe1<10) or (self.nSec0 > self.nSec2 and self.nYe2<10) or (self.nSec0 > self.nSec3 and self.nYe3<10) or (self.nSec0 > self.nSec4 and self.nYe4<10) or (self.nSec0 > self.nSec5 and self.nYe5<10) or (self.nSec0 > self.nSec6 and self.nYe6<10) then
							AutoAi:Reading_two();
						end
					end
				end
			elseif (self.attack_point == 2) then
				if (AutoAi.AiAutoMoveTo(nx, ny) <= 0) then
					self.keep_range = self:CalcRang();
					if (self.auto_pos_index == 1)then
						self.auto_pos_index = 2;
					else
						self.auto_pos_index = 1;
					end
				end
			end
		end

	end
end



function AutoAi:CheckItemPickable()
	if self.EnhancePick==1 then
		Space=self.EnhancePick;
	end
	for Space=1,6 do
	AutoAi.PickAroundItem(Space);
        print("AutoAi- Pick Item", it.szName .. Space)
	end
	if it.nGenre > 16 then
		if self.no_pick_commonitem ~= 1 then
			print("AutoAi- Pick Item", it.szName);
			return 1;
		end
		return 0;
	end
	print("AutoAi- Equip Value", it.nStarLevel);
	if it.nStarLevel >= self.pick_item_value then
			return 1;
	else                                        
		local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(it);
		if (nGTPCost > 0) and (#tbStuff > 0) then
			for _, tbInfo in ipairs(tbStuff) do
				if  tbInfo.nLevel >9  or (tbInfo.nLevel == 9 and tbInfo.nCount >= 2) then 
					return 1;
				end
			end
		end
	end
	return 0;           
end

function AutoAi:fnOnMoveState()
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	local nSkillId = self:GetBuffSkillId();
	if me.nAutoFightState == 1 then
		if (nSkillId > 0) then	
			local _, _, nRestTime	= me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < Env.GAME_FPS) then
				AutoAi:Pause();
				UseSkill(nSkillId ,GetCursorPos());
				Timer:Register(Env.GAME_FPS * 1, AutoAi.DelayResumeAi, AutoAi);
			end
		end
	end
end

function AutoAi:GetBuffSkillId()
	for _, nSkillId in ipairs(tbBuffSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			return 	nSkillId;
		end
	end
	return 0;
end
UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_POSITION, AutoAi.fnOnMoveState,AutoAi);
---------------------Hàm Thư Viện

function AutoAi:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function AutoAi:StartAutoFight()
	if me.nAutoFightState ~= 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function AutoAi:Distance(x1, y1, x2, y2)
	if not (x2 and y2) then
		local nM, nX, nY = me.GetWorldPos()
		x2, y2 = nX, nY
	end
	return math.floor(math.sqrt((x1-x2)^2 + (y1-y2)^2))
end

function AutoAi:RelationLevel(szPlayer)
	local tbRelationList, tbInfoList = me.Relation_GetRelationList()
	if tbInfoList then
		local tbInfo = tbInfoList[szPlayer]
		if tbInfo then
			return math.ceil(math.sqrt(tbInfo.nFavor / 100))
		end
	end
	return 0
end
--================================================================================--
function AutoAi:Processing()
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) or
		(self:MapLoading() == 1) or (Ui(Ui.UI_SKILLPROGRESS).Processing == 1) then
		return 1
	end
	return 0
end

function AutoAi:CloseAllUi()
	self:CloseUi(Ui.UI_SAYPANEL)
	self:CloseUi(Ui.UI_EQUIPENHANCE)
	self:CloseUi(Ui.UI_TEXTINPUT)
	self:CloseUi(Ui.UI_SHOP)
	self:CloseUi(Ui.UI_TRADE)
	self:CloseUi(Ui.UI_MSGBOX)
	self:CloseUi(Ui.UI_ITEMGIFT)
	self:CloseUi(Ui.UI_SKILLPROGRESS)
	if (me.nFightState ~= 1) then
		self:CloseUi(Ui.UI_REPOSITORY)
	end
	self:CloseUi(Ui.UI_COMPOSE)
	self:CloseUi(Ui.UI_AUCTIONROOM)
	self:CloseUi(Ui.UI_JINGHUOFULI)
end
--=======================Leader====================--
function AutoAi:IsLeader(szName)
	if me.nTeamId < 1 then
		return -1
	end
	if not szName then
		szName = me.szName
	end
	if (self:LeaderName() == szName) then
		return 1
	end
	return 0
end

function AutoAi:LeaderName()
	local pLeader = self:GetTeamLeader()
	if pLeader and pLeader.szName then
		return pLeader.szName
	end
	return ""
end

function AutoAi:GetTeamLeader()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if nAllotModel and tbMemberList then
		local tLeader = tbMemberList[1];
		local pNpc = KNpc.GetByPlayerId(tLeader.nPlayerID);
		if pNpc then
			return pNpc
		end
	end
	local tbMemberList = me.GetTeamMemberInfo()	-- Array pNpc not Me
	for i=1, #tbMemberList do
		if tbMemberList[i].nLeader == 1 then
			return tbMemberList[i]
		end
	end
end

function AutoAi:LeaderInPC()
	if me.nTeamId < 1 then
		return 0
	end
	if (self:InPC(self:LeaderName()) == 1) then
		return 1
	end
	return 0
end

function AutoAi:PartyAllInPC(nFullMem)
	if (not nFullMem) or (nFullMem < 1) then
		nFullMem = 1
	end
	local szFN = self.szUser.."Names.txt"
	local pTabFile = KIo.OpenTabFile(szFN)
	if not pTabFile then
		KIo.CloseTabFile(pTabFile)
		return 0
	end
	local nHeight = pTabFile.GetHeight()
	if me.nTeamId and (me.nTeamId > 0) then
		if (self:MemberCount() >= nFullMem) or (self:IsLeader() ~= 1) then
			KIo.CloseTabFile(pTabFile)
			return 1
		end
		local bOK = 1
		local tbNearbyPlayer = me.GetNearbyLonePlayer()
		local nMyLine = self:FileLine()
		for i = 1, #tbNearbyPlayer do
			if (tbNearbyPlayer[i].nCaptainFlag == 1) then
				if nMyLine < self:FileLine(tbNearbyPlayer[i].szName) then
					bOK = 0
					me.TeamLeave()
					break
				end
			end
		end
		if bOK == 1 then
			for i=1, nHeight do
				me.TeamInvite(0, pTabFile.GetStr(i, 1))
			end
		end
	else
		local tbNearbyPlayer = me.GetNearbyLonePlayer()
		for i = 1, #tbNearbyPlayer do
			local szName = tbNearbyPlayer[i].szName
			local nId = tbNearbyPlayer[i].nPlayerID
			if szName and nId and (tbNearbyPlayer[i].nCaptainFlag == 1) and
				(self:InPC(szName) == 1) then
				me.TeamApply(nId, szName)
				break
			end
		end
	end
	KIo.CloseTabFile(pTabFile)
	return 0
end

function AutoAi:MemberCount()
	local nAllotModel, tbMemberList = me.GetTeamInfo()	-- All member
	if tbMemberList then
		return #tbMemberList
	end
	return 0
end

function AutoAi:FileLine(szName, szFN)
	if (not szFN) or (szFN == "") then
		szFN = self.szUser.."Names.txt"
	end
	if (not szName) or (szName == "") then
		szName = me.szName
	end
	local pTabFile = KIo.OpenTabFile(szFN)
	if not pTabFile then
		KIo.CloseTabFile(pTabFile)
		return 0
	end
	local nHeight = pTabFile.GetHeight()
	local nRet = -1
	for i=1, nHeight do
		if (szName == pTabFile.GetStr(i, 1)) then
			nRet = i
			break
		end
	end
	KIo.CloseTabFile(pTabFile)
	return nRet
end

function AutoAi:InPC(szName)
	return self:InFile(szName, szPath.."Names.txt")
end

function AutoAi:InFile(szTxt, szFN)
	if (not szFN) or (szFN == "") then
		szFN = self.szHistory..me.szName..tostring(me.nFaction)..".txt"
	end
	local szData = KFile.ReadTxtFile(szFN)
	if (not szData) or (szData == "") then
		return 0
	end
	if string.find(szData, szTxt) then
		return 1
	else
		return 0
	end
end




