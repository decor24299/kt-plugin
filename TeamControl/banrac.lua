-- ====================== quochuy ======================

--local tbbanrac	= UiManager
local tbTimer = Ui.tbLogic.tbTimer;
local tbbanrac	= Map.tbbanrac or {};
Map.tbbanrac		= tbbanrac;

local self = tbbanrac

self.nbanracClock = 0; 
local nbanracState = 0;
local nbanracPutFlg = 0;

local Sundry = {

	[1] = {18,1,114,1},	    --huyền tinh 1	
	[2] = {18,1,114,2},	    --huyền tinh 2	
	[3] = {18,1,114,3},	    --huyền tinh 3	
	[4] = {18,1,114,4},    --huyền tinh 4	
	[5] = {18,1,114,5},    --huyền tinh 5
	[6] = {18,1,114,6},    --huyền tinh 6
	[7] = {18,1,114,7},    --huyền tinh 7	
    [8] = {18,1,1313,1},   --Khoáng thạch Tinh Anh Hiệp Dũng	
    [9] = {18,1,1316,1},   --Khoáng thạch tiêu dao kì bảo
	[10] = {18,1,1452,1},   --Lam Điền Ngọc
	[11] = {18,1,1452,10},  --Lam Điền Khoáng chưa chạm trổ
	[12] = {18,1,1235,1},   --Vật Báu Lâu Lan-Bích Ngọc (Cấp 1)
    [13] = {18,1,1236,1},   --Vật Báu Lâu Lan-Nhã Từ (Cấp 1)
    [14] = {18,1,1235,2},   --Vật Báu Lâu Lan-Linh Tinh (Cấp 2)
    [15] = {18,1,1236,2},   --Vật Báu Lâu Lan-Bạch Ngọc (Cấp 2)
    [16] = {18,1,1235,3},   --Vật Báu Lâu Lan-Minh Châu (Cấp 3)
    [17] = {18,1,1236,3},   --Vật Báu Lâu Lan-Lưu Ly (Cấp 3)
	[18] = {18,1,252,1},    --Rương tranh đoạt lãnh thổ
	[19] = {22,1,41,1},     --Tử Tinh Nguyên Thạch
    [20] = {22,1,35,1},     --Tiên Linh Nguyên Mộc
    [21] = {22,1,43,1},     --Tiên Linh Quả
    [22] = {22,1,39,1},     --Linh Thú Huyết
    [23] = {22,1,37,1},     --Da lông Linh Thú
	[24] = {18,1,290,3},     --Rương vàng bị khóa
	[25] = {18,1,1314,1},   --Khoáng thạch Nhân Dũng Hoàng Lăng
	[26] = {18,1,84,1},	--Lệnh Bài Nghĩa Quân
	[27] = {18,1,2118,4},	--- Trục luyện nón
	[28] = {18,1,1997,1},	--- Trục luyện nón
	[29] = {22,1,69,1},		--- Quả thu hoạch
	[30] = {22,1,11,10}, 	----Bạch long tu [hoạt khí cấp 10]
	[31] = {22,1,9,10},	------Tuyết liên [bổ huyết cấp 10]
	[32] = {18,1,2118,8},	--- Trục luyện nón
	[33] = {18,1,1,1},    --huyền tinh 1
	[34] = {18,1,1,2},    --huyền tinh 2
	[35] = {18,1,1,3},    --huyền tinh 3
	[36] = {18,1,1,4},    --huyền tinh 4
	[37] = {18,1,1,5},    --huyền tinh 5
	[39] = {24,1,38,1,1}, ----đá 1,2
	[40] = {24,1,38,2,1},
	[41] = {24,1,39,1,1},
	[42] = {24,1,39,2,1},
	[43] = {24,1,40,1,1},
	[44] = {24,1,40,2,1},
	[45] = {24,1,41,1,1},
	[46] = {24,1,41,2,1},
	[47] = {24,1,42,1,1},
	[48] = {24,1,42,2,1},
	[49] = {24,1,43,1,1},
	[50] = {24,1,43,2,1},
	[51] = {24,1,44,1,1},
	[52] = {24,1,44,2,1},
	[53] = {24,1,45,1,1},
	[54] = {24,1,45,2,1},
	[55] = {24,1,46,1,1},
	[56] = {24,1,46,2,1},
	[57] = {24,1,47,1,1},
	[58] = {24,1,47,2,1},
	[59] = {24,1,48,1,1},
	[60] = {24,1,48,2,1},
	[61] = {24,1,49,1,1},
	[62] = {24,1,49,2,1},
	[63] = {24,1,50,1,1},
	[64] = {24,1,50,2,1},
	[65] = {18,1,1,6},    --huyền tinh 6
	[66] = {18,1,20261,1},
	[67] = {18,1,20449,1}, --Rương càng khôn
	
	
	
};

local tCmd={ "Map.tbbanrac:banrac()", "banrac", "", "Shift+C", "Shift+C", "Bán Rác"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
local szCmd = [=[
	Map.tbbanrac:banrac();
]=];
function tbbanrac:banrac()
	if self.nbanracClock == 0 then
		nbanracPutFlg = 0;
		self:GetbanracState();
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bật Tự động bán rác<color>");
		self.nbanracClock = tbTimer:Register(Env.GAME_FPS, self.banracTime, self);
	else
		tbTimer:Close(self.nbanracClock);
		self.nbanracClock = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt Tự động bán rác<color>");
	end
end

function tbbanrac:GetbanracState()
	local ncount1 = 0;
	for i,tbFitem in pairs(Sundry) do
		ncount1 = ncount1 + me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
	end
	if ncount1 > 0 then
		nbanracState = 1;
		return;
	end
	nbanracState = 0;
end

function tbbanrac:banracTime()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end	
	if nbanracState == 0 then
		self:banrac();
	elseif nbanracState >= 99 then 
		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			UiManager:CloseWindow(Ui.UI_SHOP);
			UiManager:CloseWindow(Ui.UI_ITEMBOX);			
		end	
		self:GetbanracState();
	elseif nbanracState == 1 then 
		self:banracSellItem();		
	end
end

function tbbanrac:banracSellItem()
	local nId = me.CallServerScript({"ApplyKinSalaryOpenShop", 241}); 
	if nId then
		if (UiManager:WindowVisible(SALA_SILVERSHOP) ~= 1) then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)				
			for i,tbFitem in pairs(Sundry) do
				local tbFind = me.FindItemInBags(unpack(tbFitem));
				for j, tbItem in pairs(tbFind) do
					local num = me.GetItemCountInBags(tbFitem[1],tbFitem[2],tbFitem[3],tbFitem[4]);
					me.ShopSellItem(tbItem.pItem, num);
					return;
				end
			end
			nbanracState = 99;
		    end	 
	    end
    end
end
