--cyberdemon--
local bIsSorting = false;
local nTimerId;
local tbCells;

function Player:ItemSort_SortRepository()
	local tbRepository = Ui(Ui.UI_REPOSITORY);
	Player:ItemSort_Begin(Item.ROOM_REPOSITORY);
	me.Msg("<color=green>Bắt đầu sắp xếp")	
end

function Player:ItemSort_Begin(nStartContainerId)
	if not bIsSorting then
		bIsSorting = true;
	else
		return;
	end
	self.nSortContainerId = nStartContainerId;
	self.tbSortRule = {self.ItemSort_CompareGenre,self.ItemSort_CompareClass,self.ItemSort_CompareLevel,self.ItemSort_CompareName};
	nTimerId = Timer:Register(0.1 * Env.GAME_FPS, self.ItemSort_OnSort, self);
end

function Player:ItemSort_End()
	Timer:Close(nTimerId);
	nTimerId = nil;
	bIsSorting = false;
    me.Msg("<color=green>Đã sắp xếp xong")
end

function Player:ItemSort_OnSort()
	tbCells = Player:ItemSort_GetAllCells(self.nSortContainerId);
	if (tbCells[1].nContainerId == Item.ROOM_REPOSITORY) and (UiManager.tbUiState[UiManager.UIS_OPEN_REPOSITORY] == 0 ) then
		Player:ItemSort_End();
		self.nSortContainerId = 0;
	end
	for i = 1, table.getn(tbCells) do
		local pItem1 = me.GetItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
		local tbItemMVI = {pItemMVI = pItem1, nNum = i};
		for j = i + 1, table.getn(tbCells) do
			local pItem2 = me.GetItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn);
			if (pItem1 and pItem2) then
				local _, _nTimeOut1 = pItem1.GetTimeOut();
				local _, _nTimeOut2 = pItem2.GetTimeOut();
				if (pItem1.IsStackable() == 1 and _nTimeOut1 == 0) and (pItem2.IsStackable() == 1 and _nTimeOut2 == 0) then
					if (Player:ItemSort_CompareItemName(pItem1,pItem2)) and (pItem1.nCount ~= pItem1.nMaxCount) then
						if (pItem1.IsBind() == pItem2.IsBind()) then
							me.SwitchItem(tbCells[j].nContainerId, tbCells[j].nRow, tbCells[j].nColumn,
								tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn);
							return;
						end
					end
				end
			end
			if (Player:ItemSort_Compare(tbItemMVI.pItemMVI, pItem2, self.tbSortRule) == -1)	then
				tbItemMVI.pItemMVI = pItem2;
				tbItemMVI.nNum = j;
			end
		end
		if (tbItemMVI.nNum ~= i) then
			me.SwitchItem(tbCells[i].nContainerId, tbCells[i].nRow, tbCells[i].nColumn,
				tbCells[tbItemMVI.nNum].nContainerId, tbCells[tbItemMVI.nNum].nRow, tbCells[tbItemMVI.nNum].nColumn);
			return;
		end;
	end
	Player:ItemSort_End();
end
