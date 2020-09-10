
--local tbShopSell = Ui:GetClass("shopsell");


local tbShopSell = Ui(Ui.UI_SHOPSELL);
local EDT_NUMBER  		= "EdtNumber";

tbShopSell.OnOpen = function(self,pItem)
	if (not pItem) then
		return 0;
	end

	local tbNoSell = {
		{18,1,1446,1},  --chứng minh thủy sản
		{18,1,16,1},	--修炼珠
        {18,1,114,9},  --ht9
        {18,1,1,9},		--ht9
        {18,1,1,10},   --ht10
        {18,1,114,10},  --ht10
        {18,1,114,11},  --ht11
        {18,1,1,11},  --ht11
        {18,1,114,12},  --ht12
        {18,1,1,12},	 --ht12	
		{24,1,38,1}, --Tụ Văn Thạch (Cấp 1) 1x
        {24,1,39,1}, --Mộ Quang Thạch (Cấp 1) 3x
        {24,1,40,1}, --4x
        {24,1,41,1}, --Chất Cốc Thạch (Cấp 1) 5x
        {24,1,42,1}, --6x
        {24,1,43,1}, --7x
        {24,1,44,2}, --Đa Thái Thạch (Cấp 2) 9x
        {24,1,44,1}, --Đa Thái Thạch (Cấp 1) 9x
        {24,1,45,1}, --10x
        {24,1,46,1}, --11x
        {24,1,47,1}, --12x
        {24,1,50,1}, --Tinh Trần Thạch (Cấp 1) Mật Tich Cao		
        {24,1,50,2}, --Tinh Trần Thạch (Cấp 2) Mật Tich Cao
        {24,1,49,1}, --Thúy Ngự Thạch (Cấp 1) Mật Tich Trung		
        {24,1,49,2}, --Thúy Ngự Thạch (Cấp 2) Mật Tich Trung
        {24,1,24,4}, --Thương Lang Ngọc (tinh xảo) (cấp 4) Vật ngoại
        {24,1,24,5}, --Thương Lang Ngọc (lấp lánh) (cấp 5) Vật ngoại
        {24,1,24,6}, --Thương Lang Ngọc Óng Ánh (cấp 6) Vật ngoại
        {24,1,23,6}, --Độc Ngoại
        {24,1,25,6}, --Băng Ngoại
        {24,1,26,6}, --Lôi Ngoại
        {24,1,27,6}, --Hỏa Ngoại
        {24,1,28,6}, --Độc Nội
        {24,1,29,6}, --Vật Nội
        {24,1,30,6}, --Băng Nội
        {24,1,31,6}, --Lôi Nội
        {24,1,32,6}, --Hỏa Nội
        {24,1,56,6}, --Độc Ngoại , - Kháng
        {24,1,57,6}, --Vật Ngoại , - Kháng
        {24,1,58,6}, --Băng Ngoại , - Kháng
        {24,1,59,6}, --Lôi Ngoại , - Kháng
        {24,1,60,6}, --Độc Nội , - Kháng
        {24,1,62,6}, --Vật Nội , - Kháng
        {24,1,63,6}, --Băng Nội , - Kháng
        {24,1,64,6}, --Lôi Nội , - Kháng
        {24,1,65,6}, --Hỏa Nội , - Kháng
        {24,1,66,6}, --Kháng , - Chí Mạng
        {24,1,67,6}, --+ SL , - Kháng thơi gian bất lơi
        {24,1,68,6}, --Kháng thơi gian bất lơi + , - SL
        {24,1,35,6}, --+ Chí Mạng
        {24,1,36,6}, -- - Chí Mạng
        {24,1,1,6}, --Sinh Lực Cộng Điểm
        {24,1,2,6}, --Sinh Lực phần trăm
        {24,1,22,6}, --Kháng Tất Cả
        {24,1,3,6}, --Kháng Độc
        {24,1,4,6}, --Kháng Vật
        {24,1,5,6}, --Kháng Băng
        {24,1,6,6}, --Kháng Lôi
        {24,1,7,6}, --Kháng Hỏa
        {24,1,8,6}, --Kháng Thơi giang suy yếu
        {24,1,9,6}, --Kháng Thơi giang thọ thương
        {24,1,10,6}, --Kháng Thơi giang làm chậm
        {24,1,11,6}, --Kháng Thơi giang choáng
        {24,1,12,6}, --Kháng Thơi giang bỏng
        {24,1,13,6}, --Kháng tỉ lệ suy yếu
        {24,1,14,6}, --Kháng tỉ lệ thọ thương
        {24,1,15,6}, --Kháng tỉ lệ làm chậm
        {24,1,16,6}, --Kháng tỉ lệ choáng
        {24,1,17,6}, --Kháng tỉ lệ bỏng
        {24,1,18,6}, --Kháng Thơi giang trạng thái bất lợi
        {24,1,19,6}, --Kháng tỉ lệ trạng thái xấu
        {24,1,20,6}, --Thơi giang trạng thái bất lợi +
        {24,2,21,6}, --Tỉ lệ trạng thái bất lợi
        {24,1,33,6}, --Thời Gian Hiệu Quả Ngũ Hành +
        {24,1,34,6}, --Tỉ lệ trạng thái ngũ hành
        {24,1,53,1}, --Thiên Hương Y Nhân ( tăng đam quái )
        {24,1,37,1}, --Điểm Dật Thạch( tăng EXP )
		}

	for i,tbItem in ipairs(tbNoSell) do
		local g,d,p,l = unpack(tbItem);
		if pItem.nGenre == g and pItem.nDetail == d
			and pItem.nParticular == p and pItem.nLevel == l then
			me.Msg("Hạn chế việc bán các mặt hàng này")
			return 0
		end
	end


	Wnd_SetFocus(self.UIGROUP, EDT_NUMBER);
	self.pItem = pItem;
	self.nNum  = 1;

	if pItem.IsBind() == 1 or pItem.nGenre == 24 then		
		 self.szUnit = "Bạc khóa";
	else
		 self.szUnit = "Bạc";
	end

	if pItem.nEnhTimes > 0 then
		me.Msg("Không thể bán trang bị đã cường hóa!");
		return 0;
	end

	if pItem.IsPartnerEquip() == 1 and pItem.IsBind() == 1 then
		me.Msg("Trang bị thuê không thể bán cho cửa hàng");
		return 0;
	end

	self.nPrice = me.GetShopSellItemPrice(pItem);
	if (not self.nPrice) then
		me.Msg("Vật phẩm này không thể bán!");
		return 0;
	end

	if me.IsAccountLock() == 1 then
		me.Msg("Bạn đang trong trạng thái khóa, không thể bán vật phẩm!");
		Account:OpenLockWindow();
		return 0;
	end

	if pItem.IsEquip() == 1 then
		self.nMaxNumber = 1;
	else
		self.nMaxNumber = me.GetItemCountInBags(pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel, pItem.nSeries, pItem.IsBind());
	end

	self:UpdatePanel();
end
