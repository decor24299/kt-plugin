-------------------------------------------------edit by chow82 KHPT
local tbKinZhongZhi = Map.tbKinZhongZhi or {};
Map.tbKinZhongZhi = tbKinZhongZhi;
local XunluTime = 0;
local XunluDizi = "";
local nTimerId	= 0;
local vNpc01   = {9843,9846,9849,9852,9855,9858,9861,9864,9867,9898,9901,9904};
local vNpc02   = {9844,9847,9850,9853,9856,9859,9862,9865,9868,9899,9902,9905};
local vNpc03   = {9845,9848,9851,9854,9857,9860,9863,9866,9869,9900,9903,9906};
local SettingPath = "\\user\\Plant\\"; 
local PlantPos = {};
local MyFindPos = {};
local IsSort = 0;
local NoKin = 0;

function tbKinZhongZhi:InZhongzhiTime(nTime)
	for _, v in ipairs(KinPlant.tbPlantTime) do
		if nTime then
			if v[1]<=tonumber(nTime) and tonumber(nTime)<v[2] then
				return 1;
			end
		else
			if v[1]<=tonumber(GetLocalDate("%H%M")) and tonumber(GetLocalDate("%H%M"))<v[2] then
				return 1;
			end
		end
	end
	return nil;
end

function tbKinZhongZhi:CanZhongzhiNum()
	if me.GetTask(KinPlant.TASKGID, KinPlant.TASK_DATE) ~= tonumber(GetLocalDate("%Y%m%d")) then
		return KinPlant.nMaxPlantCount;
	else
		return KinPlant.nMaxPlantCount - me.GetTask(KinPlant.TASKGID, KinPlant.TASK_COUNT);
	end
end

function tbKinZhongZhi:MyPlant()
	if #MyFindPos == 0 then
		local pTxtFile = KFile.ReadTxtFile(SettingPath..me.szName..".txt");
		if pTxtFile then
			MyFindPos = Lib:Str2Val(pTxtFile);
		else
			return nil;
		end
	end
	local nTime = GetTime();
	local nMyPlant = 0;
	for _, tbRow in ipairs(MyFindPos) do
		if nTime - tonumber(tbRow.vTime) > 7*3600 then 
			return nil;
		end
		if tbRow.szName == me.szName then
			nMyPlant = nMyPlant + 1;
		end
	end
	return nMyPlant;
end

function tbKinZhongZhi:GetPlantPosFile()
	local pTabFile = Lib:LoadTabFile("\\setting\\kin\\kinplant\\plantpos.txt");
	if pTabFile then
		local szData = Lib:Val2Str(pTabFile);
		KFile.WriteFile("\\interface2\\AutoTrongCayGT\\plantpos.txt", szData);
	else
		me.Msg("<color=yellow>Tệp tin bị lỗi, vui lòng kiểm tra lại<color>");
	end
end

function tbKinZhongZhi:Switch()
	if nTimerId == 0 then
		self:Start();
	else
		self:Stop();
	end
end

function tbKinZhongZhi:Start()
	if nTimerId == 0 then
		if not self:CanKinZhongZhi(1) then
			return;
		end
		if me.nFightState == 1 then
			UiManager.tbLinkClass["pos"]:OnClick(",29,1605,3946");
		end
		IsSort = 0;
		nTimerId = Timer:Register(Env.GAME_FPS * 0.5, self.OnTimer, self);
		--Ui(Ui.UI_TASKTIPS):Begin("<color=White>Tự trồng cây gia tộc:<color=green> Begin");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Bật - Tự trồng cây gia tộc<color>");
	end
end

function tbKinZhongZhi:Stop()
	if nTimerId ~= 0 then
		Timer:Close(nTimerId);
		nTimerId = 0;
		--Ui(Ui.UI_TASKTIPS):Begin("<color=White>Tự trồng cây gia tộc:<color=red> Stop");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=white>Tắt - Tự trồng cây gia tộc<color>");
	end
end

function tbKinZhongZhi:HaveLingDi()
	if NoKin == 1 then
		return nil;
	end
	return 1;
end

function tbKinZhongZhi:CanKinZhongZhi(nType)
	if not self:HaveLingDi() then
		if nType then
			Ui(Ui.UI_TASKTIPS):Begin("Gia tộc bạn chưa có lãnh địa");
		end
		return nil;
	end
	if GetMapNameFormId(me.nTemplateMapId) ~= "Lãnh Địa Gia Tộc" then
		local tbItem = me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
		if not tbItem then
			if nType then
				me.Msg("<color=white>Thông báo: <color>Xin hãy trang bị vô truyền tống phù");
			end
			return nil;
		end
		local nCanUse = KItem.CheckLimitUse(me.nTemplateMapId, "chuansong");
		if (not nCanUse or nCanUse == 0) then
			if nType then
				me.Msg("<color=white>Thông báo: <color>Cần đi tới bản đồ cụ thể");
			end
			return nil;
		end
	end

	local bGETOK	= 0;
	if me.GetTask(KinPlant.TASKGID, KinPlant.TASK_DATE_GET) == tonumber(GetLocalDate("%Y%m%d")) and
	   me.GetTask(KinPlant.TASKGID, KinPlant.TASK_COUNT_GET) >= KinPlant.nDayMaxGet then
		bGETOK = 1;
		if nType then me.Msg("<color=white>Thông báo: <color>Số lượng trái cây hái trộm đạt mức tối đa"); end
	else
		local nTASKNum = 0 ; 
		if me.GetTask(KinPlant.TASKGID, KinPlant.TASK_DATE_GET) ~= tonumber(GetLocalDate("%Y%m%d")) then
			nTASKNum = KinPlant.nDayMaxGet;
		else
			nTASKNum = KinPlant.nDayMaxGet - me.GetTask(KinPlant.TASKGID, KinPlant.TASK_COUNT_GET);
		end
		if nType then me.Msg("<color=white>Thông báo: <color>Hôm nay bạn có thể hái trộm "..nTASKNum.." trái"); end
	end

	local bTASKOK	= 0 ;
	local nTASKNum = self:CanZhongzhiNum();
	if nTASKNum == 0 then
		local nTASKNum1 = self:MyPlant();
		if nTASKNum1 then
			if nTASKNum1 == 0 then
				bTASKOK = 1;
				if nType then me.Msg("<color=whtie>Thông báo: <color>Hôm nay bạn đã trồng đủ số lượng cây"); end
			else
				if nType then me.Msg("<color=white>Thông báo: <color>Trồng cây đã đạt đến số lượng tối đa "..nTASKNum1.." trái"); end
			end
		else
			if nType then me.Msg("<color=white>Thông báo: <color>Không biết cây cỏ thế nào để đi xem"); end
		end
	else
		if not self:InZhongzhiTime() then
			if nTASKNum == KinPlant.nMaxPlantCount then
				bTASKOK = 1;
				if nType then me.Msg("<color=white>Thông báo: <color>Trong vườn không có cây của ngươi, hiện tại không phải thời gian trồng"); end
			else
				if nType then me.Msg("<color=white>Thông báo: <color>Bây giờ có thể trồng "..nTASKNum.." trái，nhưng giờ không phải thời gian trồng"); end
			end
		else
			bTASKOK = 2;
			if nType then me.Msg("<color=white>Thông báo: <color>Bây giờ có thể trồng "..nTASKNum.." hạt giống"); end
		end
	end

	if bGETOK == 1 and bTASKOK == 1 then
		return nil;
	end

	PlantPos = {};
	local pTabFile = Lib:LoadTabFile("\\setting\\kin\\kinplant\\plantpos.txt");
	if pTabFile then
		PlantPos = pTabFile;
		for nRow, tbRow in ipairs(PlantPos) do
			if tonumber(tbRow.TRAPX) == 54560 and tonumber(tbRow.TRAPY) == 106016 then
				local tbRowCopy = tbRow;
				table.remove(PlantPos, nRow);
				table.insert(PlantPos, 1, tbRowCopy);
				break;
			end
		end
	else
		me.Msg("<color=yellow>Tệp tin bị lỗi, vui lòng kiểm tra lại<color>");
		return nil;
	end
	MyFindPos = {};
	local pTxtFile = KFile.ReadTxtFile(SettingPath..me.szName..".txt");
	if pTxtFile then
		MyFindPos = Lib:Str2Val(pTxtFile);
	else
		return 1;
	end
	if bTASKOK == 2 then
		return 1;
	end
	local nTime = GetTime();
	for nRow, tbRow in ipairs(MyFindPos) do
		if nTime - tonumber(tbRow.vTime) > 7*3600 then 
			if nType then me.Msg("<color=white>Thông báo: <color>Lâu rồi không đến vườn"); end
			return 1;
		end
		if not tbRow.Time1 and bGETOK == 0 and table.find(vNpc03, tonumber(tbRow.nTempId)) then 
			if nType then me.Msg("<color=white>Thông báo: <color>Quả đã chín, tới xem nào"); end
			return 1;
		end
		if tbRow.Time2 and (bGETOK == 0 or tbRow.szName == me.szName) and nTime >= tonumber(tbRow.Time2) and tonumber(tbRow.Time2) > 0 then 
			if nType then me.Msg("<color=white>Thông báo: <color>Quả đã chín, súc thôi"); end
			return 1;
		end
		if tbRow.Time2 and tonumber(tbRow.Time2) > 0 and tbRow.szName == me.szName then 
			local tbTime = os.date("*t", tonumber(tbRow.Time2));
			if nType then me.Msg("<color=white>Thông báo: <color>Trưởng thành sau:"..tbTime.hour.."giờ"..tbTime.min.."phút"..tbTime.sec.."giây"); end
		end
	end
	if nType then me.Msg("<color=white>Thông báo: <color>Không còn cây để gieo trồng"); end
	return nil;
end

function tbKinZhongZhi:OnTimer()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	local tbMyPos = {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY = me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then
		return;
	end
	if me.nFightState == 1 then
		return;
	end
	if GetMapNameFormId(me.nTemplateMapId) ~= "Lãnh Địa Gia Tộc" then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			if string.find(szQuestion, "Muốn đi đâu thì đi") then
				local HaveLingDi = 0;
				for i, tbInfo in ipairs(tbAnswers) do
					if string.find(tbInfo, "Lãnh địa gia tộc") then
						HaveLingDi = 1;
						break;
					end
				end
				if HaveLingDi == 0 then
					Ui(Ui.UI_TASKTIPS):Begin("Gia tộc bạn không có lãnh địa");
					NoKin = 1;
					self:Stop();
					Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
					return;
				end
			end
			for i, tbInfo in ipairs(tbAnswers) do
				if string.find(tbInfo, "Lãnh địa gia tộc") then
					me.AnswerQestion(i - 1);
					return;
				end
				if string.find(tbInfo, "Đồng ý") then
					me.AnswerQestion(i - 1);
					Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
					return;
				end
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
		end
		local tbItem = me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
		me.UseItem(tbItem.pItem);
		return;
	end

	local lTime = GetTime();
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
		local lx,ly,_ = pNpc.GetMpsPos();
		for nRow, tbRow in ipairs(PlantPos) do
			if tonumber(tbRow.TRAPX) == lx and tonumber(tbRow.TRAPY) == ly then
				tbRow.vTime	= lTime;
				tbRow.nTempId	= pNpc.nTemplateId;
				tbRow.szName	= pNpc.szName;
				break;
			end
		end
	end

	local bGETOK = 0;	
	if me.GetTask(KinPlant.TASKGID, KinPlant.TASK_DATE_GET) == tonumber(GetLocalDate("%Y%m%d")) and
	   me.GetTask(KinPlant.TASKGID, KinPlant.TASK_COUNT_GET) >= KinPlant.nDayMaxGet then
		bGETOK = 1;
	end

	local sPlantPos = "";
	for nRow, tbRow in ipairs(PlantPos) do
		if not tbRow.vTime or tbRow.vTime == "" then
			sPlantPos = "," .. tbMyPos.nMapId .. "," .. tonumber(tbRow.TRAPX)/32 .. "," .. tonumber(tbRow.TRAPY)/32;
			break;
		end
	end
	if sPlantPos ~= "" then
		self:IsDaoda(sPlantPos);
		return;
	else
		if IsSort == 0 then
			local szData = {};
			for i, v in ipairs(PlantPos) do
				if table.find(vNpc03, tonumber(v.nTempId)) and v.szName == me.szName then
					table.insert(szData, v);
				end
			end
			for i, v in ipairs(PlantPos) do
				if table.find(vNpc03, tonumber(v.nTempId)) and v.szName ~= me.szName then
					table.insert(szData, v);
				end
			end
			for i, v in ipairs(PlantPos) do
				if not table.find(vNpc03, tonumber(v.nTempId)) then
					table.insert(szData, v);
				end
			end
			PlantPos = szData;
			me.Msg("<color=white>Thông báo: <color>Bắt đầu đi ăn trộm hoa quả");
			IsSort = 1;
		end
	end

	for nRow, tbRow in ipairs(PlantPos) do
		if not tbRow.Time1 or tonumber(tbRow.Time1) ~= tonumber(GetLocalDate("%Y%m%d")) then
			if table.find(vNpc03, tonumber(tbRow.nTempId)) and (bGETOK == 0 or tbRow.szName == me.szName) then
				if self:IsDaoda("," .. tbMyPos.nMapId .. "," .. tonumber(tbRow.TRAPX)/32 .. "," .. tonumber(tbRow.TRAPY)/32) == 0 then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					end
					return;
				end
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
					if table.find(vNpc03, tonumber(tbRow.nTempId)) then
						if string.find(szQuestion, "Quả đã chín") then
							me.AnswerQestion(0);
							if tbRow.szName ~= me.szName then
								tbRow.Time1 = GetLocalDate("%Y%m%d");
								tbRow.Time2 = 0;
							end
							Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
							return;
						end
					else
						local nPos = string.find(szQuestion, "Thực vật đang tăng trưởng. Trưởng thành:");
						if nPos then
							local sTime = string.sub(szQuestion, nPos + 24);
							nPos = string.find(sTime, "giây");
							sTime = string.sub(sTime, 1, nPos - 1);
							nPos = string.find(sTime, "giờ");
							local nHour = string.sub(sTime, 1, nPos - 1);
							sTime = string.sub(sTime, nPos + 2);
							nPos = string.find(sTime, "phút");
							local nMinute = string.sub(sTime, 1, nPos - 1);
							local nSecond = string.sub(sTime, nPos + 2);
							me.AnswerQestion(1);
							tbRow.Time1 = GetLocalDate("%Y%m%d");
							tbRow.Time2 = lTime+tonumber(nHour)*60*60+tonumber(nMinute)*60+tonumber(nSecond);
							if tonumber(nHour) == 0 then
								me.Msg("<color=white>Thông báo: <color>Sẽ thu hoạch sau: "..nMinute.." phút "..nSecond.." giây sau khi trưởng thành");
							end
							Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
							return;
						end				
					end
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
					return;
				end
				local tbAroundNpc = KNpc.GetAroundNpcList(me, 300);
				for _, pNpc in ipairs(tbAroundNpc) do
					local lx,ly,_ = pNpc.GetMpsPos();
					if tonumber(tbRow.TRAPX) == lx and tonumber(tbRow.TRAPY) == ly then
						AutoAi.SetTargetIndex(pNpc.nIndex);
						return;
					end
				end
				return;
			end
		end
	end

	if self:InZhongzhiTime() then
		local nTASKNum = self:CanZhongzhiNum();
		if nTASKNum > 0 then
			local lCount = 0;
			for i=0,2 do
				lCount = lCount + me.GetItemCountInBags(18,1,1630+i,1);
			end
			for i=0,8 do
				lCount = lCount + me.GetItemCountInBags(18,1,1568+i*2,1);
			end
			if lCount < nTASKNum then
				if self:IsDaoda(","..tbMyPos.nMapId..",1830,3300") == 0 then
					return;
				end
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					end
					local uiAutoFuBen	= Ui.tbWnd[Ui.UI_AUTOFUBEN] or {};
					local tbSetting		= uiAutoFuBen:Load(uiAutoFuBen.DATA_KEY) or {};
					local MyRepute 		= tbSetting.nMyRepute;
					local PlantCode = 0;
					local nDate = tonumber(GetLocalDate("%Y%m%d"));
					if nDate < 20120207 then
						PlantCode = 5035+MyRepute-1;
					else
						if MyRepute == 1 then
							PlantCode = 5023;
						elseif MyRepute == 2 then
							PlantCode = 5024;
						elseif MyRepute == 3 then
							PlantCode = 5025;
						elseif MyRepute == 4 then
							PlantCode = 5026;
						elseif MyRepute == 5 then
							PlantCode = 5027;
						elseif MyRepute == 6 then
							PlantCode = 5028;
						elseif MyRepute == 7 then
							PlantCode = 5029;
						elseif MyRepute == 8 then
							PlantCode = 5030;
						elseif MyRepute == 9 then
							PlantCode = 5031;
						end
					--[[	if MyRepute == 1 then
							PlantCode = 5022+me.GetReputeLevel(14,1);
							if PlantCode > 5025 then PlantCode = 5025; end
						elseif MyRepute == 2 then 
							PlantCode = 5025+me.GetReputeLevel(14,2);
							if PlantCode > 5028 then PlantCode = 5028; end
						elseif MyRepute == 3 then 
							PlantCode = 5028+me.GetReputeLevel(14,3);
							if PlantCode > 5031 then PlantCode = 5031; end
						end]]
					end
					me.Msg("Hạt giống: "..PlantCode..nTASKNum - lCount)
					me.ShopBuyItem(PlantCode, nTASKNum - lCount);
					Ui.tbLogic.tbTimer:Register(1, self.CloseWin);
				else
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
						for i, tbInfo in ipairs(tbAnswers) do
							if string.find(tbInfo, "Cửa hàng hạt giống bội thu") then
								me.AnswerQestion(i - 1);
								Ui.tbLogic.tbTimer:Register(1, self.CloseSay);
								return;
							end
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
						end
					else
						local tbAroundNpc = KNpc.GetAroundNpcList(me, 20);
						for _, pNpc in ipairs(tbAroundNpc) do
							if (pNpc.szName == "Lữ Phong Niên") then
								AutoAi.SetTargetIndex(pNpc.nIndex);
								break;
							end
						end
					end
				end
				return;
			end
			local tbItem = me.FindClassItemInBags("KinPlantSeed")[1];
			if tbItem then
				for nRow, tbRow in ipairs(PlantPos) do
					if tbRow.nTempId == KinPlant.nTempNpc then
						if self:IsDaoda("," .. tbMyPos.nMapId .. "," .. tonumber(tbRow.TRAPX)/32 .. "," .. tonumber(tbRow.TRAPY)/32) == 0 then
							return;
						end
						me.UseItem(tbItem.pItem);
						return;
					end
				end
			end
		end
	end

	if self:IsDaoda(","..tbMyPos.nMapId..",1830,3300") == 0 then
		return;
	end

	local szData = {};
	for i, tbRow in ipairs(PlantPos) do
		if tonumber(tbRow.nTempId) ~= KinPlant.nTempNpc then
			table.insert(szData, tbRow);
		end
	end
	if #szData <= 0 then table.insert(szData, PlantPos[1]); end 

	local szDataTxt = Lib:Val2Str(szData);
	KFile.WriteFile(SettingPath..me.szName..".txt", szDataTxt);

	self:Stop();
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then UiManager:CloseWindow(Ui.UI_SAYPANEL); end

	if Map.tbSuperMapLink.nIsAllAuto == 1 then
		UiManager.tbLinkClass["pos"]:OnClick(",29,1570,3922"); 
		Map.tbSuperMapLink.nIsAllAuto = 0;
	end
end

function tbKinZhongZhi:IsDaoda(tbToPos)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return 0;
	end
	local tbMyPos = {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY = me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then
		return 0;
	end

	local tbToPosStr = "";
	local lStr = "";
	if (type(tbToPos) == "string") then
		local lPos1 = string.find(tbToPos, "<link=pos:");
		if lPos1 then
			local lPos2 = string.find(tbToPos, ">", lPos1);
			if lPos2 then
				lStr = string.sub(tbToPos, lPos1, lPos2 - 1);
			end
		end
		if lStr == "" then
			local lPos1 = string.find(tbToPos, "<pos=");
			if lPos1 then
				local lPos2 = string.find(tbToPos, ">", lPos1);
				if lPos2 then
					lStr = "," .. string.sub(tbToPos, lPos1 + 5, lPos2 - 1);
				end
			end
		end
		if lStr == "" then
			lStr = tbToPos;
		end
		local tbSplit = Lib:SplitStr(lStr, ",");
		tbToPosStr = ","..tbSplit[2]..","..tbSplit[3]..","..tbSplit[4];
	end
	if (type(tbToPos) == "table") then
		if tbToPos.nMapId then
			tbToPosStr = ","..tbToPos.nMapId..","..tbToPos.nPosX..","..tbToPos.nPosY;
		end
		if tbToPos[3] then
			tbToPosStr = ","..tbToPos[1]..","..tbToPos[2]..","..tbToPos[3];
		end
	end
	local tbSplit	= Lib:SplitStr(tbToPosStr, ",");
	local tbPos	= { nMapId = tonumber(tbSplit[2]), nPosX = tonumber(tbSplit[3]), nPosY = tonumber(tbSplit[4]) };

	if tbMyPos.nMapId == tbPos.nMapId and math.sqrt((tbMyPos.nPosX - tbPos.nPosX)^2 + (tbMyPos.nPosY - tbPos.nPosY)^2) < 3 then
		return 1;
	end

	local nOnlineExpState = Player.tbOnlineExp:GetOnlineState(me);
	if (nOnlineExpState == 1) then
		me.CallServerScript({"ApplyUpdateOnlineState", 0});
	end

	local IsNewPos = 0;
	if XunluDizi ~= tbToPosStr then 
		XunluDizi = tbToPosStr;
		XunluTime = 0;
		IsNewPos = 1;
	end
	if GetTime() - XunluTime >= 1 then
		if IsNewPos == 1 or me.GetNpc().nDoing ~= Npc.DO_WALK and me.GetNpc().nDoing ~= Npc.DO_RUN then
			if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		        end
			AutoAi.SetTargetIndex(0);
			if tbMyPos.nMapId == tbPos.nMapId and math.sqrt((tbMyPos.nPosX - tbPos.nPosX)^2 + (tbMyPos.nPosY - tbPos.nPosY)^2) < 80 then
				me.StartAutoPath(tbPos.nPosX, tbPos.nPosY);
			else
				if tbMyPos.nMapId == tbPos.nMapId then
					Ui.tbLogic.tbAutoPath:GotoPos({nMapId=me.nTemplateMapId,nX=tbPos.nPosX,nY=tbPos.nPosY})
				else
					Ui.tbLogic.tbAutoPath:GotoPos({nMapId=tbPos.nMapId,nX=tbPos.nPosX,nY=tbPos.nPosY})
				end
			end
			XunluTime = GetTime() + 3;
		end
		XunluTime = GetTime();
	end
	return 0;
end

function tbKinZhongZhi:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		return;
	end
	return 0;
end

function tbKinZhongZhi:CloseWin()
	if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE); end
	if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then UiManager:CloseWindow(Ui.UI_REPOSITORY); end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then UiManager:CloseWindow(Ui.UI_ITEMBOX); end
	if UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1 then UiManager:CloseWindow(Ui.UI_EXTBAG1); end
	if UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1 then UiManager:CloseWindow(Ui.UI_EXTBAG2); end
	if UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1 then UiManager:CloseWindow(Ui.UI_EXTBAG3); end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then UiManager:CloseWindow(Ui.UI_SAYPANEL); end
	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then UiManager:CloseWindow(Ui.UI_ITEMGIFT); end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then UiManager:CloseWindow(Ui.UI_SHOP); end
	return 0;
end
