local nTimerId = 0;
local nState   = 0;
local nTime    = 1/6;
local nEquipThrow;

function AutoAi:SwitchAutoThrowAway()
	me.Msg("<color=green>Loại bỏ Huyền Tinh cấp thấp");
	nTimerId = Ui.tbLogic.tbTimer:Register(nTime * Env.GAME_FPS, self.AutoThrowAway, self);
	return;
end

function AutoAi:SwitchAutoThrowAway2()
	local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);
	uiAutoFight:LoadSetting();
	local nPickStar = uiAutoFight.nPickStar;
	me.Msg("<color=green>Loại bỏ trang bị cấp thấp");
	nTimerId = Ui.tbLogic.tbTimer:Register(nTime * Env.GAME_FPS, self.AutoThrowAway2, self, nPickStar);
	return;
end

function AutoAi:AutoThrowAway()
	if me.IsAccountLock() == 1 then
		me.Msg("<color=green>Chưa mở khóa bảo vệ");
		return 0
	end
	local tbItem = me.FindItemInBags(18,1,1,1)[1] or me.FindItemInBags(18,1,1,2)[1] or me.FindItemInBags(18,1,1,3)[1] or me.FindItemInBags(18,1,1,4)[1]; 
	me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
end

function AutoAi:AutoThrowAway2(nPickStar)
	if me.IsAccountLock() == 1 then
		me.Msg("<color=green>Chưa mở khóa bảo vệ");
		return 0
	end
	AutoAi:GetEquipThrow(nPickStar)
	local tbItem = nEquipThrow[1] ;	
	me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
end

function AutoAi:SwitchAutoThrowAway3()
me.Msg("<color=orange>Loại bỏ nguyên liệu TDC, các loại lệnh bài...");
nTimerId = Ui.tbLogic.tbTimer:Register(nTime * Env.GAME_FPS, self.AutoThrowAway3, self);
return;
end

function AutoAi:AutoThrowAway3()
if me.IsAccountLock() == 1 then
me.Msg("<color=green>Chưa mở khóa bảo vệ");
return 0
end
local tbItem = me.FindItemInBags(18,1,1,1)[1] 
or me.FindItemInBags(22,1,41,1)[1]
or me.FindItemInBags(22,1,35,1)[1]
or me.FindItemInBags(22,1,43,1)[1]
or me.FindItemInBags(22,1,39,1)[1]
or me.FindItemInBags(22,1,37,1)[1]
or me.FindItemInBags(22,1,73,1)[1]
or me.FindItemInBags(22,1,75,1)[1]
or me.FindItemInBags(22,1,77,1)[1]
or me.FindItemInBags(22,1,79,1)[1]
or me.FindItemInBags(18,1,289,7)[1]
or me.FindItemInBags(18,1,289,8)[1]
or me.FindItemInBags(18,1,289,9)[1]
or me.FindItemInBags(18,1,289,10)[1]
or me.FindItemInBags(18,1,112,2)[1]
or me.FindItemInBags(18,1,111,1)[1]
or me.FindItemInBags(18,1,111.2)[1]
or me.FindItemInBags(18,1,111.3)[1]
or me.FindItemInBags(18,1,110,1)[1]
or me.FindItemInBags(18,1,110,2)[1]
or me.FindItemInBags(18,1,110,3)[1]
or me.FindItemInBags(18,1,144,3)[1]
or me.FindItemInBags(18,1,84,1)[1]
or me.FindItemInBags(18,1,252,1)[1]
or me.FindItemInBags(18,1,1335,1)[1]
or me.FindItemInBags(18,1,1337,1)[1]
or me.FindItemInBags(18,1,1338,1)[1]
or me.FindItemInBags(18,1,1340,1)[1]
or me.FindItemInBags(18,1,247,1)[1]
or me.FindItemInBags(18,1,107,1)[1]
or me.FindItemInBags(18,1,1,4)[1]
or me.FindItemInBags(18,1,1,2)[1]; -- 不绑的1、2玄,5玄不让扔--!
me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
end

function AutoAi:GetEquipThrow(nPickStar)
	nEquipThrow={};
	local tbFind=me.FindClassItemInBags("equip")
	if tbFind then
		for _, tbItem in ipairs(tbFind) do
			local pItem = me.GetItem(tbItem.nRoom, tbItem.nX, tbItem.nY);
			if pItem.nStarLevel<=nPickStar*2 and 1 ~= pItem.IsBind() then
				table.insert(nEquipThrow, tbItem);
			end
		end
	end
end