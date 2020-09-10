-------------------------------------------------------
--文件名	：	diaoyu1.lua
--创建者	：	灭日猩
--创建时间	：	2011-09-01
--功能描述	：	周末钓鱼帮你找鱼（鱼自己钓吧）
--版权说明	：	欢迎整合，分享喊话请勿更改
------------------------------------------------------
local tbdiaoyu	= Map.tbdiaoyu or {};
Map.tbdiaoyu	= tbdiaoyu;

local allfishs = {{"Cá Chép", "Cá Vàng", "Cá Bống", "Cá Mè", "Cá Tầm"},
		  {"Cá Chình Trắng", "Cá Trắm Cỏ", "Cá Tuyết", "Cá Mè Hoa", "Cá Bá Vương"},
		  {"Cá Đồng", "Cá Ngao Hoa", "Cá Đầu To", "Lươn To", "Cá Ngát"},
		  {"Cá Chẽm", "Cá Trắm", "Cá Chim Trắng", "Cá Lăng", "Cá Trích"},
		  {"Cá Trê", "Cá Kim Long", "Cá Nóc", "Cá Chạch", "Cá Lô"}
		 };
local S_fish = "";       -- 自己要钓的鱼
local S_fishn = 1;       -- 区域编号

local S_jianding = "";   -- 鉴定状态
local S_timerid1;        -- 计时器
local S_step = 0;        -- 区域查找步骤

local XunluStr = "";     -- 读取寻找的坐标点
local XunluTime = 0;     -- 寻路时间
local XunluDizi = "";    -- 寻路地址

local S_Isworld = 0;     -- 共享一次公聊

-- 载入时初始化
function tbdiaoyu:Init()
	self:ModifyUi();
	self.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt");
	self.nIsshare = 1; --与人分享
	self.nDiquChk = {1, 1, 1, 1, 1}; --搜索范围
	self.nSerCur = 0; --当前搜索
	if tbdiaoyu:Infishtime() == 0 then -- 是否在活动时间
		if tbdiaoyu.nAllfish ~= "*Không tự ý thay đổi các tọa độ" then
			tbdiaoyu.nAllfish = "*Không tự ý thay đổi các tọa độ";
			KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", tbdiaoyu.nAllfish);
		end
	end
end

---- 监视聊天信息 ----
function tbdiaoyu:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbdiaoyu.OnMsgArrival_bak = tbdiaoyu.OnMsgArrival_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbdiaoyu:OnChatMsg(szChannelName, szName, szMsg, szGateway);
		tbdiaoyu.OnMsgArrival_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
	end
end

---- 客户端收到消息时 ----
function tbdiaoyu:OnChatMsg(szChannelName, szSendName, szMsg, szGateway)
	if tbdiaoyu:Infishtime() == 0 then -- 是否在活动时间
		if tbdiaoyu.nAllfish ~= "*Không tự ý thay đổi các tọa độ" then
			tbdiaoyu.nAllfish = "*Không tự ý thay đổi các tọa độ";
			KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", tbdiaoyu.nAllfish);
		end
		return;
	end
	if szSendName ~= me.szName and string.sub(szMsg, 9, 18) == "Câu cá cuối tuần," and self.nIsshare == 1 then  -- V1版共享信息
		local tbSplit	= Lib:SplitStr(szMsg, ",");
		local lfish = tbSplit[2];
		local lfishn = tbdiaoyu:Infishs(lfish);
		if (not string.find(self.nAllfish, lfish .. "<")) and lfishn > 0 then
			self.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt"); -- 防止多开，及时刷新
			if (not string.find(self.nAllfish, lfish .. "<")) then
				self.nAllfish = self.nAllfish .. "\r\n" .. tbSplit[2] .. "<pos=" .. tbSplit[3] .. "," .. tbSplit[4] .. "," .. tbSplit[5] .. ">";
				KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
				me.Msg("Chia sẻ với người khác vị trí cá<color=green>" .. lfish .. "<color>！");
			end
		end
		if lfishn > 0 then
			if not string.find(self.nAllfish, tbSplit[2] .. "<pos=" .. tbSplit[3] .. "," .. tbSplit[4] .. "," .. tbSplit[5] .. ">") then
				self.nAllfish = self.nAllfish .. "\r\n" .. tbSplit[2] .. "<pos=" .. tbSplit[3] .. "," .. tbSplit[4] .. "," .. tbSplit[5] .. ">";
				KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
			end
		end
		return;
	end
	if szSendName ~= me.szName and string.find(szMsg, "<pos=") and string.find(szMsg, ">") and self.nIsshare == 1 then -- 灵活的信息共享
		local lfishs = szMsg;
		local lPos1 = string.find(lfishs, "Câu Cá cuối tuần:");
		if lPos1 then
			lfishs = string.sub(lfishs, lPos1 + 9);
		end
		local lPos1 = string.find(lfishs, "<pos=");
		local lPos2 = string.find(lfishs, ">");
		local lfish = string.sub(lfishs, 1, lPos1 - 1);
		local lfishn = tbdiaoyu:Infishs(lfish);
		if (not string.find(self.nAllfish, lfish .. "<")) and lfishn > 0 then
			self.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt"); -- 防止多开，及时刷新
			if (not string.find(self.nAllfish, lfish .. "<")) then
				self.nAllfish = self.nAllfish .. "\r\n" .. string.sub(lfishs, 1, lPos2);
				KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
				me.Msg("Người khác share vị trí cá<color=green>" .. lfish .. "<color>！");
			end
		end
		if lfishn > 0 then
			if not string.find(self.nAllfish, string.sub(lfishs, 1, lPos2)) then
				self.nAllfish = self.nAllfish .. "\r\n" .. string.sub(lfishs, 1, lPos2);
				KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
			end
		end
		return;
	end
	if szSendName == "Thông báo" and string.find(szMsg, "Không thể giám định") then
		S_jianding = "Giám định cá hoàn tất";
		AutoAi.SetTargetIndex(0);  --加这句，上下共二处
		return;
	end
	if szSendName == "Thông báo" and string.find(szMsg, "Qua giám định của thủy sản đại sư, bầy cá này là") then
		AutoAi.SetTargetIndex(0);  --加这句，上下共二处
		local lYZ = string.sub(szMsg, 68);
		for i = 1, 2 do
			local lPos1 = string.find(lYZ, "<");
			if lPos1 then
				local lPos2 = string.find(lYZ, ">");
				if lPos1 == 1 then
					lYZ = string.sub(lYZ, lPos2 + 1);
				else
					lYZ = string.sub(lYZ, 1, lPos1 - 1) .. string.sub(lYZ, lPos2 + 1);
				end
			end
		end
		local lPos1 = string.find(lYZ,",");
		if lPos1 then
			lYZ = string.sub(lYZ, 1, lPos1 - 1);
		end

		local tbMyPos	= {};
		tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY = me.GetWorldPos();

		self.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt"); -- 防止多开，及时刷新
		if lYZ == S_fish then
			self:upstat(0);
			Ui.tbLogic.tbTimer:Close(self.S_timerid1);
			me.Msg("nhiệm vụ tìm cá<color=green>" .. lYZ);
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Nhiệm vụ tìm cá：" .. lYZ .. "，bắt 5 con sẽ làm nv khác");
			if not string.find(self.nAllfish, lYZ .. "<") then
				self.nAllfish = self.nAllfish .. "\r\n" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">";
				KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
				if self.nIsshare == 1 then
					if S_Isworld == 0 then
						S_Isworld = 1; --每人贡献一次公聊
						SendChannelMsg("Tong", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --公聊
								else
								
						SendChannelMsg("Kin", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">");	--城聊
--						SendChannelMsg("Team", "CauCaCuoiTuan:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --队聊
--						SendChannelMsg("Tong", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">");	--帮聊
--						SendChannelMsg("Friend", "CauCaCuoiTuan:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --友聊
					end
				end
			end
			return;
		end
		if not string.find(self.nAllfish, lYZ .. "<") then
			self.nAllfish = self.nAllfish .. "\r\n" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">";
			KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
			if self.nIsshare == 1 then
				if S_Isworld == 0 then
					S_Isworld = 1; --每人贡献一次公聊
					SendChannelMsg("Tong", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --公聊
				else
			--		SendChannelMsg("Tong", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">");
					SendChannelMsg("Kin", "Câu cá cuối tuần:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">");	--城聊
--					SendChannelMsg("Team", "CauCaCuoiTuan:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --队聊
				--	SendChannelMsg("Friend", "CauCaCuoiTuan:" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">"); --友聊
				end
			end
		end
		if not string.find(self.nAllfish, lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">") then
			self.nAllfish = self.nAllfish .. "\r\n" .. lYZ .. "<pos=" .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY .. ">";
			KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", self.nAllfish);
		end
		S_jianding = "Xác Định các loại cá hoàn tất";
		return;
	end
end

function tbdiaoyu:IsDaoda3(tbMyPos, tbMyPosStr)
	local tbSplit	= Lib:SplitStr(tbMyPosStr, ",");
	local tbPos	= {
		nMapId	= tonumber(tbSplit[2]),
		nPosX	= tonumber(tbSplit[3]),
		nPosY	= tonumber(tbSplit[4]),
	};
	if math.sqrt((tbMyPos.nPosX - tbPos.nPosX)^2 + (tbMyPos.nPosY - tbPos.nPosY)^2) <=3 then
		return 1;
	end
	if GetTime() - XunluTime >= 10 then
		XunluTime = GetTime();
--		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = tbMyPosStr });
		UiManager.tbLinkClass["pos"]:OnClick(tbMyPosStr);
		XunluDizi = "," .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY;
		return 0;
	end
	if GetTime() - XunluTime >= 1 then
		if XunluDizi == "," .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY then
--			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = tbMyPosStr });
			UiManager.tbLinkClass["pos"]:OnClick(tbMyPosStr);
		else
			XunluDizi = "," .. tbMyPos.nMapId .. "," .. tbMyPos.nPosX .. "," .. tbMyPos.nPosY;
		end
		XunluTime = GetTime();
	end
	return 0;
end

function tbdiaoyu:WeekDY()
	if tbdiaoyu:Infishtime() == 0 then -- 是否在活动时间
		self:upstat(0);
		Ui.tbLogic.tbTimer:Close(self.S_timerid1);
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Cá nhà ngày hôm nay！");
--		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "秦洼,1,1313,3119" });
		UiManager.tbLinkClass["pos"]:OnClick("Tần Oa,1,1313,3119");
		return;
	end

	for i = S_fishn, 5 do
		if self.nDiquChk[i] == 0 then
			S_fishn = S_fishn + 1;
			S_step = 1;
		else
			break;
		end
	end

	local tbMyPos	= {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY = me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then	-- 登入中，数据不完整
		return;	-- 先等一等
	end

	local tbItem = me.FindItemInBags(18,1,1395,1)[1] -- 水产秘术
	if not tbItem then
		Ui.tbLogic.tbTimer:Close(self.S_timerid1);
		me.Msg("không có cẩm nang cá！");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Không xác định được cá！");
		return;
	end

	self:upstat(S_fishn);

	self.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt"); -- 防止多开，及时刷新
	if S_fish ~= "" then
		local lPos1 = string.find(self.nAllfish, S_fish .. "<");
		if lPos1 then
			self:upstat(0);
			Ui.tbLogic.tbTimer:Close(self.S_timerid1);
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Tự động tìm cá đã thấy！");
			lPos1 = string.find(self.nAllfish, "=", lPos1);
			local lPos2 = string.find(self.nAllfish, ">", lPos1);
			me.Msg(S_fish .. "," .. string.sub(self.nAllfish, lPos1 + 1, lPos2 - 1));
--			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = S_fish .. "," .. string.sub(self.nAllfish, lPos1 + 1, lPos2 - 1)});
			UiManager.tbLinkClass["pos"]:OnClick(S_fish .. "," .. string.sub(self.nAllfish, lPos1 + 1, lPos2 - 1));
			return;
		end
	end

	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end

	if S_fishn == 6 then
		S_fishn = 1;
		self:upstat(0);
		Ui.tbLogic.tbTimer:Close(self.S_timerid1);
		me.Msg("<color=green>Đã tìm trong khu vực các thành！");
--		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "秦洼,1,1313,3119" });
		UiManager.tbLinkClass["pos"]:OnClick("Tần Oa,1,1313,3119");
		return;
	end

	local lPos1 = string.find(XunluStr, "Câu Cá Cuối tuần" .. S_fishn);
	local lPos2 = string.find(XunluStr, "Câu cá cuối tuần" .. (S_fishn + 1));
	local lXunluPos = string.sub(XunluStr, lPos1, lPos2);
	local tbSplit	= Lib:SplitStr(lXunluPos, "<link=pos:");

	local Isrun = 0;
	for i = 1, 5 do
		if not string.find(self.nAllfish, allfishs[S_fishn][i] .. "<") then
			Isrun = 1;
			break;
		end
	end
	if Isrun == 0 then
		S_step = 1;
		S_fishn = S_fishn + 1;
		me.Msg("<color=yellow>Khu vực cá xác định hoàn thành！<color>");
		tbdiaoyu:WeekDY();
		return;
	end

	if S_step > table.getn(tbSplit) then
		if S_fish ~= "" then
			me.Msg("Không tìm thấy：<color=green>" .. S_fish .. "<color>，Tiếp tục tìm cá khác。");
			S_fish = "";
		end
		S_fishn = S_fishn + 1;
		S_step = 1;
		return;
	end
	lPos1 = string.find(tbSplit[S_step], ">")
	if not lPos1 then
		S_step = S_step + 1;
		return;
	end
	lPos1 = string.find(tbSplit[S_step], ">")
	tbSplit[S_step] = string.sub(tbSplit[S_step], 1, lPos1 - 1);
	lPos1 = string.find(tbSplit[S_step], ",")
	tbSplit[S_step] = string.sub(tbSplit[S_step], lPos1);

	-- 每个地图搜索过两种鱼后就不再去
	local tbSplit1	= Lib:SplitStr(tbSplit[S_step], ",");
	lPos1 = string.find(self.nAllfish, "<pos=" .. tbSplit1[2] .. ",")
	if lPos1 then
		local lPos3 = string.find(self.nAllfish, "\r\n", lPos1 - 10);
		local lStr1 = string.sub(self.nAllfish, lPos3 + 2, lPos1 - 1);
		while true do
			lPos1 =	string.find(self.nAllfish, "<pos=" .. tbSplit1[2] .. ",", lPos1 + 5)
			if lPos1 then
				lPos3 = string.find(self.nAllfish, "\r\n", lPos1 - 10);
				local lStr2 = string.sub(self.nAllfish, lPos3 + 2, lPos1 - 1);
				if lStr1 ~= lStr2 then
--					me.Msg("--该地图已完成:" .. GetMapNameFormId(tonumber(tbSplit1[2])));
					S_step = S_step + 1;
					tbdiaoyu:WeekDY();
					return;
				end
			else
				break;
			end
		end
	end

	-- 搜索过的点不再跑
	lPos1 = string.find(self.nAllfish, "<pos=" .. string.sub(tbSplit[S_step], 2))
	if lPos1 then
--		me.Msg("--该点已完成:" .. string.sub(tbSplit[S_step], 1));
		S_step = S_step + 1;
		tbdiaoyu:WeekDY();
		return;
	end

	if tbdiaoyu:IsDaoda3(tbMyPos, tbSplit[S_step]) == 1 then
		if S_jianding == "Xác định cá" then
			me.UseItem(tbItem.pItem);
			me.Msg("xác định cá！");
			return;
		else
			if S_jianding ~= "xác định cá hoàn tất" then
				S_jianding = "xác định cá";
				return;
			end
		end
		S_jianding = "";
		S_step = S_step + 1;
	else
		S_jianding = "";
		return;
	end
end

function tbdiaoyu:zhaoyu1()
	local ltime =GetLocalDate("%H%M");
	local nWeekDay	= tonumber(os.date("%w", GetTime()));
	if not (nWeekDay == 6 or nWeekDay == 0) then
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>hôm nay sẽ không có cá,chờ thư 7,CN！");
		return;
	end
	if tonumber(ltime) < 1000 then
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Hoạt động từ 10h ~ 14h ！");
		return;
	end
	if (tonumber(ltime) >= 1400 and tonumber(ltime) < 1600) then
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Hoạt động từ 16h ~ 22h ！！");
		return;
	end
	if tonumber(ltime) >= 2000 and nWeekDay == 6 then
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Cá sẽ kéo về vào ngày mai！");
		return;
	end
	if tonumber(ltime) >= 2000 and nWeekDay == 0 then
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>cá chạy hết rồi chờ đến cuối tuần tới！");
		return;
	end

	S_fish = "";
	S_fishn = 1; -- 要找的鱼的区域

	local nTaskIdItem = 60001;
	local tbTagInfo = tbdiaoyu:GetTaskTags(nTaskIdItem);
	if (tbTagInfo) then
		if tbTagInfo == -1 then
			me.Msg("Hoàn thành nhiệm vụ ,đến nhận thưởng！");
--			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "秦洼,1,1313,3119" });
			UiManager.tbLinkClass["pos"]:OnClick("Tần Oa,1,1313,3119");
			return;
		end
		-- 判断是否完成所有分支任务
		for _, tagInfo in ipairs(tbTagInfo) do
			if tagInfo[1] == 0 then
				S_fish = tagInfo[2]; -- 要找的鱼的种类
				break;
			end
		end
		if S_fish == "" then
			me.Msg("oàn thành nhiệm vụ ,đến nhận thưởng！");
--			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "秦洼,1,1313,3119" });
			UiManager.tbLinkClass["pos"]:OnClick("Tần Oa,1,1313,3119");
			return;
		end
		S_fish = "";
		-- 判断所选范围中有无未完成的任务
		for _, tagInfo in ipairs(tbTagInfo) do
			if tagInfo[1] == 0 then
				local lPos1 = string.find(tagInfo[2], "5điều");
				S_fish = string.sub(tagInfo[2], lPos1 + 3); -- 要找的鱼的种类
				S_fishn = tbdiaoyu:Infishs(S_fish);
				if S_fishn == 0 then
					me.Msg("<color=yellow>Hệ thông thay đổi thông tin,có thể ko tự động tìm cá！");
					return;
				end
				if self.nDiquChk[S_fishn] == 0 then
					S_fish = "";
				else
					me.Msg("Các loại cá bạn đang tìm<color=green>" .. S_fish);
					break;
				end
			end
		end
		if S_fish == "" then
			me.Msg("Lựa chọn khu vực đánh bắt cá chưa xong！");
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Lựa chọn khu vực đánh bắt cá chưa xong！");
			return;
		end
	else
		me.Msg("Ko có nhiệm vụ,tìm tất cả các loại cá！");
		Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Ko có nhiệm vụ,tìm tất cả các loại cá！");
	end

	S_step = 1;
	XunluStr = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu1.txt");
	self:upstat(0);
	Ui.tbLogic.tbTimer:Close(self.S_timerid1);
	self.S_timerid1 =  Ui.tbLogic.tbTimer:Register(18, tbdiaoyu.WeekDY, self);
end

function tbdiaoyu:Infishs(lfish)
	for i = 1, 5 do
		for j = 1, 5 do
			if lfish == allfishs[i][j] then
				return i;
			end
		end
	end
	return 0;
end
function tbdiaoyu:Infishtime() -- 是否在活动时间
	local ltime =GetLocalDate("%H%M");
	local nWeekDay	= tonumber(os.date("%w", GetTime()));
	if not (nWeekDay == 6 or nWeekDay == 0) then
		return 0;
	end
	if tonumber(ltime) < 1000 then
		return 0;
	end
	if (tonumber(ltime) >= 1400 and tonumber(ltime) < 1600) then
		return 0;
	end
	if tonumber(ltime) >= 2000 then
		return 0;
	end
	return 1;
end

function tbdiaoyu:stopall()
	self:upstat(0);
	Ui.tbLogic.tbTimer:Close(self.S_timerid1);
end

function tbdiaoyu:upstat(nIndex)
	if UiManager:WindowVisible(Ui.UI_diaoyu) == 1 then
		if self.nSerCur > 0 and self.nSerCur ~= nIndex then
			Txt_SetTxt(Ui.UI_diaoyu, "LblStat"..self.nSerCur, "");
		end
		if nIndex > 0 and nIndex < 6 then
			Txt_SetTxt(Ui.UI_diaoyu, "LblStat"..nIndex, "Tìm kiếm");
			self.nSerCur = nIndex;
		else
			self.nSerCur = 0;
		end
	end
end

function tbdiaoyu:GetTaskTags(nTaskIdItem)
	local tbPlayerTask = Task:GetPlayerTask(me); --获得一个玩家所有的任务
	local tbTask = tbPlayerTask.tbTasks[nTaskIdItem];
	if (tbTask) then
		local tbCurTags = tbTask.tbCurTags; -- 子任务目标集合
		local szRefSubTaskName = tbTask.tbReferData.szName; -- 子任务名
		local tbSubTaskData = tbTask.tbSubData;
		local tbTagInfo = {}; --这个表保存的目标是按未完成到完成排列
		if (tbTask.nCurStep > 0) then
			for _, tbCurTag in ipairs(tbCurTags) do
				if (tbCurTag:GetDesc() ~= "") then
					local tbPosInfo = Task:GetPosInfo(tbTask.nTaskId, szRefSubTaskName, tbTask.nCurStep);
					local szDesc = tbCurTag:GetDesc();
					if (tbPosInfo and Lib:CountTB(tbPosInfo) > 0) then
						szDesc = Task:GetFinalDesc(szDesc, tbPosInfo);
					end
					if (tbCurTag:IsDone()) then
						table.insert(tbTagInfo, { 1, szDesc });
					else
						table.insert(tbTagInfo, 1, { 0, szDesc });
					end
				end
			end
			return tbTagInfo;
		else
			return -1;
		end
	end
end

tbdiaoyu:Init();
