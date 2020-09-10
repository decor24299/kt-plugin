--cyberdemon--
function table.find(tbSrc, varValue)
	for k,v in ipairs(tbSrc) do
		if v == varValue then
			return k, v;
		end
	end
	return nil;
end

function Player:ItemSort_Compare(pItem1, pItem2, tbSortRule)
	if not pItem1 and pItem2 then return -1; end;
	if pItem1 and not pItem2 then return 1; end;
	if not pItem1 and not pItem2 then return 0; end;
	local nRetVal = nil;
	for i, v in ipairs(tbSortRule) do
		local pFun = tbSortRule[i];
		nRetVal = pFun(self,pItem1,pItem2);
		if (nRetVal ~= 0) then break; end;
	end
	return nRetVal;
end

function Player:ItemSort_CompareValue(var1, var2)
	if var1 < var2 then
		return 1;
	elseif var1 == var2 then
		return 0;
	else
		return -1;
	end
end

function Player:ItemSort_CompareGenre(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.nGenre, pItem2.nGenre);
end

function Player:ItemSort_CompareLevel(pItem1, pItem2)
	local n1 = pItem1.nLevel;
	local n2 = pItem2.nLevel;
	if pItem1.szClass == "treasuremap" then
		n1 = n1 + pItem1.GetGenInfo(TreasureMap.ItemGenIdx_nTreaaureId);
	end
	if pItem2.szClass == "treasuremap" then
		n2 = n2 + pItem2.GetGenInfo(TreasureMap.ItemGenIdx_nTreaaureId);
	end

	return Player:ItemSort_CompareValue(n1, n2);
end

function Player:ItemSort_CompareName(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.szName, pItem2.szName);
end

function Player:ItemSort_CompareClass(pItem1, pItem2)
	return Player:ItemSort_CompareValue(pItem1.szClass, pItem2.szClass);
end

function Player:ItemSort_CompareItemId(pItem1, pItem2)
	if not (pItem1 or pItem2) then 
		return true;
	elseif  not (pItem1 and pItem2) then
		return false;
	elseif pItem1.dwId == pItem2.dwId then
		return true;
	end
end

function Player:ItemSort_CompareItemName(pItem1, pItem2)
	if not (pItem1 or pItem2) then 
		return true;
	elseif  not (pItem1 and pItem2) then 
		return false;
	elseif pItem1.szName == pItem2.szName then
		return true;
	end;
end