
local uiTrade	 = Ui(Ui.UI_TRADE);
local tbObject   = Ui.tbLogic.tbObject;
local tbMouse    = Ui.tbLogic.tbMouse;
local tbTimer	 = Ui.tbLogic.tbTimer;
local tbSaveData = Ui.tbLogic.tbSaveData;
local tbMsgInfo  = Ui.tbLogic.tbMsgInfo;
local tbConfirm  = Ui.tbLogic.tbConfirm;

uiTrade.OBJ_TRADE 					= "ObjTrade";
uiTrade.SELF_MONEY_EDIT 			= "EditSelfSilver";
uiTrade.OTHER_CONTAINER 			= "ObjPlayerTradeArea";
uiTrade.OTHER_MONEY_TEXT			= "TxtPlayerSilverNum";
uiTrade.LOCK_TRADE_BUTTON			= "BtnLockTrade";
uiTrade.AFFIRM_TRADE_BUTTON			= "BtnAffirmTrade";
uiTrade.CANCEL_TRADE_BUTTON			= "BtnCancelTrade";
uiTrade.TRADE_HISTORY_LIST			= "LstTradeHistory";
uiTrade.CHECK_CODE_TEXT				= "TxtCheckCode";
uiTrade.OTHER_PLAYER_INFO_TEXT		= "TxtPlayerInfo";
uiTrade.TRADE_STATE_TEXT			= "TxtTradeState";
uiTrade.TXT_TITLE					= "TxtWindowTitle";
uiTrade.HISTORY_SCORLLBAR			= "ScrbarHistory";
uiTrade.CLOSE_BUTTON				= "BtnClose";
uiTrade.TXT_OTHER_COIN				= "TxtPlayerOtherCoin";
uiTrade.EDIT_COIN					= "EditSelfCoin";
uiTrade.TEXT_SELF_MONEY				= "TextSelfSilver";
uiTrade.TRADE_HISTORY_DIR			= "user\\history\\trade\\";
uiTrade.MAX_TRADE_HISTORY_COUNT		= 5;
uiTrade.TRADE_FREEZE_TIME           = 6;
uiTrade.DATA_KEY					= "TradeHistory";

local tbTradeCont = { bUse = 0, bLink = 0, nRoom = Item.ROOM_TRADE, bSendToGift = 1 };
local tbShowCont = { bShowCd = 0, bUse = 0, bLink = 0, bSwitch = 0 };

uiTrade.OnOpen=function(self)
	tbObject:UnregContainer(self.tbTradeCont);
	self.tbTradeCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_TRADE,
		Item.ROOM_TRADE_WIDTH,
		Item.ROOM_TRADE_HEIGHT,
		tbTradeCont,
		"itemroom"
	);
	self:WriteStatLog();
	self:UpdateTradeState();
	self.nFreezeTime = self.TRADE_FREEZE_TIME;
	UiManager:SetUiState(UiManager.UIS_TRADE_PLAYER);
	UiManager:OpenWindow(Ui.UI_ITEMBOX);
end

uiTrade.UpdateTradeState=function(self)
	if (self.nSelfLockState == 0) then
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Bắt đầu giao dịch");
		Btn_Check(self.UIGROUP, self.LOCK_TRADE_BUTTON, 0);
		Btn_Check(self.UIGROUP, self.AFFIRM_TRADE_BUTTON, 0);
		Wnd_SetEnable(self.UIGROUP, self.LOCK_TRADE_BUTTON, 1);
		Wnd_SetEnable(self.UIGROUP, self.AFFIRM_TRADE_BUTTON,	0);
		Wnd_SetEnable(self.UIGROUP, self.OBJ_TRADE, 1);
		Edt_SetInt(self.UIGROUP, self.SELF_MONEY_EDIT, self.nTradeMoney);
		Edt_SetInt(self.UIGROUP, self.EDIT_COIN, self.nTradeCoin);
		Wnd_SetEnable(self.UIGROUP, self.SELF_MONEY_EDIT, 1);
		Wnd_SetEnable(self.UIGROUP, self.EDIT_COIN, 1);
		Wnd_SetEnable(self.UIGROUP, self.OTHER_MONEY_TEXT, 0);		
		Wnd_SetVisible(self.UIGROUP, self.TEXT_SELF_MONEY, 0);
		Wnd_SetVisible(self.UIGROUP, self.SELF_MONEY_EDIT, 1);
	else
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Đợi đối phương khóa");
		Btn_Check(self.UIGROUP, self.LOCK_TRADE_BUTTON, 1);
		Wnd_SetEnable(self.UIGROUP, self.LOCK_TRADE_BUTTON, 0);
		Wnd_SetEnable(self.UIGROUP, self.OBJ_TRADE, 0);		
		local szMoney = Item:FormatMoney(self.nTradeMoney) .. " lượng";
		Edt_SetTxt(self.UIGROUP, self.SELF_MONEY_EDIT, szMoney);
		Wnd_SetEnable(self.UIGROUP, self.SELF_MONEY_EDIT, 1);		
		local szCoin = Item:FormatMoney(self.nTradeCoin) .. " đồng";
		Edt_SetTxt(self.UIGROUP, self.EDIT_COIN, szCoin);
		Wnd_SetEnable(self.UIGROUP, self.EDIT_COIN, 0);		
		Txt_SetTxt(self.UIGROUP, self.TEXT_SELF_MONEY, szMoney);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_SELF_MONEY, 1);
		Wnd_SetVisible(self.UIGROUP, self.SELF_MONEY_EDIT, 1);
	end
	if (self.nOtherLockState == 1) then
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Đối phương đã khóa");
	end
	if (self.nSelfLockState == 1) and (self.nOtherLockState == 1) then
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Hai bên đã khóa");
		if (self.nTimerId == 0) and (self.nSelfConfirmState ~= 1) then
			self.nTimerId = tbTimer:Register(18, self.OnTimer, self);
		end
	end
	if (self.nOtherConfirmState == 1) then
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Đối phương đã xác nhận");
	end
	if (self.nSelfConfirmState == 1) then
		Txt_SetTxt(self.UIGROUP, self.TRADE_STATE_TEXT, "Đợi tiến hành giao dịch");
	end
end

uiTrade.OnTradeLock = function(self, nMoney, nCoin, szCheckCode)
	self.nLockMoney = nMoney;
	self.nLockCoin = nCoin;
	Txt_SetTxt(self.UIGROUP, self.CHECK_CODE_TEXT, szCheckCode);
	self:AddTradeHistory(self.szPlayerName, szCheckCode);
	local szMoney = Item:FormatMoney(nMoney) .. "Bạc";
	local szCoin = "<color=yellow>" .. Item:FormatMoney(nCoin) .. "Đồng<color>";
	Txt_SetTxt(self.UIGROUP, self.OTHER_MONEY_TEXT, szMoney);
	Txt_SetTxt(self.UIGROUP, self.TXT_OTHER_COIN, szCoin);	
	for j = 0, Item.ROOM_TRADE_HEIGHT - 1 do
		for i = 0, Item.ROOM_TRADE_WIDTH - 1 do
			local pItem = me.GetItem(Item.ROOM_TRADECLIENT, i, j);
			local tbObj;
			if pItem then
				tbObj = {};
				tbObj.nType = Ui.OBJ_TEMPITEM
				tbObj.pItem = pItem;
			end
			self.tbShowItemCont:SetObj(tbObj, i, j)
		end
	end
	self.nOtherLockState = 1;
	self:UpdateTradeState();	
end

uiTrade.tbTradeCont.CanSendStateUse=function(self)
	return	1;
end

uiTrade.StateRecvUse=function(self,szUiGroup)
	if szUiGroup == self.UIGROUP then
		return;
	end
	if (UiManager:WindowVisible(self.UIGROUP) ~= 1) then
		return;
	end
	self.tbTradeCont:SpecialStateRecvUse();
end

uiTrade.RegistermyEvent=function(self)
	UiNotify:RegistNotify(UiNotify.emUIEVENT_OBJ_STATE_USE, self.StateRecvUse, self);
	UiNotify:RegistNotify(UiNotify.emCOREEVENT_TRADE_LOCK, self.OnTradeLock, self);
end
uiTrade:RegistermyEvent();