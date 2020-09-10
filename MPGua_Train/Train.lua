local Train = Ui:GetClass("Train");
Train.tbTrain = {}
local Now_Pos = 1
local Timer = 0
Train.state = 0
Train.nItemSelec = 0
Train.tbMapLevel = {}
Train.nCurMapId = nil
local nSoLuongHuyenTinhDaDatVao = 0
local self				= Train;

function Train.Train_State()
	if Train.state == 0 then
		Train.LoadData(Train.nCurMapId or me.nTemplateMapId)
		Train.state = 1
		me.Msg("<bclr=red><color=white>Bật luyện công tự động")
		me.Msg("Bật luyện công tự động")
		Timer = Ui.tbLogic.tbTimer:Register(18,Train.Train_OnTimer);
		Btn_SetTxt("UI_TRAIN","BtnStart","Kết thúc");
	else
		Train.state = 0
		Ui.tbLogic.tbTimer:Close(Timer);
		me.Msg("<bclr=blue><color=white>Tắt luyện công tự động")
		me.Msg("Tắt luyện công tự động")
		Timer = 0
		Btn_SetTxt("UI_TRAIN","BtnStart","Bắt đầu");
	end
end

function Train.Train_OnTimer()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	me.GetNpc().SetTitle("luyện công <color=yellow>"..GetMapNameFormId(Train.nCurMapId or me.nTemplateMapId))
	Train.LocVatPham()
	Train.AutoFood()
-----------------------------------------------------------------
	-- local tbFind = me.FindItemInBags(18,1,53,1);
	local tbFind = me.FindItem(18,1,53,1);
	for _, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
			if me.nAutoFightState == 1 then
				Train.StopAutoFight();	-- me.AutoFight(0)
			end
			for Space = 0,100 do
				AutoAi.PickAroundItem(Space);
			end
	end
---------------------------------------------------------------------
	if me.nFightState == 0 then
		if Train.CanMuaFood() == 1 then
			Train.MuaThucAn()
			return
		end
		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			UiManager:CloseWindow(Ui.UI_SHOP);
		end
		-- if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
			-- UiManager:CloseWindow(Ui.UI_ITEMBOX);
		-- end
		-- return
	end
	if Train.GhepHuyenTinh() == 1 then
		return
	end
	local nMyX,nMyY = me.GetNpc().GetMpsPos();
	
	if table.getn(Train.tbTrain) == 0 then
		me.Msg("<bclr=purple><color=white>Bạn chưa thiết lập tọa độ luyện công.<enter> Ấn <color><color=gold>Đọc tọa độ<color><bclr=purple><color=white> để lưu tọa độ hiện tại của nhân vật làm tọa độ luyện công!<color>")
		Train.Train_State()
		return
	end
	if Now_Pos > table.getn(Train.tbTrain) then
		Now_Pos = 1
		return
	end
	
	local cNpc = nil
	local x,y,world = 0,0,0
	local nTargetIndex = AutoAi.AiFindTarget();
	if nTargetIndex > 0 then
		cNpc = KNpc.GetByIndex(nTargetIndex);
		x,y,world = cNpc.GetMpsPos();
	end
	local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
	if me.nTemplateMapId ~= Train.tbTrain[Now_Pos][1] then
		Train.GoTo(Train.tbTrain[Now_Pos][1],Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32)
		return
	end
	if Train.KhoangCach(nMyX,nMyY,Train.tbTrain[Now_Pos][2],Train.tbTrain[Now_Pos][3]) >= 800 then
		AutoAi.SetTargetIndex(0);
		if me.nAutoFightState == 1 then
			Train.StopAutoFight();	-- me.AutoFight(0)
		end
		Train.StartAutoPath(Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32)
		--Train.GoTo(Train.tbTrain[Now_Pos][1],Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32)
		
	elseif me.nAutoFightState == 0 then
		if Train.KhoangCach(nMyX,nMyY,Train.tbTrain[Now_Pos][2],Train.tbTrain[Now_Pos][3]) <= 50 then
			local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
			if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
				Switch("horse")
			end
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey()); 	-- me.AutoFight(1)
			-- Now_Pos = Now_Pos+20	--Now_Pos = Now_Pos+1  --bo di
		else
			Train.StartAutoPath(Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32)
		end
	elseif nTargetIndex > 0 then
		if Train.KhoangCach(nMyX,nMyY,x,y) >= 800 and Train.KhoangCach(nMyX,nMyY,Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32) <= 50 then
			me.Msg(tostring(Train.KhoangCach(nMyX,nMyY,x,y)))
			if table.getn(Train.tbTrain) == 1 then return end
			if Now_Pos == table.getn(Train.tbTrain) then
				Now_Pos = 1
			else
				Now_Pos = Now_Pos+1
			end
			AutoAi.SetTargetIndex(0);
			if me.nAutoFightState == 1 then
				Train.StopAutoFight();	-- me.AutoFight(0)
			end
			me.Msg("Thay đổi tọa độ luyện công...")
		elseif Train.KhoangCach(nMyX,nMyY,Train.tbTrain[Now_Pos][2]/32,Train.tbTrain[Now_Pos][3]/32) <= 50 then
			local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
			if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
				Switch("horse")
			end
			if me.nAutoFightState == 0 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey()); 	-- me.AutoFight(1)
			end
			-- Now_Pos = Now_Pos+20	--Now_Pos = Now_Pos+1  --bo di
		end
	
	elseif nTargetIndex <= 0 then
			if table.getn(Train.tbTrain) == 1 then return end
			if Now_Pos == table.getn(Train.tbTrain) then
				Now_Pos = 1
			else
				Now_Pos = Now_Pos+1
			end
			AutoAi.SetTargetIndex(0);
			if me.nAutoFightState == 1 then
				Train.StopAutoFight();	-- me.AutoFight(0)
			end
			me.Msg("Thay đổi tọa độ luyện công...")
	end
end

function Train.StopTrain()
	if Train.state == 1 then
		Train.state = 0
	end
end

function Train.StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function Train.LoadData(nMapId)
	local szData = KIo.ReadTxtFile("\\user\\AutoQD\\"..me.szName.."\\Train.dll");
	if not szData or szData == "" then
		szData = 'local Train = Ui:GetClass("Train");\n'
		KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\Train.dll",szData)
	end
	assert(loadstring(tostring(szData),"\\user\\AutoQD\\"..me.szName.."\\Train.dll"))()


	local szData = KIo.ReadTxtFile("\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(nMapId)..".dll");
	me.Msg(tostring(GetMapNameFormId(nMapId)))
	if not szData or szData == "" then
		szData = "local Train = Ui:GetClass('Train');\nTrain.tbTrain = {}"
		-- KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(nMapId)..".dll",szData)		--dang test
	elseif nMapId == 65 then
		KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(nMapId)..".dll","local Train = Ui:GetClass('Train');\nTrain.tbTrain = {}")
	end

	assert(loadstring(tostring(szData),"\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(nMapId)..".dll"))()
	me.Msg("Đã đọc được <color=yellow>"..table.getn(Train.tbTrain).."<color> tọa độ luyện")
end

function Train.SaveData()
	local szData = 'local Train = Ui:GetClass("Train");\n'
	szData = szData.."Train.MUAFOOD = "..Train.MUAFOOD.."\n"
	szData = szData.."Train.CAPGHEPHT = "..Train.CAPGHEPHT.."\n"
	KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\Train.dll",szData)
end


function Train.Save_Train(tbSave, szData)
	if table.getn(tbSave) == 0 then 
		KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(me.nTemplateMapId)..".dll","local Train = Ui:GetClass('Train'); Train.tbTrain = {}")
		return
	end 
	local szData = "local Train = Ui:GetClass('Train');\nTrain.tbTrain = {"
	for i = 1,table.getn(tbSave) do
		szData = szData.."{"..tbSave[i][1]..","..tbSave[i][2]..","..tbSave[i][3].."},"
	end
	szData = szData.."}"
	KIo.WriteFile("\\user\\AutoQD\\"..me.szName.."\\"..GetMapNameFormId(tbSave[1][1])..".dll",szData)

end

function Train.GhiNhoToaDoTrain()
	if me.nFightState == 0 then
		me.Msg("Không thể lấy tọa độ ở đây!!!")
		return
	end
	local nMyX, nMyY = me.GetNpc().GetMpsPos();
	if table.getn(Train.tbTrain) ~= 0 and me.nTemplateMapId ~= Train.tbTrain[1][1] then
		Train.LoadData(me.nTemplateMapId)
		local nIdx = table.getn(Train.tbTrain)+1
		Train.tbTrain[nIdx] = {me.nTemplateMapId,nMyX,nMyY}
		return
	end
	local nIdx = table.getn(Train.tbTrain)+1
	Train.tbTrain[nIdx] = {me.nTemplateMapId,nMyX,nMyY}
	Train.Save_Train(Train.tbTrain)
	me.Msg(tostring("Add: "..me.nTemplateMapId..","..math.floor(nMyX/8/32)..","..math.floor(nMyY/16/32)))
end

function Train.TimNPC_TEN(sName)
	local tbEnemyList = {}	
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc and pNpc.szName == sName then
			table.insert(tbEnemyList,pNpc)
		end
	end
	return Train.MucTieuGanNhat(tbEnemyList)
end

function Train.MucTieuGanNhat(tblistnpc)
	local npcgannhat = nil
	local khoanggannhat = 5000
	local nMyX, nMyY = me.GetNpc().GetMpsPos();
	for _, pNpc in ipairs(tblistnpc) do
		local Xnpc,Ynpc = pNpc.GetMpsPos();
		local kc_npc = Train.KhoangCach(nMyX, nMyY,Xnpc,Ynpc)
		if kc_npc <= khoanggannhat then
			npcgannhat = pNpc
			khoanggannhat = kc_npc
		end
	end
	if npcgannhat ~= nil then
		return npcgannhat
	end
end


function Train.OnListDClick(self,szWnd,nListItem)
	Train.nItemSelec = nListItem
	Now_Pos = nListItem
	Btn_SetTxt("UI_TRAIN","BtnMapSel",GetMapNameFormId(Train.tbTrain[nListItem][1])..","..math.floor(Train.tbTrain[nListItem][2]/8/32)..","..math.floor(Train.tbTrain[nListItem][3]/16/32));
end

function Train.OnMenuItemSelected(self,szWnd, nItemId, nListItem)
	if szWnd == "ListName" then
		if nItemId == 1 and nListItem ~= 1 then --len
			local tbTrain_up = Train.tbTrain[nListItem]
			local tbTrain_down = Train.tbTrain[nListItem-1]
			table.remove(Train.tbTrain,nListItem)
			table.insert(Train.tbTrain,nListItem,tbTrain_down)
			table.remove(Train.tbTrain,nListItem-1)
			table.insert(Train.tbTrain,nListItem-1,tbTrain_up)
		elseif nItemId == 2 and nListItem ~= table.getn(Train.tbTrain) then --xuong
			local tbTrain_down = Train.tbTrain[nListItem]
			local tbTrain_up = Train.tbTrain[nListItem+1]
			table.remove(Train.tbTrain,nListItem)
			table.insert(Train.tbTrain,nListItem,tbTrain_up)
			table.remove(Train.tbTrain,nListItem+1)
			table.insert(Train.tbTrain,nListItem+1,tbTrain_down)
		elseif nItemId == 3 then -- xoa
			table.remove(Train.tbTrain,nListItem)
		end
		Train.Save_Train(Train.tbTrain)
		Train.Refresh_Gui()
	elseif szWnd == "BtnMaplevel" then
		Train.tbMapLevel = {}
		Btn_SetTxt("UI_TRAIN","BtnMapSel","Không xác định");
		if nItemId and nItemId ~= 65535 then
			for nA,nB in pairs(Map.tbAllBaseMap or {}) do
				local nMapLevel = tonumber(string.match(Map.tbAllBaseMap[nA].szType,"Cấp (%d+)"))
				if nMapLevel == 10*nItemId+5 then
					table.insert(Train.tbMapLevel,Map.tbAllBaseMap[nA].nMapId)
					--table.insert(Train.tbMapLevel,table.getn(Train.tbMapLevel))
				end
			end
			Btn_SetTxt("UI_TRAIN","BtnMaplevel","Cấp "..tostring(10*nItemId+5).." >");
		end
		
	elseif szWnd == "BtnMapSel" then
		Train.nCurMapId = Train.tbMapLevel[nItemId+1]
		--me.Msg(tostring(Train.nCurMapId))
		Train.LoadData(Train.nCurMapId)
		--me.Msg(".")
		if not Train.tbTrain[1] or table.getn(Train.tbTrain) == 0 then
			UiManager:OpenWindow("UI_INFOBOARD","Bản đồ <color=yellow>"..GetMapNameFormId(Train.nCurMapId).."<color> chưa được thiết lập tọa độ luyện!")
			Btn_SetTxt("UI_TRAIN","BtnMapSel",GetMapNameFormId(Train.nCurMapId));
		end
		Train.Refresh_Gui()
	end
end

function Train.OnListRClick(self,szWnd, nParam)
	DisplayPopupMenu("UI_TRAIN",szWnd,3, nParam,
					"Lên", 1,
					"Xuống", 2,
					"Xóa", 3
					);
end

function Train.OnOpen()
	Train.nItemSelec = 0
	Train.LoadData(Train.nCurMapId or me.nTemplateMapId)
	Btn_SetTxt("UI_TRAIN","BtnMapSel","Không xác định");
	
	Txt_SetTxt("UI_TRAIN","TxTGhepHT",Train.CAPGHEPHT)
	Txt_SetTxt("UI_TRAIN","TxTFood",Train.MUAFOOD)

	if Train.state == 1 then
		Btn_SetTxt("UI_TRAIN","BtnStart","Kết thúc");
	else
		Btn_SetTxt("UI_TRAIN","BtnStart","Bắt đầu");
	end
	Train.Refresh_Gui()
end

function Train:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\YeuLamCo129\\Train.txt");
	Train.StopTrain();
	me.Msg("<color=green>Tự động tải lại hoàn thành! ");
end

Train.BTN_CLOSE       	= "BtnClose";
Train.BTN_Exit       	= "BtnExit";
Train.BTN_Save       	= "BtnSave";
Train.BTN_Reload        = "BtnReload";

Train.CAPGHEPHT = 5
Train.MUAFOOD = 5

function Train.OnButtonClick(self,szWnd, nParam)
	if (szWnd == Train.BTN_CLOSE) or (szWnd == Train.BTN_Exit) then
		UiManager:CloseWindow("UI_TRAIN");
	
	elseif (szWnd == Train.BTN_Reload) then
           Train.ScrReload();
	
	elseif szWnd == "BtnAdd" then
		Train.GhiNhoToaDoTrain()
		Train.Refresh_Gui()
	elseif szWnd == "BtnDel" then
		if Train.nItemSelec and Train.nItemSelec ~= 0 then
			if table.getn(Train.tbTrain) ~= 0 then
				table.remove(Train.tbTrain,Train.nItemSelec)
				Train.Save_Train(Train.tbTrain)
				Train.Refresh_Gui()
				me.Msg("Xóa tọa độ luyện thành công")
				Train.nItemSelec = 0
			end
		else
			me.Msg("Xin chọn tọa độ luyện cần xóa trước")
		end
	elseif szWnd == "BtnStart" then
		if Train.state == 0 then
			Train.LoadData(Train.nCurMapId or me.nTemplateMapId)
			Train.Refresh_Gui()
			Train.state = 1
			me.Msg("<bclr=red><color=yellow>Bật Auto luyện công")
			Timer = Ui.tbLogic.tbTimer:Register(18,Train.Train_OnTimer);
			Btn_SetTxt("UI_TRAIN","BtnStart","Kết thúc");
		else
			Train.state = 0
			me.GetNpc().SetTitle("")
			Ui.tbLogic.tbTimer:Close(Timer);
			me.Msg("<bclr=blue><color=White>Tắt Auto luyện công")
			Timer = 0
			Btn_SetTxt("UI_TRAIN","BtnStart","Bắt đầu");
			if me.nAutoFightState == 1 then
				Train.StopAutoFight();	-- me.AutoFight(0)
			end
		end
	elseif szWnd == "BtnMaplevel" then
		DisplayPopupMenu("UI_TRAIN",szWnd,12, nParam,
					"5", 0,
					"15", 1,
					"25", 2,
					"35", 3,
					"45", 4,
					"55", 5,
					"65", 6,
					"75", 7,
					"85", 8,
					"95", 9,
					"105", 10,
					"115", 11
					);
	elseif szWnd == "BtnMapSel" then
		if table.getn(Train.tbMapLevel) > 0 then
			local tbTemp = {}
			for i = 1,table.getn(Train.tbMapLevel) do
				tbTemp[table.getn(tbTemp)+1] = GetMapNameFormId(Train.tbMapLevel[i])
				tbTemp[table.getn(tbTemp)+1] = math.floor(table.getn(tbTemp)/2)
			end
			DisplayPopupMenu("UI_TRAIN",szWnd,table.getn(tbTemp)/2,nParam,unpack(tbTemp))
		end
	----------------------------------------------------------------------------------------
	elseif szWnd == "CapGhepHTinc" then
		if Train.CAPGHEPHT < 12 then
			Train.CAPGHEPHT = Train.CAPGHEPHT + 1
			Txt_SetTxt("UI_TRAIN","TxTGhepHT",Train.CAPGHEPHT)
		end
	Train.SaveData()
	elseif szWnd == "CapGhepHTdec" then
		if Train.CAPGHEPHT > 2 then
			Train.CAPGHEPHT = Train.CAPGHEPHT - 1
			Txt_SetTxt("UI_TRAIN","TxTGhepHT",Train.CAPGHEPHT)
		end
	Train.SaveData()
	-------------------------------------
	elseif szWnd == "CapFoodInc" then
		if Train.MUAFOOD < 20 then
			Train.MUAFOOD = Train.MUAFOOD + 1
			Txt_SetTxt("UI_TRAIN","TxTFood",Train.MUAFOOD)
		end
	Train.SaveData()
	elseif szWnd == "CapFoodDec" then
		if Train.MUAFOOD > 1 then
			Train.MUAFOOD = Train.MUAFOOD - 1
			Txt_SetTxt("UI_TRAIN","TxTFood",Train.MUAFOOD)
		end
	Train.SaveData()
	----------------------------------------------------------------------------------------
	end	
end

function Train.Refresh_Gui()
	Lst_Clear("UI_TRAIN","ListName");
	if Train.tbTrain[1] then
		Btn_SetTxt("UI_TRAIN","BtnMapSel",GetMapNameFormId(Train.tbTrain[1][1]));
	end
	for i = 1,table.getn(Train.tbTrain) do
		Lst_SetCell("UI_TRAIN","ListName", i, 1,i..") "..GetMapNameFormId(Train.tbTrain[i][1]).." ("..math.floor(Train.tbTrain[i][2]/8/32)..","..math.floor(Train.tbTrain[i][3]/16/32)..")")
		Lst_SetLineData("UI_TRAIN","ListName", i,1);
	end
end

function Train.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE);
	end
end
function Train.LocVatPham()
		local tbFind = me.FindClassItemInBags("equip");
		local nSize = Lib:CountTB(tbFind);
		if (nSize == 0) and (nAutoClose == 1) then
		else
			for index, tbItem in ipairs(tbFind) do
				if tbItem and tbItem.pItem.IsBind() ~= 1 then
					local pItem = tbItem.pItem;	
					local nPrice = GetSalePrice(pItem);
					local nMaxLevel = AutoAi:GetMaxBreakUpStuff(pItem);
					local nNeededMagic = AutoAi:GetNeededMagicStatus(pItem);
					local nNeededDarkMagic = AutoAi:GetNeededDarkMagicStatus(pItem);
					if nPrice == 0 and nNeededMagic == 0 and nNeededDarkMagic == 0 and nMaxLevel < 9 then
						me.Msg(tostring("Vứt bỏ <color=green>"..pItem.szName..""))
						me.ThrowAway(tbItem.nRoom, tbItem.nX, tbItem.nY);
					end
				end
			end
		end
end

function Train.GoTo(M,X,Y)
	Train.CloseWindows()
	local Npc_ = KNpc.GetByIndex(AutoAi.AiFindTarget())
	if Npc_ and (Npc_.nDoing == 6 or Npc_.nDoing == 7) then
		local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill,1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then
			Switch("horse")
		end
		AutoAi.DoAttack(me.nLeftSkill,Npc_.nIndex);
		return
	end
	if me.nAutoFightState == 1 then
		Train.StopAutoFight();	-- me.AutoFight(0)
	end
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = ","..M..","..X..","..Y
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo)
end

function Train.KhoangCach(myX,myY,keyX,keyY)
	local nDistance	= 0;
	nDistance = math.sqrt((myX-keyX)^2 + (myY-keyY)^2);
	return nDistance;
end

function Train.GhepHuyenTinh()
	if me.nFightState == 0 or me.CountFreeBagCell() == 0 then
	local k = 0
	
	for i = 1,Train.CAPGHEPHT-1 do
		if me.GetItemCountInBags(18,1,1,i)+me.GetItemCountInBags(18,1,114,i) >= 4 then
			k = i
			break
		end
	end
	
	if k == 0 then
		if  UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
			UiManager:CloseWindow(Ui.UI_ITEMBOX);
		end
		if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
			UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE);
		end
		return 0
	end
	local DaLuyenDaiSu = Train.TimNPC_TEN("Dã Luyện Đại Sư")
	Ui(Ui.UI_COMPOSE):SwitchCompose();
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	return 1
	end
end

function Train.AutoFood()
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if (not nTime or nTime < Env.GAME_FPS * 3)  then
		local tbItemList = me.FindItemInBags(Item.SKILLITEM);
		if((not tbItemList) or (#tbItemList == 0)) then
			return false;
		end
		local pItem = tbItemList[1].pItem;
		if(me.CanUseItem(pItem)) then
			me.Msg("Sử dụng thức ăn <color=yellow>" .. pItem.szName .. "<color>");
			return me.UseItem(pItem);
		end
		return false;
	end
end

function Train.StartAutoPath(x,y)
	local nMyPosX,nMyPosY = me.GetNpc().GetMpsPos()
	if Train.KhoangCach(x*32,y*32,nMyPosX,nMyPosY) > 2000 then
		if me.GetNpc().nIsRideHorse == 0 then
			me.Msg("<color=pink>Tự động lên ngựa")
			Switch("horse")
		end
	end
	if me.nAutoFightState == 1 then
		Train.StopAutoFight();	-- me.AutoFight(0)
	end
	AutoAi.SetTargetIndex(0)
	return me.StartAutoPath(x,y)
end

local OTrong = 6  --so o trong toi thieu trong hanh trang
function Train.CanMuaFood()
if me.nFightState == 0 then
	local lvl = 1
	if me.nLevel >= 90 then
		lvl = 5
	elseif me.nLevel >= 70 then
		lvl = 4
	elseif me.nLevel >= 50 then
		lvl = 3
	elseif me.nLevel >= 30 then
		lvl = 2
	end
	--lvl = 4 -- xoa

	local O_Trong = me.CountFreeBagCell()
	local nCountFood = me.GetItemCountInBags(19,3,1)
	local nMUAFOOD = Train.MUAFOOD-nCountFood
	if nMUAFOOD > O_Trong- OTrong then
		nMUAFOOD = O_Trong-OTrong
	end
	if nMUAFOOD > 0 then
		return 1
	end
end
end

function Train.MuaThucAn()
local nMyMapId	= me.GetMapTemplateId();
if me.nFightState == 0 then
	local lvl = 1
	if me.nLevel >= 90 then
		lvl = 5
	elseif me.nLevel >= 70 then
		lvl = 4
	elseif me.nLevel >= 50 then
		lvl = 3
	elseif me.nLevel >= 30 then
		lvl = 2
	end
	--lvl = 4
	local O_Trong = me.CountFreeBagCell()
	local nCountFood = me.GetItemCountInBags(19,3,1,lvl)
	local nMUAFOOD = Train.MUAFOOD-nCountFood
	
	if nMUAFOOD > O_Trong - OTrong then
		nMUAFOOD = O_Trong-OTrong
	end
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Đi mua thức ăn !")
	--------------------------------------------------------------------------
	---------------------------------------------------------------------
	
	local nMUAFOOD = Train.MUAFOOD-nCountFood
	if nMUAFOOD > O_Trong - OTrong then
		nMUAFOOD = O_Trong-OTrong
	end
	----------------------------------------------------------------------------
	
	if nMUAFOOD > 0 then
		local chutuulau = Train.TimNPC_TEN("Đại Lão Bạch")
		if not chutuulau then
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),3566);
				if Xnpc then
					Train.StartAutoPath(Xnpc,Ynpc)
				end
			return
		end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
		end
		if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			local bOK, szMsg = me.ShopBuyItem(820 + lvl,nMUAFOOD)
			UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
			UiManager:CloseWindow(Ui.UI_SHOP);
		else
			AutoAi.SetTargetIndex(chutuulau.nIndex);
		end
		return 1
	end
end
end


Ui:RegisterNewUiWindow("UI_TRAIN", "Train", {"a",320,200}, {"b", 250, 150}, {"c", 250, 150});
LoadUiGroup("UI_TRAIN", "Train.ini");

local tCmd={ "UiManager:SwitchWindow(Ui.UI_TRAIN)", "Ui.UI_TRAIN", "", "Shift+J", "Shift+J", "TRAIN"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);