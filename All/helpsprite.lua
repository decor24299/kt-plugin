--cyberdemon--
local uiHelpSprite = Ui(Ui.UI_HELPSPRITE);
local nBindMoneyLogin		= 0
local nBindCionLogin		= 0
local nActiveMoneyLogin		= 0

uiHelpSprite.Get_Msg=function(self)
	local szListText = "";
	local tbYesOrNo =
		{
			[0] = "Chưa hoàn thành",
			[1] = "Hoàn thành",
		}
		
	szListText	= szListText .. "<bgclr=250,250,120,80><color=pink><div=400,20,0,0,0>★ Hoạt Động Sắp Diễn Ra★</div><color><bgclr>\r";
	local nNowWeek	= tonumber(GetLocalDate("%w"));
	local nTime = tonumber(GetLocalDate("%H%M"));
	if (nNowWeek == 2 or nNowWeek == 4) then
		if nTime < 1930 then
			szListText = szListText .. string.format("<goto=20><color=red>Thời gian bắt đầu báo danh Thi Đấu Môn Phái còn:<goto=300><color=yellow>%d<color> giờ <color=yellow>%d<color> phút",(1930-nTime)/100,math.mod(math.mod(1930-nTime+60,100),60)) .. "<linegap=5>\n";
		elseif (nTime >=1930 and nTime < 2000) then
			szListText = szListText .. string.format("<goto=20><color=yellow>Thời gian kết thúc báo danh Thi Đấu Môn Phái còn:<goto=300><color=yellow>%d<color> phút",math.mod(math.mod(2000-nTime+60,100),60)) .. "<linegap=5>\n";
		elseif (nTime >= 2000 and nTime < 2130) then
			szListText = szListText .. string.format("<goto=20><color=green>Hoạt động Thi Đấu Môn Phái đang diễn ra, hãy đợi lần sau") .. "<linegap=5>\n";
		elseif nTime > 2130 then
			szListText = szListText .. string.format("<goto=20><color=gray>Hoạt động Thi Đấu Môn Phái đã kết thúc tốt đẹp") .. "<linegap=5>\n";
		end
	end
	if me.nLevel>=90 then
		if nTime %100<10 then
			szListText = szListText .. string.format("<goto=20><color=yellow>Thời gian kết thúc báo danh Phó Bản Quân Doanh còn: <goto=300><color=yellow>%d<color> phút",10-math.mod(nTime,100)) .. "<linegap=5>\n";
		else
			szListText = szListText .. string.format("<goto=20><color=red>Thời gian bắt đầu báo danh Phó Bản Quân Doanh còn: <goto=300><color=yellow>%d<color> phút",60-math.mod(nTime,100)) .. "<linegap=5>\n";
		end
	end
	local nNextBattle	= 0;
	local tbBattleTime	= {
			{0050, 0100, 0150},
			{1050, 1100, 1150},
			{1250, 1300, 1350},
			{1450, 1500, 1550},
			{1650, 1700, 1750},
			{1850, 1900, 1950},
			{2050, 2100, 2150},
			{2250, 2300, 2350},
		};
	for _, tbTime in ipairs(tbBattleTime) do
		if nTime >= (tbTime[1]-100) and (nTime < tbTime[1]) then
			nNextBattle	= tbTime[1];
			szListText = szListText .. string.format("<goto=20><color=red>Thời gian bắt đầu báo danh Mông Cổ Tây Hạ còn:<goto=300><color=yellow>%d<color> giờ <color=yellow>%d<color> phút",(tbTime[1]-nTime)/100,math.mod(math.mod(tbTime[1]-nTime+100,100),60)) .. "<linegap=5>\n";
			break;
		elseif (nTime >= tbTime[1]) and nTime < (tbTime[1]+10) then
			szListText = szListText .. string.format("<goto=20><color=yellow>Thời gian bắt đầu hoạt động Mông Cổ Tây Hạ còn:<goto=300><color=yellow>%d<color> phút",math.mod(math.mod(tbTime[1]+10-nTime+60,100),60)) .. "<linegap=5>\n";
			break;
		elseif nTime >= (tbTime[1]+10) and nTime < (tbTime[1]+100) then
			szListText = szListText .. string.format("<goto=20><color=green>Hoạt động Mông Cổ Tây Hạ đang diễn ra, hãy tham gia ngay") .. "<linegap=5>\n";
			break;		
		end
	end
	local nNextBattle	= 0;
	local tbBattleTime	= {
			{0030,0100,0130},
			{0130,0200,0230},
			{0230,0300,0330},
			{0330,0400,0430},
			{0430,0500,0530},
			{0530,0600,0630},
			{0630,0700,0730},	
			{0830,0900,0930},
			{0930,1000,1030},
			{1030,1100,1130},
			{1130,1200,1230},
			{1230,1300,1330},
			{1330,1400,1430},
			{1430,1500,1530},
			{1530,1600,1630},
			{1630,1700,1730},
			{1730,1800,1830},
			{2130,2200,2230},
			{2230,2300,2330},
			{2330,0000,0030},
		};
	for _, tbTime in ipairs(tbBattleTime) do
		if	(nTime < tbTime[1]) then
			nNextBattle	= tbTime[1];
			szListText = szListText .. string.format("<goto=20><color=red>Thời gian bắt đầu báo danh Bạch Hổ Đường còn: <goto=300><color=yellow>%d<color> giờ <color=yellow>%d<color> phút",(tbTime[1]-nTime)/100,math.mod(math.mod(tbTime[1]-nTime+30,100),30)) .. "<linegap=5>\n";
			break;
		elseif 	(nTime >= tbTime[1]) and nTime < (tbTime[1]+30) then
			szListText = szListText .. string.format("<goto=20><color=yellow>Thời gian kết thúc báo danh Bạch Hổ Đường còn: <goto=300><color=yellow>%d<color> phút",60-math.mod(nTime,100)) .. "<linegap=5>\n";
			break;
		end
	end
	local nRestTime=0;
		nRestTime = 30 - (nTime % 100) % 30;
	if (nTime >= 1200 and nTime < 2300) or (nTime >= 0000 and nTime < 0200) then
		szListText = szListText .. string.format("<goto=20><color=yellow>Thời gian kết thúc báo danh Tiêu Dao Cốc còn: <goto=300><color=yellow>%d<color> phút",nRestTime) .. "<linegap=5>\n";
	end
	if nTime > 0200 and nTime < 1200 then
		szListText = szListText .. string.format("<goto=20><color=red>Thời gian bắt đầu báo danh Tiêu Dao Cốc còn: <goto=300><color=yellow>%d<color> giờ <color=yellow>%d<color> phút",(1200-nTime)/100,math.mod(math.mod(1200-nTime+60,100),60)) .. "<linegap=5>\n";
	end

	szListText	= szListText .. "<bgclr=250,250,120,80><color=pink><div=400,20,0,0,0>★ Việc trong tuần ★</div><color><bgclr>\r";
	local nLastXchgWeek	= me.GetTask(2080, 1);
	local nThisWeek		= Lib:GetLocalWeek(GetTime()) + 1
	if nLastXchgWeek == nThisWeek then
		szListText = szListText .. string.format("<goto=20><color=green>Tuần này đã đổi bạc khóa thành bạc chưa:<goto=300><color=yellow>Đã đổi<color>") .. "<linegap=5>\n";
	else
		szListText = szListText .. string.format("<goto=20><color=red>Tuần này đã đổi bạc khóa thành bạc chưa:<goto=300><color=yellow>Chưa đổi<color>") .. "<linegap=5>\n";
	end
	if (me.nLevel >= 60) then
		local nWeiwang = me.GetTask(2027, 55);
		local nCurWeek = tonumber(GetLocalDate("%Y%W"));
		if nCurWeek > me.GetTask(2027, 54) then
			nWeiwang = 0;
			end
			szListText = szListText .. "<goto=20>"
	if nWeek == nLastWeek then
		szListText = szListText .. "<color=green>Tuần này đã đổi uy danh thành đồng khóa chưa:<goto=300><color=yellow>Đã đổi<linegap=5>\n"
	else 
		szListText = szListText .. "<color=red>Tuần này đã đổi uy danh thành đồng khóa chưa:<goto=300><color=yellow>Chưa đổi<linegap=5>\n"
	end
		local nJunXuCount	= Battle:GetRemainJunXu();
			  szListText = szListText .. string.format("<goto=20><color=green>Số rương thuốc Mông Cổ Tây Hạ tích lũy trong tuần:<goto=300><color=yellow>%d rương<color>", nJunXuCount) .. "<linegap=5>\n";	
		end
	if me.nLevel >= 80 then
        local nTime = tonumber(os.date("%Y%m%d"));
	      local nLastTime = me.GetTask(2050, 53);
	      if nTime == nLastTime then
          szListText = szListText .. string.format("<goto=20><color=green>Hôm nay đã nhận rương thuốc Tiêu Dao Cốc chưa:<goto=300><color=yellow>Đã nhận<color>") .. "<linegap=5>\n";
        else
          szListText = szListText .. string.format("<goto=20><color=red>Hôm nay đã nhận rương thuốc Tiêu Dao Cốc chưa:<goto=300><color=yellow>Chưa nhận<color>") .. "<linegap=5>\n";
        end
    end 
	if (me.nLevel >= 60) then
		local nShanghui = me.GetTask(2036, 1);
		if	nShanghui==0 then
			szListText = szListText .. string.format("<goto=20><color=red>Nhiệm vụ Thương Hội tuần này:<goto=300><color=yellow>%s<color>", tbYesOrNo[nShanghui]) .. "<linegap=5>\n";
		else
			szListText = szListText .. string.format("<goto=20><color=green>Nhiệm vụ Thương Hội tuần này:<goto=300><color=yellow>Đã hoàn thành<color>", tbYesOrNo[nShanghui]) .. "<linegap=5>\n";
		end
	end
	if (me.nLevel >= 100) then
		local nHKCount = me.GetTask(XiakeDaily.TASK_GROUP,XiakeDaily.TASK_WEEK_COUNT);
		local nTaskWeek = me.GetTask(XiakeDaily.TASK_GROUP,XiakeDaily.TASK_WEEK);
		local nNowWeek = Lib:GetLocalWeek(GetTime());
			if nNowWeek ~= nTaskWeek then
				nHKCount = 0;
			end
		if nHKCount >= XiakeDaily.WEEK_MAX_TIMES then
			szListText = szListText .. string.format("<goto=20><color=green>Nhiệm vụ Hiệp Khách tuần này:<goto=300><color=yellow>Đã hoàn thành<color>") .. "<linegap=5>\n";
		else
			szListText = szListText .. string.format("<goto=20><color=red>Nhiệm vụ Hiệp Khách tuần này:<goto=300><color=yellow>%d<color> / 5",nHKCount) .. "<linegap=5>\n";
		end
	end
	if (me.nLevel >= 90) then
		local nFLS	= me.GetTask(1022, 200);
		local nBMS	= me.GetTask(1022, 201);
		local nHWM	= me.GetTask(1022, 202);
			szListText = szListText .. string.format("<goto=20><color=green>Nhiệm vụ Hành Trình Bất Tận tuần này:<color><goto=300>HS:<color=yellow>%d<color>/BMS:<color=yellow>%d<color>/HL:<color=yellow>%d<color>",nFLS,nBMS,nHWM) .. "<linegap=10>\n";
	end	
	if (me.nLevel >= 50) then
		local nTimes = XoyoGame:GetPlayerTimes(me);
			szListText	= szListText .. "<goto=20><color=green>Số lần vào Tiêu Dao Cốc trong tuần còn:" .. string.format("<goto=300><color=yellow>%d<color> / 14", nTimes) .. "<linegap=5>\n";
	end
	if (me.nLevel >= 90) then
		local nGutTaskTimes = Task.tbArmyCampInstancingManager:GetGutTaskTimesThisWeek(1, me.nId);
		szListText = szListText .. string.format("<goto=20><color=green>Số lần đã vào Phó Bản Quân Doanh - Chính tuyến:<goto=300><color=yellow>%d<color> / 4",nGutTaskTimes) .. "<linegap=5>\n";
	end

	if (me.nLevel >= 90) then
		local nDailyTask  = Task.tbArmyCampInstancingManager:GetDailyTaskTimesThisWeek(1, me.nId);
		szListText = szListText .. string.format("<goto=20><color=green>Số lần đã vào Phó Bản Quân Doanh - Hằng ngày:<goto=300><color=yellow>%d<color> / 28",nDailyTask) .. "<linegap=5>\n";
	end
	if (me.nLevel >= 25) then
		local nRemain = 0;
		local nTaxCount = 0;
		local nAmount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_AMOUNT_TASK_ID);
		if nAmount > TradeTax.TAX_REGION[1][1] then
			nTaxCount = me.GetTask(TradeTax.TAX_TASK_GROUP, TradeTax.TAX_ACCOUNT_TASK_ID)
		else
			nRemain = TradeTax.TAX_REGION[1][1] - nAmount;
	end
		local nTaxRate = 0;
		for i = 1, #TradeTax.TAX_REGION do
			if nAmount >= TradeTax.TAX_REGION[i][1] then
				if TradeTax.TAX_REGION[i + 1] then
					nTaxRate = TradeTax.TAX_REGION[i + 1][2];
				else
					nTaxRate = TradeTax.TAX_REGION_MAXNUMBER; 
				end
			end
		end
		szListText = szListText .."<goto=20><color=green>Tổng lượng bạc đã nhận trong trong tuần này:".. string.format("<goto=300><color=yellow>%.1f vạn bạc<color>\n<goto=30><color=green>Tiền miễn thuế còn:<goto=300><color=yellow>%.1f vạn bạc<color>\n<goto=30><color=green>Tiền đã nộp thuế:<goto=300><color=yellow>%.1f vạn bạc<color>\n<goto=30><color=green>Tỷ lệ thuế:<goto=300><color=yellow>Trên %.0f", nAmount/10000, nRemain/10000, nTaxCount/10000, nTaxRate*100).."%<linegap=5>\n";
	end
	
	szListText	= szListText .. "<bgclr=250,250,120,80><color=pink><div=400,20,0,0,0>★ Võ Lâm Liên Đấu ★</div><color><bgclr>\r";
	local nSession	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION);
	local nTotle= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE);
	local nWin	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN);
	local nTie	= me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE);
	local szSession = "<goto=300><color=yellow>Chưa tham đấu"
	if nSession > 0 and Wlls.SEASON_TB[nSession] then
		szSession = string.format("%s %s", Lib:Transfer4LenDigit2CnNum(nSession), Wlls.SEASON_TB[nSession][4]);
	szListText	= szListText .. string.format("<goto=20><color=green>Hình thức liên đấu:\n<goto=30><color=yellow>%s<linegap=5>\n", szSession);
	else
	szListText	= szListText .. string.format("<goto=20><color=green>Tham gia võ lâm liên đấu:<goto=300><color=red>%s<linegap=5>\n", szSession);
	end
	szListText	= szListText .. string.format("<goto=20><color=green>Tổng số trận:<goto=300><color=yellow>%s<color> / 48<linegap=5>\n", nTotle);

	szListText	= szListText .. string.format("<goto=30><color=green>Số trận thắng:<goto=300><color=yellow>%s<linegap=5>\n", nWin);

	szListText	= szListText .. string.format("<goto=30><color=green>Số trận hòa:<goto=300><color=yellow>%s<linegap=5>\n", nTie);

	szListText	= szListText .. string.format("<goto=30><color=green>Số trận thua:<goto=300><color=yellow>%s<linegap=5>\n", (nTotle-nWin-nTie));
	
	szListText	= szListText .. "<bgclr=250,250,120,80><color=pink><div=400,20,0,0,0>★ Nhân Vật ★</div><color><bgclr>\r";

	local nSmallXisui	= me.GetTask(2040, 6);
	local nMidXisui		= me.GetTask(2040, 9);
	local nSmallWulin	= me.GetTask(2040, 5);
	local nMidWulin		= me.GetTask(2040, 8);
	local nBigWulin		= me.GetTask(2040, 10);
	local nBigXisui		= me.GetTask(2040, 11);
	local nBig2Xisui	= me.GetTask(2040, 20);
	local nBig2Wulin	= me.GetTask(2040, 21);
	szListText = szListText .. string.format("<goto=20><color=green>Tẩy Tủy Kinh - sơ:<goto=300><color=yellow>%d<color> / 5", nSmallXisui) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Tẩy Tủy Kinh - trung:<goto=300><color=yellow>%d<color> / 5", nMidXisui) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Võ Lâm Mật Tịch - sơ:<goto=300><color=yellow>%d<color> / 5", nSmallWulin) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Võ Lâm Mật Tịch - trung:<goto=300><color=yellow>%d<color> / 5", nMidWulin) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Bánh ít bát bảo:<goto=300><color=yellow>%d<color> / 2", nBigXisui) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Bánh ít thập cẩm:<goto=300><color=yellow>%d<color> / 2", nBigWulin) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Thái Vân Truy Nguyệt:<goto=300><color=yellow>%d<color> / 2", nBig2Xisui) .. "<linegap=5>\n";
	szListText = szListText .. string.format("<goto=20><color=green>Thượng Hải Nguyệt Minh:<goto=300><color=yellow>%d<color> / 2", nBig2Wulin) .. "<linegap=5>\n";
	
	szListText	= szListText .. "<bgclr=250,250,120,80><color=pink><div=400,20,0,0,0>★ Ủy Thác ★</div><color><bgclr>\r";
	if (me.nLevel >= 20) then
		local nOfflineTime = Player.tbOffline:GetTodayRestOfflineTime() / 3600;
		szListText	= szListText .. "<goto=20><color=green>Thời gian rời mạng hôm nay còn:<goto=300>" .. string.format("<color=yellow>%.1f<color> giờ", nOfflineTime) .. "<linegap=5>\n";

		for key, tbBaiju in ipairs(Player.tbOffline.BAIJU_DEFINE) do
			if (tbBaiju.nShowFlag == 1) then
				local nRestTime = me.GetTask(5, tbBaiju.nTaskId);
				szListText	= szListText .. "<goto=20><color=green>Thời giác ủy thác " .. tbBaiju.szName .. " còn lại:\n<goto=30>" .. Player.tbOffline:GetDTimeDesc(nRestTime) .. "<linegap=5>\n";
			end
		end
	end
	self:SetContentText(szListText);
end

function uiHelpSprite:OnOpen()
	if (GblTask:GetUiFunSwitch("UI_HELPSPRITE_ZHIDAO") == 0) then
		Wnd_Hide(self.UIGROUP, self.PAGE_BUTTON_KEY_STR..7);
	end
	self.tbFirstPageFold[1]		= 0;
	self.tbFirstPageFold[2]		= 0;
	self.tbFirstPageFold[3]		= 1;
	self.tbSearchResultBuf = {};
	self:WriteStatLog();
	if UiVersion == Ui.Version001 then
		Ui(Ui.UI_PLAYERSTATE):OnHelpOpen();
	end
	self.nCurPageIndex = 1;
	self:UpdatePage(1);
	self:SetStaticTxt();
	self:UpdateSysTime();
	self:Get_Msg();
end

uiHelpSprite.Link_command_OnClick=function(self,szWnd, szGroupId)
	self:ChatCommand();
end

uiHelpSprite.Link_GetMsg_OnClick=function(self,szWnd, szGroupId)
	self:Get_Msg();
end

uiHelpSprite.OnUpdatePage_Page1=function(self)
	local tbNeedInfo	= {};
	for key, nId in pairs(self.DNEWSID) do
		self.tbNewsInfo[-nId] = nil;
	end
	for nNewsId, tbNInfo in pairs(self.tbNewsInfo) do
		tbNeedInfo[#tbNeedInfo+1]	= self:GetNewsInfo(nNewsId);
	end
	if (Task.tbHelp.tbNewsList) then
		for key, tbDMews in pairs(Task.tbHelp.tbNewsList) do
			local nTime = GetTime();
			if (tbDMews.nEndTime > nTime and tbDMews.nEndTime > 0 and nTime >= tbDMews.nAddTime) then
				tbNeedInfo[#tbNeedInfo+1]	= {
					szName	= tbDMews.szTitle,
					nWeight	= 50000 - key,
					nId		= -1 * key,
					nKey		= key,
					bReaded	= Task.tbHelp:GetDNewsReaded(key),
				};
				self.tbNewsInfo[-1 * key]	= {
					szName		= tbDMews.szTitle,
					nLifeTime	= 0,
					varWeight	= 100,
					varContent	= tbDMews.szMsg,
				};
			end
		end
	end
	table.sort(tbNeedInfo, function(tb1, tb2) return tb1.nWeight > tb2.nWeight end);
	local szListText = string.format("<bgclr=250,250,120,80><color=pink><a=firstfold:%d><div=250,20,0,0,0>★ Tin mới nhất Kiếm Thế★</div><a><bgclr><linegap=5>\n", 1);
	if (self.tbFirstPageFold[1] == 1) then
		for _, tb in ipairs(tbNeedInfo) do
			if (tb.bReaded ~= 1) then
				szListText	= szListText .. "<pic=\\image\\ui\\001a\\main\\chatface\\116.spr><linegap=-15>\n<linegap=5>";
			else
				szListText	= szListText .. "   ";
			end
			szListText	= szListText .. string.format("<goto=20><a=news:%d>%s<a>\n<linegap=5>", tb.nId, tb.szName);
		end
	end
	szListText	 = szListText ..  string.format("<bgclr=250,250,120,80><color=pink><a=firstfold:%d><div=250,20,0,0,0>★ Thông tin tác giả ★</div><a><bgclr><linegap=5>\n", 2);
	if (self.tbFirstPageFold[2] == 1) then
		szListText =szListText..string.format("<color=purple><goto=20>Plugin Kiếm Thế \n<linegap=5>");
		szListText =szListText..string.format("<color=purple><goto=20>Fix by zllSóiz - Thanh Long Kiếm	\n<linegap=5>");		
		szListText =szListText..string.format("<color=purple><goto=20>Thanks for: All Coder\n<linegap=5>");
		szListText =szListText..string.format("<color=purple><goto=20>Đã giúp tôi hoàn thành Plugin này\n<linegap=5>");
	end
	szListText	= szListText .. string.format("<bgclr=250,250,120,80><color=pink><a=firstfold:%d><div=250,20,0,0,0>★ Việc trong ngày ★</div><a><bgclr><linegap=5>\n", 3);
	if (self.tbFirstPageFold[3] == 1) then
		local nJDay = me.GetTask(2024,1);
		local nJNum = me.GetTask(2024,2);
		local nHDay = me.GetTask(2024,3);
		local nHNum = me.GetTask(2024,4);
		local nJHCurDate = tonumber(os.date("%Y%m%d",GetTime()));
		local nCurFuyuan = me.GetTask(2147,245);
		if (nCurFuyuan == 280) then
			szListText	= szListText .. "<goto=20><color=green>Phúc duyên đã đạt mức tối đa, mau đổi thưởng<linegap=5>\n";	
		end
		if (nCurFuyuan >= 0) and (nCurFuyuan < 280) then
			szListText	= szListText .. "<goto=20><color=red>Phúc duyên hiện có:<goto=200>" .. string.format("<color=yellow>%d<color> / 280", nCurFuyuan) .. "<linegap=5>\n";
		end
		if nJDay ~= nJHCurDate then
			nJNum = 0;
		end
		if nHDay ~= nJHCurDate then
			nHNum = 0;
		end
		if (nJNum >= 5) then
			szListText	= szListText .. "<goto=20><color=green>Đã mua 5 tinh lực tiểu ưu đãi<linegap=5>\n";
		else
			szListText	= szListText .. "<goto=20><color=red>Tinh lực tiểu ưu đãi:<goto=200>" .. string.format("<color=yellow>%d<color> / 5", nJNum) .. "<linegap=5>\n";
		end
		if (nHNum >= 5) then
			szListText	= szListText .. "<goto=20><color=green>Đã mua 5 hoạt lực tiểu ưu đãi<linegap=5>\n";
		else
			szListText	= szListText .. "<goto=20><color=red>Hoạt lực tiểu ưu đãi:<goto=200>" .. string.format("<color=yellow>%d<color> / 5", nHNum) .. "<linegap=5>\n";
		end
		if (me.nLevel >= 50) then
		local nInDirFlag = me.GetTask(Task.tbPlayerPray.TSKGROUP, Task.tbPlayerPray.TSK_INDIRAWARDFLAG);
		local nPrayTimes = Task.tbPlayerPray:GetPrayCount(me);
		if (nInDirFlag == 1) then
			szListText	= szListText .. "<goto=20><color=yellow>Chưa nhận thưởng chúc phúc:<goto=200><a=openpray:>Nhận<a><linegap=5>\n";
		else
			if nPrayTimes > 0 then
				szListText	= szListText .. "<goto=20><color=red>Cơ hội chúc phúc còn:<goto=200>" .. string.format("<color=yellow><a=openpray:>%d lần<a>", nPrayTimes) .. "<linegap=5>\n";
			else
				szListText	= szListText .. "<goto=20><color=green>Đã hết cơ hội chúc phúc<linegap=5>\n";
			end
		end
		end
		local nFuCount, nFuLimit	= self:GetFuDaiCountAndLimit();
		if (nFuCount > nFuLimit) then
			szListText	= szListText .. "<goto=20><color=yellow>Số túi phúc mở trong ngày:<goto=200>" .. string.format("<color=yellow>%d<color> / %d", nFuCount, nFuLimit) .. "<linegap=5>\n";
		end
		if (nFuCount == nFuLimit) then
			szListText	= szListText .. "<goto=20><color=green>Số túi phúc mở trong ngày:<goto=200>" .. string.format("<color=yellow>%d<color> / %d", nFuCount, nFuLimit) .. "<linegap=5>\n";
		end
		if (nFuCount < nFuLimit) then
			szListText	= szListText .. "<goto=20><color=red>Số túi phúc mở trong ngày:<goto=200>" .. string.format("<color=yellow>%d<color> / %d", nFuCount, nFuLimit) .. "<linegap=5>\n";
		end
		if (me.nLevel >= 20) then
			local nBaoCount = self:GetBaoCount();
			if (nBaoCount >= 11) then
				szListText	= szListText .. "<goto=20><color=yellow>Bao Vạn Đồng:<goto=200>" .. string.format("<color=yellow>%d<color> / 10", nBaoCount) .. "<linegap=5>\n";
			end
			if (nBaoCount == 10) then
				szListText	= szListText .. "<goto=20><color=green>Bao Vạn Đồng:<goto=200>" .. string.format("<color=yellow>%d<color> / 10", nBaoCount) .. "<linegap=5>\n";
			end
			if (nBaoCount <= 9) then
				szListText	= szListText .. "<goto=20><color=red>Bao Vạn Đồng:<goto=200>" .. string.format("<color=yellow>%d<color> / 10", nBaoCount) .. "<linegap=5>\n";
			end
		end
		if (me.nLevel >= 50) then
			local nBaiCount = self:GetBaihutangCount();
			if (nBaiCount >= 1) then
				szListText	= szListText .. "<goto=20><color=green>Bạch Hổ Đường:<goto=200>" .. string.format("<color=yellow>%d<color> / 1", nBaiCount) .. "<linegap=5>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Bạch Hổ Đường:<goto=200>" .. string.format("<color=yellow>%d<color> / 1", nBaiCount) .. "<linegap=5>\n";
			end
		end
		if (me.nLevel >= 50) then
			local nTaskNum = me.GetTask(2040,2);
			if (nTaskNum == 0) then
			szListText	= szListText .. "<goto=20><color=green>Đã nhận hết nhiệm vụ Truy Nã<linegap=5>\n";
			else
			szListText	= szListText .. "<goto=20><color=red>Số nhiệm vụ truy nã trong ngày:<goto=200>" .. string.format("<color=yellow>%d", nTaskNum) .. "<linegap=5>\n";
			end
		end
		if (me.nLevel >= 30) then
			local nGetAward,nAllCount = GuessGame:GetAnswerCount(me);
			if (nAllCount >= 30) then
				szListText	= szListText .. "<goto=20><color=green>Đã trả lời đủ 30 Hoa Đăng<linegap=5>\n";
			else
				szListText	= szListText .. "<goto=20><color=red>Số câu trả lời Hoa Đăng:<goto=200>" .. string.format("<color=yellow>%d<color> / 30",nAllCount) .. "<linegap=5>\n";
			end
		end
		local nDayEnterFB = Task.tbArmyCampInstancingManager:EnterInstancingThisDay(1,me.nId);
			if (nDayEnterFB <= 0) then
			szListText = szListText .. "<goto=20><color=green>Đã hết lần vào Phó Bản Quân Doanh<linegap=5>\n";
		else
			szListText = szListText .. "<goto=20><color=red>Số lần vào Phó Bản Quân Doanh còn:<goto=200>" .. string.format("<color=yellow>%d<color> / 14", nDayEnterFB) .. "<linegap=5>\n";
		end
		if (me.nLevel >= 50) then
		local nTimes = 0;               
		local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
		local nTskDate = me.GetTask(2136, 2);
		if nTskDate == nCurDate then
			nTimes = me.GetTask(2136, 1);
		end
		nTimes = 10 - nTimes;
		if nTimes == 0 then
			szListText = szListText .. "<goto=20><color=green>Đã hết lần vào Phó Bản Tàng Bảo Đồ<linegap=5>\n\n";
		else
			szListText    = szListText .. "<goto=20><color=red>Số lần vào Phó Bản Tàng Bảo Đồ:<goto=200>" .. string.format("<color=yellow>%d<color>", nTimes) .. "<linegap=5>\n\n";
		end
		end	
end
    local nCurWeek = tonumber(os.date("%W", GetTime()));
    local nWeek = me.GetTask(Player.PRESTIGE_LIMIT_GROUP, Player.PRESTIGE_WEEK_ID);
    local nUDBossMax = Player.PRESTIGE_LIMIT["uniqueboss"][2]; --UD VLCT
    local nUDBoss = me.GetTask(2015,9);
    local nUDBHDMax = Player.PRESTIGE_LIMIT["baihutang"][2]; -- UD BHÐ
    local nUDBHD = me.GetTask(2015,4); 
    local nUDMCTHMax = Player.PRESTIGE_LIMIT["battle"][2]; --UD MCTH
    local nUDMCTH = me.GetTask(2015,5); 
    local nUDTDCMax = Player.PRESTIGE_LIMIT["xoyogame"][2]; --UD TDC
    local nUDTDC = me.GetTask(2015,10);
    local nUDHTMax = Player.PRESTIGE_LIMIT["tongji"][2]; --UD HT
    local nUDHT = me.GetTask(2015,12);
		if nCurWeek ~= nWeek then
			nUDBossMax = Player.PRESTIGE_LIMIT["uniqueboss"][2];
			nUDBHDMax = Player.PRESTIGE_LIMIT["baihutang"][2];
			nUDMCTHMax = Player.PRESTIGE_LIMIT["battle"][2];
			nUDTDCMax = Player.PRESTIGE_LIMIT["xoyogame"][2];
			nUDHTMax = Player.PRESTIGE_LIMIT["tongji"][2];
		end
    szListText  = szListText .. "<goto=20><color=green>Uy danh từ Võ Lâm Cao Thủ:<color><goto=200>" .. string.format("<color=yellow>%d<color> / %d", nUDBoss, nUDBossMax) .. "<linegap=5>\n";
    szListText  = szListText .. "<goto=20><color=green>Uy danh từ Bạch Hổ Đường:<color><goto=200>" .. string.format("<color=yellow>%d<color> / %d", nUDBHD, nUDBHDMax) .. "<linegap=5>\n";
    szListText  = szListText .. "<goto=20><color=green>Uy danh từ Mông Cổ Tây Hạ:<color><goto=200>" .. string.format("<color=yellow>%d<color> / %d", nUDMCTH, nUDMCTHMax) .. "<linegap=5>\n";
    szListText  = szListText .. "<goto=20><color=green>Uy danh từ Tiêu Dao Cốc:<color><goto=200>" .. string.format("<color=yellow>%d<color> / %d", nUDTDC, nUDTDCMax) .. "<linegap=5>\n";
    szListText  = szListText .. "<goto=20><color=green>Uy danh từ Truy Nã Hải Tặc:<color><goto=200>" .. string.format("<color=yellow>%d<color> / %d", nUDHT, nUDHTMax) .. "<linegap=5>\n\n";
	
	szListText	= szListText .. "<goto=20><color=green>Bạc:<goto=200>" .. string.format("<color=yellow>%d vạn",(me.nCashMoney-nActiveMoneyLogin)/10000) .. "<linegap=5>\n";
	szListText	= szListText .. "<goto=20><color=green>Bạc khóa:<goto=200>" .. string.format("<color=yellow>%d vạn",(me.GetBindMoney()-nBindMoneyLogin)/10000) .. "<linegap=5>\n";
	szListText	= szListText .. "<goto=20><color=green>Đồng khóa:<goto=200>" .. string.format("<color=yellow>%d đồng",me.nBindCoin-nBindCionLogin) .. "<linegap=5>\n";
	szListText	= szListText .. "<goto=20><color=green>Xóa thống kê tiền<goto=200><a=qingling:>Xoá<a>\r";
	self:SetListText(szListText);
end

uiHelpSprite._Int=function(self)
	uiHelpSprite.EnterGame_bak	= uiHelpSprite.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiHelpSprite.EnterGame_bak(Ui);
		uiHelpSprite:LoginAccord();
	end
end

uiHelpSprite:_Int();

uiHelpSprite.LoginAccord=function(self)
	nBindMoneyLogin                     = me.GetBindMoney();
	nBindCionLogin                      = me.nBindCoin;
	nActiveMoneyLogin                   = me.nCashMoney;
end

function uiHelpSprite:Link_qingling_OnClick(szWnd, szGroupId)
	nBindMoneyLogin                     = me.GetBindMoney();
	nBindCionLogin                      = me.nBindCoin;
	nActiveMoneyLogin                   = me.nCashMoney;
	uiHelpSprite:OnUpdatePage_Page1();
end
