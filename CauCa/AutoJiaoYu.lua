-- ====================== 文件信息 ======================
-- sản phẩm　：AutoJiaoYu.lua
-- bán rác
-- ngày ra mắt　：2011-10-16
-- 功    能  ：周末自动交鱼卖钓鱼杂物
-- 注意事项　：请保留以上说明，以体现对原作者和修改者的尊重
-- ======================================================
local tbJiaoYu	= UiManager
local tbTimer = Ui.tbLogic.tbTimer;

local self = tbJiaoYu

local nJiaoYuCity = 7; --默认新手村
self.nJiaoYuClock = 0; --开关
local nJiaoYuState = 0;
local nJiaoYuPutFlg = 0;

--钓鱼杂物
local Sundry = {
	[1] = {18,1,1396,1},
	[2] = {18,1,1397,1},
	[3] = {18,1,1398,1},
	[4] = {18,1,1399,1},
	[5] = {18,1,1400,1},
	[6] = {18,1,1401,1},
	[7] = {18,1,1402,1},
	[8] = {18,1,1403,1},
	[9] = {18,1,1404,1},
	[10] = {18,1,1405,1},
	[11] = {18,1,1406,1},
	[12] = {18,1,1407,1},
	[13] = {18,1,1408,1},
	[14] = {18,1,1409,1},
	[15] = {18,1,1410,1},
	[16] = {18,1,1411,1},
	[17] = {18,1,1412,1},
	[18] = {18,1,1413,1},
	[19] = {18,1,1414,1},
	[20] = {18,1,1415,1},
};

--需要交的鱼
local Fishs = {
	[1] = {18,1,1365,1},--鲤鱼
	[2] = {18,1,1366,1},--黄鱼
	[3] = {18,1,1367,1},--虾虎鱼
	[4] = {18,1,1368,1},--鲢鱼
	[5] = {18,1,1369,1},--鲟鱼
	[6] = {18,1,1370,1},--白鳗
	[7] = {18,1,1371,1},--草鱼
	[8] = {18,1,1372,1},--鳕鱼
	[9] = {18,1,1373,1},--鳙鱼
	[10] = {18,1,1374,1},--霸王鱼
	[11] = {18,1,1375,1},--铜鱼
	[12] = {18,1,1376,1},--鳌花鱼
	[13] = {18,1,1377,1},--大头鱼
	[14] = {18,1,1378,1},--巨鳝
	[15] = {18,1,1379,1},--鲶鱼
	[16] = {18,1,1380,1},--团头鱼
	[17] = {18,1,1381,1},--青鱼
	[18] = {18,1,1382,1},--白鲳
	[19] = {18,1,1383,1},--鲮鱼
	[20] = {18,1,1384,1},--鲫鱼
	[21] = {18,1,1385,1},--马哈鱼
	[22] = {18,1,1386,1},--金龙鱼
	[23] = {18,1,1387,1},--河豚
	[24] = {18,1,1388,1},--花鳅
	[25] = {18,1,1389,1},--河鲈
};

--注册快捷键
local tCmd={ "UiManager:JiaoYu()", "JiaoYu", "", "Shift+V", "Shift+V", "Bán Rác"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	-----快捷键 Shift+V

--开启/关闭交鱼
function tbJiaoYu:JiaoYu()
	if self.nJiaoYuClock == 0 then
		nJiaoYuPutFlg = 0;
		self:GetJiaoYuState();
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tự động bán cá,bán rác<color>");
		self.nJiaoYuClock = tbTimer:Register(Env.GAME_FPS, self.JiaoYuTime, self);
	else
		tbTimer:Close(self.nJiaoYuClock);
		self.nJiaoYuClock = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt Tự động bán cá,bán rác<color>");
		if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1) then
			UiManager:CloseWindow(Ui.UI_ITEMGIFT);
		end
		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			UiManager:CloseWindow(Ui.UI_SHOP);
		end
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
	end
end

--状态刷新器
function tbJiaoYu:GetJiaoYuState()
	--判断包裹中杂物数量
	local ncount1 = 0;
	for i,tbFitem in pairs(Sundry) do
		ncount1 = ncount1 + me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
	end
	if ncount1 > 0 then
		nJiaoYuState = 1;
		return;
	end
	--判断包裹中鱼的数量
	local ltime =GetLocalDate("%H%M");
	local nWeekDay	= tonumber(os.date("%w", GetTime()));
	local ncount3 = 0;
	for i,tbFitem in pairs(Fishs) do
		if not ((nWeekDay == 6 or nWeekDay == 0) and (tonumber(ltime) >= 1000 and tonumber(ltime) < 2330)) then
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Không để quá thời gian câu cá！");
			ncount3 = 0;
		else
			ncount3 = ncount3 + me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
		end
	end
	if ncount3 > 0 then
		nJiaoYuState = 2;
		return;
	end
	nJiaoYuState = 0;
end
--交鱼主处理
function tbJiaoYu:JiaoYuTime()
	--进度条返回
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	--过图检查
	local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
	if (nMyMapId <= 0 or nMyPosX <= 0) then
		return;
	end
	if nJiaoYuState == 0 then
		self:JiaoYu();
	elseif nJiaoYuState >= 99 then --刷新状态
		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			UiManager:CloseWindow(Ui.UI_SHOP);
		end
		if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1) then
			UiManager:CloseWindow(Ui.UI_ITEMGIFT);
		end
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		self:GetJiaoYuState();
	elseif nJiaoYuState == 1 then --卖杂物
		self:JiaoYuSellItem();
	elseif nJiaoYuState == 2 then --交鱼
		self:GoJiaoYu();
	end
end

--卖杂物
function tbJiaoYu:JiaoYuSellItem()
	local nId = self:JiaoYuGetAroundNpcId(3642) --酒楼
	if nId then
		if (UiManager:WindowVisible(Ui.UI_SHOP) ~= 1) then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			else
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "<color=pink>Hiện tại ta phải giao cá<color>") then
						me.AnswerQestion(i - 1);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
						return;
					elseif string.find(tbInfo, "Ta muốn tiếp tục giao cá") then
						me.AnswerQestion(i - 1);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					end
				end
			end
			return;
		else
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			--me.Msg("<color=green>已打开商店，准备卖杂物<color>");
			for i,tbFitem in pairs(Sundry) do
				local tbFind = me.FindItemInBags(unpack(tbFitem));
				for j, tbItem in pairs(tbFind) do
					local num = me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
					me.ShopSellItem(tbItem.pItem, num);
					return;
				end
			end
			nJiaoYuState = 99;
			if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
				UiManager:CloseWindow(Ui.UI_SHOP);
			end
		end
	else
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		self:JiaoYufnfindNpc(3642,"Tần Oa");
	end
end

--获取NPC信息
function tbJiaoYu:JiaoYuGetAroundNpcId(nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 150);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then	-- 正是要找的人
			return pNpc.nIndex
		end
	end
	return
end

--交背包鱼
function tbJiaoYu:GoJiaoYu()
	local nId = tbMember:GetAroundNpcId(3642)
	if nId then
		if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) ~= 1) then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			else
				local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Hiện tại ta phải giao cá") then
						me.AnswerQestion(0);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					elseif string.find(tbInfo, "Ta muốn tiếp tục giao cá") then
						me.AnswerQestion(0);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					else
						if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
							nJiaoYuState = 99;
						end
					end
				end
			end
		else
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			if nJiaoYuPutFlg == 0 then
				for i,tbFitem in pairs(Fishs) do
					local tbFind = me.FindItemInBags(unpack(tbFitem));
					for j, tbItem in pairs(tbFind) do
						local num = me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
						if num > 20 then
							num = 20;
						end
						self:JiaoYuMyFindItem(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4],1,num,tbFitem[3],1);
						nJiaoYuPutFlg = 1;
						return;
					end
				end
			else
				nJiaoYuPutFlg = 0;
				Ui(Ui.UI_ITEMGIFT).OnButtonClick(Ui(Ui.UI_ITEMGIFT),"BtnOk");
				return;
			end
			nJiaoYuState = 99;
			me.Msg("自动交鱼完成！")
			if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1) then
				UiManager:CloseWindow(Ui.UI_ITEMGIFT);
			end
		end
	else
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		Map.tbMember:fnfindNpc(3642,"Tần Oa");
	end
end

--找到指定的NPC
function tbJiaoYu:JiaoYufnfindNpc(nNpcId, szName)
	local nMyMapId	= me.GetMapTemplateId();
	local nTargetMapId = nJiaoYuCity;
	--如果在新手村，直接去找本新手村的秦洼
	if (nMyMapId <9 and nMyMapId >0) then
		nTargetMapId = nMyMapId;
	end
	local nX1, nY1;
	nX1, nY1 = KNpc.ClientGetNpcPos(nTargetMapId, nNpcId);
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = szName..","..nTargetMapId..","..nX1..","..nY1
	--me.Msg(tbPosInfo.szLink)
	--UiManager.tbLinkClass["pos"]:OnClick(tbPosInfo.szLink);
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
end

-- 从主包和3个背包中找到1个gdpl值一样的物品
function tbJiaoYu:JiaoYuMyFindItem(g,d,p,l,bOffer,count,p1,isBind)
	local k = 0
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem and pItem.IsBind() == isBind then
				local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
				if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
					--me.Msg("j:"..j..",i:"..i.."  "..pItem.nGenre..","..pItem.nDetail..","..pItem.nParticular..","..pItem.nLevel)
					if bOffer == 1 then
						k= k+1
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem and pItem.IsBind() == isBind then
					local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1  then
							k= k+1
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
				if pItem and pItem.IsBind() == isBind then
					local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
				if pItem and pItem.IsBind() == isBind then
					local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end
	return 0;
end