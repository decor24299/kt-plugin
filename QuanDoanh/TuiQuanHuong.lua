local TuiQuanHuong = Ui:GetClass("TuiQuanHuong");
TuiQuanHuong.State = 0
local nTimer = 0
local uiSayPanel = Ui(Ui.UI_SAYPANEL)
TuiQuanHuong.Say_bak = TuiQuanHuong.Say_bak or uiSayPanel.OnOpen
function uiSayPanel:OnOpen(tbParam)
	TuiQuanHuong.Say_bak(uiSayPanel,tbParam)
	if TuiQuanHuong.State == 0 then return end
	for i = 1,table.getn(tbParam[2]) do
		--me.Msg(tostring(tbParam[2][i]))
		if string.find(tbParam[2][i],"Túi Quân Hưởng") then
			me.AnswerQestion(i-1)
			return
		end
	end
end

function TuiQuanHuong._Start()
	if TuiQuanHuong.State == 0 then
		me.Msg("Mở auto nhận túi quân hưởng(Shift+R)")
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Mở Túi Quân Hưởng(Shift+R)<color><bclr>");
		nTimer = Ui.tbLogic.tbTimer:Register(18,TuiQuanHuong.OnTimer);
		TuiQuanHuong.State = 1
	else
		TuiQuanHuong.State = 0
		Ui.tbLogic.tbTimer:Close(nTimer);
		nTimer = 0
		me.Msg("Tắt auto nhận túi quân hưởng(Shift+R)")
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Tắt Túi Quân Hưởng(Shift+R)<color><bclr>");
	end
end

function TuiQuanHuong.UseItem()
	local tbFind = me.FindItemInBags(18,1,193,1);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,285,1);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,336,1);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(20,1,488,1);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		return 1
	end
	local tbFind = me.FindItemInBags(20,1,488,2);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		return 1
	end
end
function TuiQuanHuong.bCoTheNhanNhiemVu()
	local tbCampList = Task:GetMaxLevelCampTaskInfo(me);
	for _, tbInfo in ipairs(tbCampList) do
		if string.find(tbInfo[2],"Túi Quân Hưởng") then
			return true
		end
	end
	return false
end

function TuiQuanHuong.bDaNhanNhiemVu()
	local tbTask = Task:GetPlayerTask(me).tbTasks
	for nA,nB in pairs(tbTask or {}) do
		if string.find(Task:GetPlayerTask(me).tbTasks[nA].tbReferData.szName,"Túi Quân Hưởng") then
			return true
		end
	end
	return false
end

function TuiQuanHuong.OnTimer()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if TuiQuanHuong.State == 0 then 
		me.Msg("Tắt auto nhận túi quân hưởng")
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>Tắt Túi Quân Hưởng(Shift+R)<color><bclr>");
		Ui.tbLogic.tbTimer:Close(nTimer)
		return 
	end
	if TuiQuanHuong.UseItem() == 1 then return end


	if TuiQuanHuong.bCoTheNhanNhiemVu() or TuiQuanHuong.bDaNhanNhiemVu() then
		if me.GetMapTemplateId() ~= 29 and me.GetMapTemplateId() ~= 25 and me.GetMapTemplateId() ~= 24 then
			me.CallServerScript({"UseUnlimitedTrans", 29});
			TuiQuanHuong.GoTo(29,50944/32,131968/32)
		else
			local TuTuongNga = TuiQuanHuong.TimNPC_TEN("Từ Tường Nga")
			if TuTuongNga then
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
					AutoAi.SetTargetIndex(TuTuongNga.nIndex)
				end
			else
				me.CallServerScript({"UseUnlimitedTrans", 29});
				TuiQuanHuong.GoTo(me.GetMapTemplateId(),50944/32,131968/32)
			end
		end
		if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
			local uiGutAward = Ui(Ui.UI_GUTAWARD)
			uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
			UiManager:CloseWindow(Ui.UI_GUTAWARD)
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		return
	else
		if me.GetItemCountInBags(18,1,193,1) == 0 and me.GetItemCountInBags(18,1,285,1) == 0 and me.GetItemCountInBags(18,1,336,1) == 0 and me.GetItemCountInBags(20,1,488,1) == 0 and me.GetItemCountInBags(20,1,488,2) == 0 then 
			TuiQuanHuong.State = 0
		end
	end
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
end

function TuiQuanHuong.TimNPC_TEN(sName)
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
function TuiQuanHuong.GoTo(M,X,Y)
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	if nMapId == M and nMyPosX == X and nMyPosY == Y then
		--me.Msg("Đến rồi chạy chi nữa")
		return
	end
	if nLastMapId ~= M or nLastMapX ~= X or nLastMapY ~= Y then
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

Ui:RegisterNewUiWindow("UI_TuiQuanHuong", "TuiQuanHuong", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});
local tCmd={"Ui(Ui.UI_TuiQuanHuong):_Start()", "TuiQuanHuong", "", "Shift+R", "Shift+R", "dmmm"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
