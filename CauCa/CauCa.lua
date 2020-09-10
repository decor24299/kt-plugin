
local self = pFishing;

local pFishing	= Map.pFishing or {};
Map.pFishing		= pFishing;

local nState = 0;
local nTimerId1 = 0;
local nTimerId2 = 0; -- bán rác
local nDelay = 0;

local nShopID_CanCau = 5004; -- 5003 => 5007
local nShopID_MoiSoChe = 5008;
local nShopID_MoiTinhChe = 5009;
local nShopID_CamNangCa = 5010;
local nCntTime_GiatCanCau = 0;

local tbFishingPos = {
	[1] = {1513,3255}, 
	[2] = {1848,3665}, 
	[3] = {1714,3246}, 
	[4] = {1701,3264}, 
	[5] = {1656,3232}, 
	[6] = {1703,3206}, 
	[7] = {1452,3386}, 
	[8] = {1784,3506},
};

local szCmd = [=[
	Map.pFishing:OnStart();
]=];

function pFishing:OnStart()
	if nTimerId2 == 0 then
		nTimerId2 = Ui.tbLogic.tbTimer:Register(0.5 * Env.GAME_FPS,self.OnSellTime,self);
	end
	if nState == 0 then
		nState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bat dau<color>");
		nTimerId1 = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.OnTimer,self);
	elseif nState == 1 then
		nState = 0;
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Ket thuc<color>");
	end
end

function pFishing:OnSellTime()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		for j = 1396, 1415 do
			self:SellItem(18,1,j,1);
		end
	end
end

function pFishing:SellItem(a,b,c,d)
	local nCntItem = me.GetItemCountInBags(a,b,c,d);
	if nCntItem < 1 then
		return false;
	end
	local tbFind = me.FindItemInBags(a,b,c,d);
	for _, tbItem in pairs(tbFind) do
		me.ShopSellItem(tbItem.pItem, nCntItem);
		return true;
	end
end

function pFishing:OnTimer()
	if nDelay > 0 then
		nDelay = nDelay - 1;
		return;
	end
--	if GetMapType(me.GetMapTemplateId()) ~= "village" then
--		UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Chuyển về bản đồ Tân Thủ Thôn<color>");
--		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 0 then
--			self:DiToiTanOaMap(1);
--		end
--		return;
--	end
	-- me.Msg("1");
	-- đang ở map tân thủ thôn
	if me.GetTask(2174,1) ~= me.GetTask(2174,37) then -- chưa nhận nhiệm vụ
		self:DiToiTanOaMap(me.GetMapTemplateId(),",1,1");
		return;
	end
	-- me.Msg("2");
	-- đã nhận nhiệm vụ
	local pItem_CanCau = self:KiemTraCanCau();
	if pItem_CanCau == 0 then -- chưa có cần câu
		self:DiMuaCanCau();
		return;
	end
	-- me.Msg("3");
	-- đã có cần câu
	local nSoCaDaGiao = me.GetTask(2174,31);
	local nCntCaTrongRuong = self:DemCaTrongRuong();
	local nCntMoiCau = me.GetItemCountInBags(18,1,1391,1);
	if nCntCaTrongRuong + nSoCaDaGiao + nCntMoiCau < 50 then -- chưa có đủ mồi để câu cá
		self:DiMuaMoiCau(50-(nCntCaTrongRuong + nSoCaDaGiao + nCntMoiCau));
		return;
	end
	-- đã có cần câu và đã đủ mồi để câu cá: tổng số cá trong rương, số cá đã giao, số mồi trong rương >= 50
	if nSoCaDaGiao == 50 then -- đã giao đủ cá
		local sNhanThuong = me.GetTask(2174,32);
		if sNhanThuong == 0 then
			self:DiToiTanOaMap(me.GetMapTemplateId(),",1,1,1");
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Đã giao đủ cá hôm nay<color>");
			local sHaveAw = 0;
			for l = 1,4 do
				if me.GetItemCountInBags(18,1,1445,i) > 0 then
					sHaveAw = 1;
					local tbFind = me.FindItemInBags(18,1,1445,i);
					for _, tbItem in pairs(tbFind) do
						me.UseItem(tbItem.pItem);
					end
				end
			end
			if sHaveAw == 0 then
				if self:CoRacTrongRuong() == 1 then -- có rác trong rương, cần đi dọn rác
					-- đi bán rác
					self:DiMuaVatPham(0,0);
				else
					Exit();
				end
			end
		end
		return;
	end
	-- chưa giao đủ cá, cần đi câu thêm
	if nCntMoiCau == 0 then -- đã câu hết mồi
		-- đi trả cá
		if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 0 then
			self:DiToiTanOaMap(me.GetMapTemplateId(),",1");
			nDelay = 2;
		else
			self:TraCa();
		end
		return;
	end
	-- chưa câu hết mồi, có thể đi câu thêm
	if me.CountFreeBagCell() == 0 then -- đầy hành trang, cần đi bán bớt rác
		if self:CoRacTrongRuong() == 1 then -- có rác trong rương, cần đi dọn rác
			-- đi bán rác
			self:DiMuaVatPham(0,0);
		else -- đầy hành trang do cá hoặc một nguyên nhân nào khác (không phải do rác)
			if nCntCaTrongRuong == 0 then -- đầy hành trang do một nguyên nhân nào đó (không phải do rác hay cá)
				UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Hành trang đã đầy, vui lòng dọn dẹp<color>");
				nDelay = 3;
			else -- hành trang đầy, có cá trong hành trang, cần đi trả cá
				-- đi trả cá
				if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 0 then
					self:DiToiTanOaMap(me.GetMapTemplateId(),",1");
					nDelay = 2;
				else
					self:TraCa();
				end
			end
		end
		return;
	end
	-- hành trang chưa đầy, có thể đi câu
--	local nPosX = tbFishingPos[me.GetMapTemplateId()][1];
--	local nPosY = tbFishingPos[me.GetMapTemplateId()][2];
--	local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
--	if nMyPosX ~= nPosX or nMyPosY ~= nPosY then -- chưa tới địa điểm câu
--		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
--			UiManager:CloseWindow(Ui.UI_SHOP);
--		end
--		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
--			UiManager:CloseWindow(Ui.UI_SAYPANEL);
--		end
--		me.StartAutoPath(nPosX, nPosY);
		-- AutoAi.AiAutoMoveTo(nPosX*32, nPosY*32);
--		nDelay = 1;
--		return;
--	end
	-- đã tới địa điểm câu
	-- me.Msg("Đã tới địa điểm");
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 0 then
		me.UseItem(pItem_CanCau); -- sử dụng cần câu để thả mồi
		nCntTime_GiatCanCau = 0;
	else
		nCntTime_GiatCanCau = nCntTime_GiatCanCau + 1;
		-- if Txt_GetTxt(Ui(Ui.UI_SKILLPROGRESS).UIGROUP, "TxtMsg") == "Đang câu cá" then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_SHOP);
			end
			-- local szPercent = Txt_GetTxt(Ui(Ui.UI_SKILLPROGRESS).UIGROUP, "TxtProgress");
			-- if self:CoTheGiatCanCau(szPercent) == 1 then
			if nCntTime_GiatCanCau > 6 then
				me.UseItem(pItem_CanCau); -- sử dụng cần câu để giật cá
			end
			-- end
		-- end
	end
end

function pFishing:CoTheGiatCanCau(szPercent)
	for i = 18,35 do
		if (tostring(i).."%") == szPercent then
			return 1;
		end
	end
	return 0;
end

function pFishing:TraCa()
	local tbSwitchedItem = {};
	local sFree = self:KiemTraROOM_GIFT();
	if sFree == true then -- có ô trống
		for j = 1365,1389 do
			if me.GetItemCountInBags(18,1,j,1) > 0 then
				local tbFind = me.FindItemInBags(18,1,j,1);
				for _, tbItem in pairs(tbFind) do
					-- me.Msg("Index "..(tonumber(tbItem.pItem.nIndex)).."");
					if #tbSwitchedItem == 0 then -- chưa có pItem trong bảng
						local sFree2, nX, nY = self:KiemTraROOM_GIFT();
						me.SetItem(tbItem.pItem, Item.ROOM_GIFT, nX, nY);
						table.insert(tbSwitchedItem, tonumber(tbItem.pItem.nIndex));
					else -- đã có pItem trong bảng, cần xét xem tbItem.pItem đã có trong bảng chưa
						local sExist = 0;
						for k = 1, #tbSwitchedItem do
							if tonumber(tbSwitchedItem[k]) == tonumber(tbItem.pItem.nIndex) then -- tbItem.pItem đã có trong bảng
								sExist = 1;
							end
						end
						if sExist == 0 then
							local sFree2, nX, nY = self:KiemTraROOM_GIFT();
							me.SetItem(tbItem.pItem, Item.ROOM_GIFT, nX, nY);
							table.insert(tbSwitchedItem, tonumber(tbItem.pItem.nIndex));
						end
					end
				end
			end
		end
		local uiGift = Ui(Ui.UI_ITEMGIFT);
		uiGift.OnButtonClick(uiGift,"BtnOk");
		UiManager:CloseWindow(Ui.UI_ITEMGIFT);
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
end

function pFishing:KiemTraROOM_GIFT() -- return true và tọa độ nếu còn trống, chỉ xét ô 4x4
	for i = 0,3 do
		for j = 0,3 do
			local pItem = me.GetItem(Item.ROOM_GIFT, i, j);
			if not pItem then
				return true, i, j;
			end
		end
	end
	return false, 0, 0;
end

function pFishing:CoRacTrongRuong() -- return 1-0
	for j = 1396, 1415 do
		if me.GetItemCountInBags(18,1,j,1) > 0 then
			return 1;
		end
	end
	return 0;
end

function pFishing:DemCaTrongRuong()
	local nRt = 0;
	for i = 1365,1389 do
		nRt = nRt + me.GetItemCountInBags(18,1,i,1);
	end
	return nRt;
end

function pFishing:KiemTraCanCau()
	for i = 1,5 do
		if me.GetItemCountInBags(18,1,1390,i) > 0 then
			local tbFind = me.FindItemInBags(18,1,1390,i);
			for _, tbItem in pairs(tbFind) do
				return tbItem.pItem; -- có cần câu, trả về pItem
			end
		end
	end
	return 0; -- không có cần câu
end

function pFishing:DiMuaVatPham(nShopID, nSoLuong)
	me.Msg("Đi mua "..nShopID.." x"..nSoLuong.."");
	if UiManager:WindowVisible(Ui.UI_SHOP) == 0 then
		local nTalkLine = 6;
		if me.GetTask(2174,1) == me.GetTask(2174,37) then -- đã nhận NV của tuần này, dòng nhận nv sẽ ko hiện
			nTalkLine = 5;
		end
		local szLink = ","..(me.GetMapTemplateId())..",3642,"..nTalkLine.."";
		UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
		nDelay = 2;
	else -- UI_SHOP == 1
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			nDelay = 1;
			return;
		end
		if nShopID ~= 0 then -- đi mua vật phẩm
			me.ShopBuyItem(nShopID, nSoLuong);
			UiManager:CloseWindow(Ui.UI_SHOP);
		elseif nShopID == 0 then -- đi bán vật phẩm
			UiManager:CloseWindow(Ui.UI_SHOP);
		end
	end
end

function pFishing:DiMuaCanCau()
	self:DiMuaVatPham(nShopID_CanCau,1);
end

function pFishing:DiMuaMoiCau(nNum)
	self:DiMuaVatPham(nShopID_MoiTinhChe,nNum);
end

function pFishing:DiToiTanOaMap(nMapId,szTalkLine)
	if not szTalkLine then
		szTalkLine = "";
	end
	local szLink = ","..nMapId..",3642"..szTalkLine.."";
	UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
end

local tCmd={"Map.pFishing:OnStart()", "Fsg", "", "Shift+Z", "Shift+Z", "Fsg"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);