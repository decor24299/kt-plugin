--cyberdemon--
local tbZhenYuan   = Item:GetClass("zhenyuan");
local ATTRIB_COUNT = 4;	

function tbZhenYuan:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)
	local szTip = "";
	if Item.tbZhenYuan:GetEquiped(it) == 1 then
		szTip = szTip.."<color=yellow>Đã hộ thể<color>\n\n";
	else
		szTip = szTip.."<color=yellow>Chưa hộ thể<color>\n\n";
	end
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_LevelAndExp();
	szTip = szTip..self:Tip_AtribTip();
	szTip = szTip..self:Tip_Value();
	return szTip;
end

function tbZhenYuan:Tip_LevelAndExp()
	return string.format("\nCấp chân nguyên: %d [%d/%d]\n\n", 
		Item.tbZhenYuan:GetLevel(it), 
		Item.tbZhenYuan:GetCurExp(it), 
		Item.tbZhenYuan:GetNeedExp(Item.tbZhenYuan:GetLevel(it)));
end

function tbZhenYuan:Tip_AtribTip()
	local szTip = "<color=blue>Cấp sao thuộc tính và tư chất<color>\n\n";
	local tbBaseAttrib = it.GetBaseAttrib();
	local tbAttribEnhanced = Item.tbZhenYuan:GetAttribEnhanced(it, 0);
	for i = 1, ATTRIB_COUNT do
		local nStarLevel = Item.tbZhenYuan["GetAttribPotential"..i](Item.tbZhenYuan, it);
		local szStar = Item.tbZhenYuan:GetAttribStar(nStarLevel, 1);
		local szAttribTipName = Item.tbZhenYuan:GetAttribTipName(tbBaseAttrib[i].szName);
		local nBase = Item.tbZhenYuan["GetAttrib"..i.."Range"](Item.tbZhenYuan, it);
		local nAdd = math.floor(Item.tbZhenYuan:GetAttribMapValue(tbBaseAttrib[i].szName, tbAttribEnhanced[i]) + 0.5);
		nAdd = math.min(Item.tbZhenYuan.MAPPINGVALUE_MAX_ENHANCE, nAdd);
		local nSum = nBase + nAdd;
		local nId = Item.tbZhenYuanSetting.tbAttribNameToId[tbBaseAttrib[i].szName];
		local nMaxValue = Item.tbZhenYuanSetting.tbAttribSetting[nId].nMaxValue;
		local nRealValue = math.floor(nSum / 1000 * nMaxValue);
		local szDsc = Item.tbZhenYuanSetting.tbAttribSetting[nId].szTipDesc;
		local nAttribId = Item.tbZhenYuan:GetAttribMagicId(it, i);
		szTip = szTip..string.format("<color=green>%s: (%d + %d) = <color=yellow>%d<color>\n%s: <color=yellow>%s<color><color>\n\n",
		szAttribTipName, nBase, nAdd, nSum, szDsc, nRealValue);
		szTip = szTip..string.format("   %s\n", szStar);
	end
	return szTip;
end

function tbZhenYuan:Tip_Value()
	local szTip = "";
	szTip = szTip..string.format("\n<color=green>Tổng điểm chân nguyên: <color=yellow>%d<color><color>\n", Item.tbZhenYuan:GetZhenYuanValue(it)/10000);
	return szTip;
end