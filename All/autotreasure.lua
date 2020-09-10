local mission1 = 1;
local tbWaBao	= UiManager
local nwabaoState = 0;
local hlWaTimeId = 0;
local hlWaShiJian = 2;
local hlNowTu = 0;
local hlNowTuMap = 0;
local hlNowTuX = 0; 
local hlNowTuY = 0;
local hlNowTuFlg = 0; 
local hlJDFlg = 0;
local nRunning = 0;
local hlSelect = 0;
local nWaitTimes = 0;
local hlBaoS = {
	[1]={18,1,9,1},
	[2]={18,1,9,2},
	[3]={18,1,9,3},
	[4]={18,1,10,1},
	};
local nCount = {};
local hlXiang = {};
local tCmd	= [=[
		UiManager:hhStartWaBao();
	]=];
UiShortcutAlias:AddAlias("GM_S1", tCmd);

function tbWaBao:Status()
	return hlWaTimeId
end

function tbWaBao:hhStartWaBao()
    if hlWaTimeId == 0 then 
		SysMsg("<bclr=0,0,200><color=white>Bật tự đào kho báu [Ctrl+1]<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Hệ thống tự đào kho báu khởi động<color><bclr>");
		nWaitTimes = 0;
		hlNowTuFlg = 0;
		hlJDFlg = 0;
        hlWaTimeId = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, tbWaBao.onWaBaoTime, self);
	else
		SysMsg("<bclr=red><color=yellow>Tắt  tự đào kho báu [Ctrl+1]<color><bclr>");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=white>Hệ thống tự đào kho báu kết thúc<color><bclr>");
        Ui.tbLogic.tbTimer:Close(hlWaTimeId);
		hlWaTimeId = 0;
	end
end

function tbWaBao:findNpcByName(name)
    local arroundNpcs = KNpc.GetAroundNpcList(me, 50)
	for _, npc in ipairs(arroundNpcs) do
		if (npc and npc.szName == name) then
			return npc
		end
	end
	return
end

function tbWaBao:goTo(m , x, y)
	local pos = {}
	pos.szType = "pos"
	pos.szLink = "," .. m .. "," .. x .. "," ..y
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink, pos)
end

function tbWaBao:hhEndWaBao()
    if hlWaTimeId ~= 0 then 
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blue><color=white>Hệ thống tự đào kho báu kết thúc<color><bclr>");
        Ui.tbLogic.tbTimer:Close(hlWaTimeId);
		hlWaTimeId = 0
	end
end

function tbWaBao:countItem(a, b, c, d)
	local count = 0
	local tbFind = me.FindItemInBags(a, b, c, d)
	
	for _, tbItem in pairs(tbFind) do
		count = count + 1
	end

	return count
end

function tbWaBao:useFirstItem(a, b, c, d)
	local tbFind = me.FindItemInBags(a, b, c, d)
	
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem)
		return
	end
end

function tbWaBao:goToNpc(id, name)
	local npc = tbWaBao:findNpcByName(name)

	if npc then
		AutoAi.SetTargetIndex(npc.nIndex)
		return
	else
		local x, y = KNpc.ClientGetNpcPos(me.GetMapTemplateId(), id)
		tbWaBao:goTo(me.GetMapTemplateId(), x, y)
	end
end

function tbWaBao:onWaBaoTime()
	tbWaBao:thuDaoLac()
end

function tbWaBao:thuDaoLac()
	if mission1 == 1 then
		local npc = tbWaBao:findNpcByName("Tử Thư Thanh")

		if npc then
			AutoAi.SetTargetIndex(npc.nIndex)
			mission1 = mission1 + 1
			return
		else
			local x, y = KNpc.ClientGetNpcPos(me.GetMapTemplateId(), 10152)
			tbWaBao:goTo(me.GetMapTemplateId(), x, y)
		end
	end

	if mission1 == 2 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
			mission1 = mission1 + 1
			return
		end
	end

	if mission1 == 3 then
		local npc = tbWaBao:findNpcByName("Tử Thư Thanh")

		if npc then
			AutoAi.SetTargetIndex(npc.nIndex)
			mission1 = mission1 + 1
			return
		else
			local x, y = KNpc.ClientGetNpcPos(me.GetMapTemplateId(), 10152)
			tbWaBao:goTo(me.GetMapTemplateId(), x, y)
		end
	end

	if mission1 == 4 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
			mission1 = mission1 + 1
			return
		end
	end

	if mission1 == 5 then
		local npc = tbWaBao:findNpcByName("Cành đào")
		me.Msg(type(npc))

		if npc then
			AutoAi.SetTargetIndex(npc.nIndex)
			mission1 = mission1 + 1
			return
		else
			tbWaBao:goTo(me.GetMapTemplateId(), 1710, 3210)
		end
	end

	if mission1 == 6 then
		local count = tbWaBao:countItem(20, 1, 926 , 1)

		if (count == 1) then
			local npc = tbWaBao:findNpcByName("Tử Thư Thanh")

			if npc then
				if tbWaBao:IsMoving() == 0 then
					tbWaBao:useFirstItem(20, 1, 926, 1)
					mission1 = mission1 + 1
					return
				end
			else
				local x, y = KNpc.ClientGetNpcPos(me.GetMapTemplateId(), 10152)
				tbWaBao:goTo(me.GetMapTemplateId(), x, y)
			end
		end
	end

	if mission1 == 7 then
		local count = tbWaBao:countItem(20, 1, 926 , 1)

		if count == 0 then
			tbWaBao:useFirstItem(20, 1, 927, 1)
			mission1 = mission1 + 1
			return
		end
	end

	if mission1 == 8 then
		local npc = tbWaBao:findNpcByName("Hứa Sĩ Vĩ")

		if npc then
			AutoAi.SetTargetIndex(npc.nIndex)
			mission1 = mission1 + 1
			return
		else
			local x, y = KNpc.ClientGetNpcPos(me.GetMapTemplateId(), 3583)
			tbWaBao:goTo(me.GetMapTemplateId(), x, y)
		end
	end

	if mission1 == 9 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
			mission1 = mission1 + 1
			tbWaBao:hhEndWaBao()
			return
		end
	end
end

function tbWaBao:setWaBaoState()
	if hlJDFlg == 0 then
		if nwabaoState == 11 then
			return;
		end
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				hlNowTu = tbItem
				local hlIsJianDing = hlNowTu.pItem.GetGenInfo(TreasureMap.ItemGenIdx_IsIdentify);
				if hlIsJianDing ~= 1 then 
					me.Msg("Chưa xác định, bây giờ phải xác định !");
					nwabaoState = 11
					nWaitTimes = 0
					return;
				end
			end
		end
		hlJDFlg = 1;
		nWaitTimes = 0
	end
	if hlNowTuFlg ==  0 then
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				hlSelect = 0
				hlNowTu = tbItem;
				local nTmapID = hlNowTu.pItem.GetGenInfo(2);
				hlNowTuFlg = 1;
				nwabaoState = 1;
				local pTabFile = KIo.OpenTabFile("\\setting\\task\\treasuremap\\treasuremap_pos.txt");
				hlNowTuMap = pTabFile.GetInt(nTmapID+1,4);
				hlNowTuX = pTabFile.GetInt(nTmapID+1,5);
				hlNowTuY = pTabFile.GetInt(nTmapID+1,6);
				local szTmap_Name	= pTabFile.GetStr(nTmapID+1,7);
				KIo.CloseTabFile(pTabFile);
				me.Msg("Đã tìm thấy trong <color=yellow>"..szTmap_Name.."<color> bản đồ kho báu")
	                        return;	
			end
		end
		nwabaoState = 88;
		return;
	end
	if (nWaitTimes == 0) then
		local nCount_FreeBag = me.CountFreeBagCell();
		local bFlag = 0 
		for i = 1,5 do
			nCount[i] = me.GetItemCountInBags(18,1,1,i)
			if nCount[i] > 3 then
				bFlag=1
			end
		end
		for i = 1,5 do
			nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
			if nCount[i] > 3 then
				bFlag=1
			end
		end
		if (nCount_FreeBag < 5 and bFlag == 1)then
			nwabaoState = 6 
			return;
		end
	end
	tbWaBao:IsMoving();
	local nAtNpcPos = tbWaBao:IsArrival()
	if (nAtNpcPos == 1) or (me.nAutoFightState == 1) then
		nwabaoState = 2;
	elseif (nRunning == 0) then
		nwabaoState = 1;
	else
		nwabaoState = 5;
	end 
end
function tbWaBao:MyFindItem2(g,d,p,l,bOffer,count,p1)
	local k = 0
	for nCont = 1, 11 do
		for j = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nLine - 1 do
			for i = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].tbObjs[j][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end

	return 0;
end
function tbWaBao:hlCutTu(nTempId)
		for i,tbBao in pairs(hlBaoS) do
			local tbFind = me.FindItemInBags(unpack(tbBao));
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
	                        return;	
			end
		end
end
function tbWaBao:GetAroundNpcId(nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end
function tbWaBao:GetAroundXiang()
	hlXiang = {};
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 30);
	local hlXiangIndex = 0
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == 2680) then --bảo rương cổ
			hlXiangIndex = hlXiangIndex + 1
			hlXiang[hlXiangIndex] = pNpc
		end
	end
end
function tbWaBao:IsArrival()
	local nDistance = tbWaBao:GetNpcDistance();
	if (me.nMapId == hlNowTuMap and nDistance <= 2) then
		return 1;
	end
	return 0;
end
function tbWaBao:GetNpcDistance()
	local nPosX = hlNowTuX;
	local nPosY = hlNowTuY;
	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = (nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2;
	return nDistance;
end
function tbWaBao:IsMoving()
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		return 1
	end

	return 0
end
function tbWaBao:Sample()
end
function tbWaBao:OpenExtBag()	
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX);
	end	
	local tbItemBox = Ui(Ui.UI_ITEMBOX);	
	local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
	tbExtBagLayout:Show();     -- đánh mở túi mở rộng  
end