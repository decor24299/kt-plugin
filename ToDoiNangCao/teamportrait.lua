-------------------------------------------------------------------------------------------------
--修 改 者	：	※无痕※
--修改时间	：	2010-04-10
--原文件名	：	teamportrait.lua
-------------------------------------------------------------------------------------------------
local uiTeamPortrait = Ui(Ui.UI_TEAMPORTRAIT);
uiTeamPortrait.MENU_ITEM = { " Mật ", " Xem ",  " Giao dịch ", " Theo ", " Rời đội ", " Thêm bạn ", " Chuyển quyền ", " Trục xuất ", " càn khôn phù" };

local BTNCallTeam		= "BtnCallTeam"
--local BTNCallTeamone		= "BtnCallTeamone"
--local BTNCallTeamtwo		= "BtnCallTeamtwo"
local bShowLevel = 1
local nTimerId
local bak = uiTeamPortrait.HideTalk;
local tbTimer = Ui.tbLogic.tbTimer;

uiTeamPortrait.PO_WND = {
	{"Member1_PoPo", "Member1_PoPo_Txt"},
	{"Member2_PoPo", "Member2_PoPo_Txt"},
	{"Member3_PoPo", "Member3_PoPo_Txt"},
	{"Member4_PoPo", "Member4_PoPo_Txt"},
	{"Member5_PoPo", "Member5_PoPo_Txt"},
};

uiTeamPortrait.IMG_PORTRAIT = 
{
	[0] = "image\\ui\\002a\\teamportrait\\icon_male.spr",
	[1] = "image\\ui\\002a\\teamportrait\\icon_female.spr",
};

uiTeamPortrait.GetFactionShortName = function(self,nFact)
	local sRet
	if nFact == 1 then
		sRet = "TL"
	elseif nFact == 2 then
		sRet = "TV"
	elseif nFact == 3 then
		sRet = "ĐM"
	elseif nFact == 4 then
		sRet = "NĐ"
	elseif nFact == 5 then
		sRet = "NM"
	elseif nFact == 6 then
		sRet = "TY"
	elseif nFact == 7 then
		sRet = "CB"
	elseif nFact == 8 then
		sRet = "TN"
	elseif nFact == 9 then
		sRet = "VĐ"
	elseif nFact == 10 then
		sRet = "CL"
	elseif nFact == 11 then
		sRet = "MG"
	elseif nFact == 12 then
		sRet = "ĐT"
	elseif nFact == 13 then
		sRet = "CM"
	elseif nFact == 14 then
		sRet = "td"
	end
	return sRet
end

uiTeamPortrait.GetMapShortName = function(self,szMap)
	szMap = string.gsub(szMap, "Bàn Long Cốc Chiến", "BLCC");
	szMap = string.gsub(szMap, "Cửu Khúc Chiến", "CKC");
	szMap = string.gsub(szMap, "Phượng Tường", "PT");
	szMap = string.gsub(szMap, "Tiêu Dao Cốc", "TDC");
	szMap = string.gsub(szMap, "Phục Ngưu Sơn Quân Doanh", "PNS QD");
	szMap = string.gsub(szMap, "Báo Danh Chiến Trường", "BD CT");
	szMap = string.gsub(szMap, "Bạch Hổ Đường", "BHĐ");
	szMap = string.gsub(szMap, "Đấu trường môn phái", "ĐTMP");
	szMap = string.gsub(szMap, "Hải Lăng Vương Mộ", "HLVM");
	szMap = string.gsub(szMap, "Bách Man Sơn", "BMS");
	szMap = string.gsub(szMap, "Hậu Sơn Phục Ngưu", "HSPN");
	szMap = string.gsub(szMap, "Vạn Hoa Cốc (phó bản)", "VHC");
	szMap = string.gsub(szMap, "Thiên Quỳnh Cung (phó bản)", "TQC");
	szMap = string.gsub(szMap, "Đại Mạc Cổ Thành (phó bản)", "ĐMCT");
	szMap = string.gsub(szMap, "Đào Chu Công (phó bản)", "ĐCC");
	szMap = string.gsub(szMap, "Bách Niên Thiên Lao (phó bản)", "BNTL");
	return szMap;
end

uiTeamPortrait.FACTION_FLAG =
{
	[0] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\wumenpai.spr",
	[1] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\shaolin.spr",
	[2] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\tianwang.spr",
	[3] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\tangmen.spr",
	[4] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\wudu.spr",
	[5] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\ermei.spr",
	[6] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\cuiyan.spr",
	[7] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\gaibang.spr",
	[8] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\tianren.spr",
	[9] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\wudang.spr",
	[10] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\kunlun.spr",
	[11] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\mingjiao.spr",
	[12] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\duanshi.spr",
	[13] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\gumu.spr",
	[14] = "\\image\\ui\\002a\\teamportrait\\imgportrait2\\xiaoyao.spr",
};

uiTeamPortrait.OnButtonClick_Bak = uiTeamPortrait.OnButtonClick_Bak or uiTeamPortrait.OnButtonClick
uiTeamPortrait.OnButtonClick=function(self, szWndName, nParam)
	if szWndName == BTNCallTeam then
		Map.tbAutoGuessNum:Select(0);
	elseif szWndName == BTNCallTeamone then
        SendChannelMsg("Team","theo sau");
	elseif szWndName == BTNCallTeamtwo then
		Map.tbAutoGuessNum:Select(1);
	else
		for i = 1, #self.PORTRAIT_WND do
			if self.PORTRAIT_WND[i][8] == szWndName then
				self:OnPopUpMenu(szWndName, nParam);
				return;
			end
		end
	end
	self:OnButtonClick_Bak(szWndName, nParam);
end

uiTeamPortrait.HideTalk=function(self)
	uiTeamPortrait:GetMemberBaseData();
	bak(self);
end

uiTeamPortrait.GetMemberBaseData = function(self)
	local tbMember = me.GetTeamMemberInfo();
	local nMemberCount = #tbMember;
	for i = 1, #self.PORTRAIT_WND do
		if tbMember[i] and tbMember[i].szName and tbMember[i].nPlayerID then
			-- 显示头像
			self.m_tbPlayerId[i] = tbMember[i].nPlayerID;
			Img_SetImage(self.UIGROUP, self.PORTRAIT_WND[i][2], 1, self.IMG_PORTRAIT[tbMember[i].nSex]);
			Prg_SetPos(self.UIGROUP, self.PORTRAIT_WND[i][3], tbMember[i].nCurLife / 100 * 1000);
			Prg_SetPos(self.UIGROUP, self.PORTRAIT_WND[i][4], tbMember[i].nCurMana / 100 * 1000);
			-- 设置Tip提示
			local szFaction = Player:GetFactionRouteName(tbMember[i].nFaction);
			if szFaction == "" then
				szFaction = ""
			end
			local szName = GetMapNameFormId(tbMember[i].nMapId)
			if not szName then
				szName = ""
			end
			if szName == "" then
				szName = ""
			elseif szName == "" then
				szName = ""
			elseif szName == "" then
				szName = ""
			elseif szName == " " then
				szName = ""
			elseif szName == "" then
				szName = ""
			elseif szName == "" then
				szName = ""
			elseif szName == "" then
				szName = ""
			end
			Wnd_SetTip(self.UIGROUP, self.PORTRAIT_WND[i][2], string.format("Level：%d phái ：%s vị trí ：%s", tbMember[i].nLevel, szFaction, szName));
			-- 在线状况
			if tbMember[i].nOnline == 0 then
				Txt_SetTxtColor(self.UIGROUP, self.PORTRAIT_WND[i][5], 0xc0c0c0);
				Img_SetFrame(self.UIGROUP, self.PORTRAIT_WND[i][2], 1);
			else
				Txt_SetTxtColor(self.UIGROUP, self.PORTRAIT_WND[i][5], 0x80d0a0);
				Img_SetFrame(self.UIGROUP, self.PORTRAIT_WND[i][2], 0);
			end
			--虫子
			local szBuf
			if self.bShowLevel and self.bShowLevel == 0 then
				szBuf = string.format("%s",tbMember[i].szName);
			else
				szBuf = string.format("%s\n\n<color=0xCCCC99>\%s %d - %s",tbMember[i].szName, szFaction, tbMember[i].nLevel, szName);
			end
			if tbMember[i].nLeader == 1 then
				szBuf = "<color=0xffff68>"..szBuf;	-- 队长
			end
			Txt_SetTxt(self.UIGROUP, self.PORTRAIT_WND[i][5], szBuf)
			Img_SetImage(self.UIGROUP, self.PORTRAIT_WND[i][6], 1, self.FACTION_FLAG[tbMember[i].nFaction]);
			Wnd_Show(self.UIGROUP, self.PORTRAIT_WND[i][1]);
			if UiVersion ~= Ui.Version001 then
				Wnd_Show(self.UIGROUP, self.PORTRAIT_WND[i][9]);
			end	
		else
			Txt_SetTxt(self.UIGROUP, self.PORTRAIT_WND[i][5], "");
			Wnd_Hide(self.UIGROUP, self.PORTRAIT_WND[i][1]);
			if UiVersion ~= Ui.Version001 then
				Wnd_Hide(self.UIGROUP, self.PORTRAIT_WND[i][9]);
			end			
		end
	end
	-- 阵法
	local tbZhenFa = me.GetZhenFaInfo();
	if (not tbZhenFa) then
		return;
	end;

	Wnd_SetPos(self.UIGROUP, self.ZHENFA_WND[1], 2, (nMemberCount + 1) * 34);
	Img_SetImage(self.UIGROUP, self.ZHENFA_WND[1], 1, self.ZHENGFA_SPR[tbZhenFa.nLevel + 1]);
	Wnd_Show(self.UIGROUP, self.ZHENFA_WND[1]);
end

uiTeamPortrait.OnPopUpMenu = function(self, szWnd, nParam)
	local nPlayer = nil;											-- 判断菜单属于第几个队友
	for i = 1, #self.PORTRAIT_WND do
		for j = 1, #self.PORTRAIT_WND[i] do
			if szWnd == self.PORTRAIT_WND[i][j] then
				nPlayer = i;
				break;
			end
		end
	end
	if (nPlayer) then
		local tbMember = me.GetTeamMemberInfo();
		if tbMember[nPlayer].nOnline ~= 0 then						-- 如果在线者弹出菜单
			local tbRelationList, _ = me.Relation_GetRelationList();
			local tbFrined = tbRelationList[Player.emKPLAYERRELATION_TYPE_BIDFRIEND];
			local bFriend, bTeamLeader = 0, 0;
			if tbFrined then
				for szPlayer, _ in pairs(tbFrined) do      			-- 判断是否好友
					if (tbMember[nPlayer].szName == szPlayer) then
						bFriend = 1;                  				-- 是自己好友
					end
				end
			end
			local tbTmpFrined = tbRelationList[Player.emKPLAYERRELATION_TYPE_TMPFRIEND]; -- 判断是否是临时好友
			if tbTmpFrined then
				for szPlayer, _ in pairs(tbTmpFrined) do
					if (tbMember[nPlayer].szName == szPlayer) then
						bFriend = 1;                  									 -- 是自己临时好友
					end
				end
			end
			if (self:IsTeamLeader() == 1)  then
					bTeamLeader = 1;								-- 自己不是队长
			end
			self.tbMenuFun[9] = tbMember[nPlayer];					-- 被选中的玩家信息放入 第9项
			if (bFriend == 0) and (bTeamLeader == 0) then			-- 显示加为好友, 不显示队长移交和踢出队伍
				self.tbMenuFun[6] = {self.CmdAddFriend}
				self.tbMenuFun[7] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 7, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[6], 6,
					self.MENU_ITEM[9], 7
				);
			end
			if (bFriend == 0) and (bTeamLeader == 1) then			-- 显示加为好友, 显示队长移交和踢出队伍
				self.tbMenuFun[6] = {self.CmdAddFriend}
				self.tbMenuFun[7] = {self.CmdChangeLeader}
				self.tbMenuFun[8] = {self.CmdKickOut}
				self.tbMenuFun[10] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 9, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[6], 6,
					self.MENU_ITEM[7], 7,
					self.MENU_ITEM[8], 8,
					self.MENU_ITEM[9], 9
				);
			end
			if (bFriend == 1) and (bTeamLeader == 0) then			-- 不显示加为好友, 不显示队长移交和踢出队伍
				self.tbMenuFun[6] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 6, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[9], 6
				);
			end
			if (bFriend == 1) and (bTeamLeader == 1) then			-- 不显示加为好友, 显示队长移交和踢出队伍
				self.tbMenuFun[6] = {self.CmdChangeLeader}
				self.tbMenuFun[7] = {self.CmdKickOut}
				self.tbMenuFun[8] = {self.Runto}
				DisplayPopupMenu(self.UIGROUP, szWnd, 8, nParam,
					self.MENU_ITEM[1], 1,
					self.MENU_ITEM[2], 2,
					self.MENU_ITEM[3], 3,
					self.MENU_ITEM[4], 4,
					self.MENU_ITEM[5], 5,
					self.MENU_ITEM[7], 6,
					self.MENU_ITEM[8], 7,
					self.MENU_ITEM[9], 8
				);
			end
		end
	end
end

uiTeamPortrait.OnMenuItemSelected=function(self,szWnd, nItemId, nListIndex)
	if nItemId and nItemId <= #self.MENU_ITEM then
		if self.tbMenuFun[nItemId] then
			if nItemId<9 then
				self.tbMenuFun[nItemId][1](self, self.tbMenuFun[9]);
			else
				self.Runto(self, self.tbMenuFun[9])
			end
		end		
	end
end

uiTeamPortrait.Runto=function(self,mPlayer)
	me.Msg("Bám Đít  "..mPlayer.szName);	
	local tbItem	= me.FindItemInBags(18,1,85,1)[1];
	local pItem = (tbItem or {}).pItem;
	if (not pItem) then
		me.Msg("")
		return;
	end
	me.UseItem(pItem);
	local function fnAnswer()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			for i, tbInfo in ipairs(tbAnswers) do
				if string.find(tbInfo, mPlayer.szName) then
					me.AnswerQestion(i - 1);
				end
			end
		end
		return 0;
	end
	local function CloseWindow()
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		return 0
	end
	Ui.tbLogic.tbTimer:Register(13, fnAnswer);
	Ui.tbLogic.tbTimer:Register(23, CloseWindow);
end

uiTeamPortrait.MinProtraitWindow=function(self)
	if self.m_bHidePortrait == 1 then
		Wnd_Show(self.UIGROUP, self.PORTRAIT_WINDOW);
		self.m_bHidePortrait = 0;
		if self.bShowLevel then
			if self.bShowLevel == 1 then
				self.bShowLevel = 0
			else
				self.bShowLevel = 1
			end
			uiTeamPortrait.GetMemberBaseData(self)
		else
			self.bShowLevel = 1
		end
		if self.bShowLevel and self.bShowLevel == 1 then
			self.nTimerId = Ui.tbLogic.tbTimer:Register(30, self.GetMemberBaseData, self);
		end
	else
		Wnd_Hide(self.UIGROUP, self.PORTRAIT_WINDOW);
		self.m_bHidePortrait = 1;
		Ui.tbLogic.tbTimer:Close(self.nTimerId);
	end
end

LoadUiGroup(Ui.UI_TEAMPORTRAIT, "teamportrait.ini");