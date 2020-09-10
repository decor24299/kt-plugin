-----------------------------------------------------
local tbMgr = UiManager;
function tbMgr:SwitchUiModel(nModel)
	if nModel then
		self.nCurUiModel = nModel;
	else
		self.nCurUiModel = math.mod(self.nCurUiModel + 1, 3);
	end
	
	if UiManager:WindowVisible(Ui.UI_CHATNEWMSG) ==1 then
		UiManager:CloseWindow(Ui.UI_CHATNEWMSG);
	end
	
	
	if self.nCurUiModel == 0 then
		local tbTempData = Ui.tbLogic.tbTempData;
		Open("map", tbTempData.nMiniMapState + 5); -- TODO: huangxin +5 为了把状态0 和参数0区分开 非常龊 会整理
		Open("playerbar", 1);
		self:OpenWindow(Ui.UI_SIDEBAR);
		self:OpenWindow(Ui.UI_SKILLBAR);
		self:OpenWindow(Ui.UI_SHORTCUTBAR);
		self:OpenWindow(Ui.UI_PLAYERSTATE);
		self:OpenWindow(Ui.UI_BUFFBAR);
		self:OpenWindow(Ui.UI_TASKTRACK);
		self:OpenWindow(Ui.UI_SNS_ENTRANCE);
		self:OpenWindow(Ui.UI_POPBAR);
		if UiVersion == Ui.Version002 then
			self:OpenWindow(Ui.UI_EXPBAR);
			self:OpenWindow(Ui.UI_SIDESYSBAR);
			self:OpenWindow(Ui.UI_PKMODEL);
		end
		self:OpenWindow(Ui.UI_SERVERSPEED);
		if (self:WindowVisible(Ui.UI_MSGPAD) ~= 1) then
			self:OpenWindow(Ui.UI_MSGPAD);
		end
		if (self:WindowVisible(Ui.UI_GLOBALCHAT) ~= 1) then
			self:OpenWindow(Ui.UI_GLOBALCHAT);
		end
		self:OpenWindow(Ui.UI_MESSAGEPUSHVIEW);
		if (self:WindowVisible(Ui.UI_BTNMSG) ~= 1) then
			self:OpenWindow(Ui.UI_BTNMSG);
		end
	elseif self.nCurUiModel == 1 then
		Open("map", 0);
		Open("playerbar", 0);
		self:OpenWindow(Ui.UI_SIDEBAR);
		self:OpenWindow(Ui.UI_SKILLBAR);
		self:OpenWindow(Ui.UI_SHORTCUTBAR);
		self:OpenWindow(Ui.UI_PLAYERSTATE);
		self:OpenWindow(Ui.UI_BUFFBAR);
		self:CloseWindow(Ui.UI_POPBAR);
		self:CloseWindow(Ui.UI_SERVERSPEED);
		if UiVersion == Ui.Version002 then
			self:OpenWindow(Ui.UI_EXPBAR);
			self:OpenWindow(Ui.UI_SIDESYSBAR);
			self:OpenWindow(Ui.UI_SERVERSPEED);
			self:CloseWindow(Ui.UI_PKMODEL);
		end
		self:CloseWindow(Ui.UI_TASKTRACK);
		self:CloseWindow(Ui.UI_GLOBALCHAT);
		self:CloseWindow(Ui.UI_SNS_ENTRANCE);
		self:CloseWindow(Ui.UI_MESSAGEPUSHVIEW);
		UiCallback:HideMsgPad()
	elseif self.nCurUiModel == 2 then
		Open("map", -1);
		self:CloseWindow(Ui.UI_POPBAR);
		self:CloseWindow(Ui.UI_SIDEBAR);
		self:CloseWindow(Ui.UI_SKILLBAR);
		self:CloseWindow(Ui.UI_SHORTCUTBAR);
		self:CloseWindow(Ui.UI_PLAYERSTATE);
		self:CloseWindow(Ui.UI_BUFFBAR);
		self:CloseWindow(Ui.UI_TASKTRACK);
		self:CloseWindow(Ui.UI_GLOBALCHAT);
		self:CloseWindow(Ui.UI_SNS_ENTRANCE);
		self:CloseWindow(Ui.UI_SERVERSPEED);
		if UiVersion == Ui.Version002 then
			self:CloseWindow(Ui.UI_EXPBAR);
			self:CloseWindow(Ui.UI_SIDESYSBAR);
			self:CloseWindow(Ui.UI_PKMODEL);
		end
		self:CloseWindow(Ui.UI_MESSAGEPUSHVIEW);	
		UiCallback:HideMsgPad()
	end

end


tbMgr.OnPressESC_Bak = tbMgr.OnPressESC_Bak or tbMgr.OnPressESC;
function tbMgr:OnPressESC()
	if (self:WindowVisible(Ui.UI_CAPTURE_SCREEN) == 1) then
		self:CloseWindow(Ui.UI_CAPTURE_SCREEN);
		return;
	elseif 1 == self:WindowVisible(Ui.UI_EQUIPCOMPOSE) and 1 ~= Ui(Ui.UI_EQUIPCOMPOSE):CanDirectClose() then
		return;
	elseif (self:WindowVisible(Ui.UI_WORLDMAP_SUB) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_SUB)
		return;
	elseif (self:WindowVisible(Ui.UI_WORLDMAP_AREA) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_AREA)
		return;
	elseif (self:WindowVisible(Ui.UI_WORLDMAP_GLOBAL) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_GLOBAL)
		return;
	end

	if (self:WindowVisible(Ui.UI_SCHOOLDEMO) == 1) then
		self:CloseWindow(Ui.UI_SCHOOLDEMO)
		return;
	end

	if (self:WindowVisible(Ui.UI_WORLDMAP_DOMAIN) == 1) then
		self:CloseWindow(Ui.UI_WORLDMAP_DOMAIN)
		return;
	end

	if (self:WindowVisible(Ui.UI_TEXTINPUT) == 1) then
		self:CloseWindow(Ui.UI_TEXTINPUT)
		return
	end

	if (self:WindowVisible(Ui.UI_JBEXCHANGE) == 1) then
		self:CloseWindow(Ui.UI_JBEXCHANGE)
		return
	end

	if (self:WindowVisible(Ui.UI_IBSHOPCART) == 1) then
		self:CloseWindow(Ui.UI_IBSHOPCART)
		return
	end	

	if (self:WindowVisible(Ui.UI_IBSHOP) == 1) then
		self:CloseWindow(Ui.UI_IBSHOP)
		return
	end

	if (self:WindowVisible(Ui.UI_LEVELUPGIFT) == 1) then
		self:CloseWindow(Ui.UI_LEVELUPGIFT)
		return
	end

	if (CloseWndsInGame() == 0 and self:WindowVisible(Ui.UI_ITEMBOX) == 0) then
		if (self:WindowVisible(Ui.UI_SKILLPROGRESS) == 0) then
				self:SwitchWindow(Ui.UI_SYSTEMEX);
		else
			me.BreakProcess();
		end
	end

	if (self:WindowVisible(Ui.UI_ITEMBOX) == 1) then
		self:CloseWindow(Ui.UI_ITEMBOX);
		return;
	end
end


tbMgr.OnEnterGame_Bak = tbMgr.OnEnterGame_Bak or tbMgr.OnEnterGame;
function tbMgr:OnEnterGame()
    SendChannelMsg("NearBy", "<enter><color=green>Plugins fix by zllSóillz - Thanh Long Kiếm!!");
	UiManager:OpenWindow("UI_INFOBOARD","<pic=99><bclr=pink><color=yellow>Bạn đang dùng Plugins fix by zllSóillz - Thanh Long Kiếm <pic=99>");	
	Ui.tbWnd[Ui.UI_BUTTONE88]:SetJM1()
	self:OpenWindow(Ui.UI_BUTTOND);	
	self:SwitchWindow(Ui.UI_TOOLS1);  --luôn hiện thanh tự ăn vật phẩm
	self:SwitchWindow(Ui.UI_TOOLS); --luôn hiện thanh TOOLS khi vào game
	self:SwitchWindow(Ui.UI_TCTBAR); --luôn hiện thanh 1.lua
	self:SwitchWindow(Ui.UI_AutoQuanDoanh);  --luôn hiện thanh tổ đội
	 self:SwitchWindow(Ui.UI_TOOLtd);
	--self:SwitchWindow(Ui.UI_TOOL95); --luôn hiện thanh TOOLS khi vào game
	--self:SwitchWindow(Ui.UI_TOOL); --luôn hiện thanh TOOL khi vào game
   	--Ui(Ui.UI_NGUNGCONGDON):Start();
	Ui(Ui.UI_tbTTP):State();
	--Ui(Ui.UI_tbCKP):State();
	--Map.uiDetector:Switch(); --- báo boss
	UiManager.OnOpen();
	UiManager:CloseWindow(Ui.UI_JINGHUOFULIEX);
	--self:CloseWindow(Ui.UI_ITEMBOX);
	self:OnEnterGame_Bak();
end


function tbMgr:OnNoOperation()
	if (Player.tbOffline:CanSleep() == 1) then
		ExitGame();
	end
end

