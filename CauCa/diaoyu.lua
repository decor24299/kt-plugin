-------------------------------------------------------
--文件名	：	diaoyu.lua
--创建者	：	灭日猩
--创建时间	：	2011-09-01
--功能描述	：	周末钓鱼帮你找鱼（鱼自己钓吧）
--版权说明	：	欢迎整合，分享喊话请勿更改
------------------------------------------------------
local uidiaoyu = Ui:GetClass("diaoyu");
local uitimer = 0;
local allfishs = {{"Cá Chép.", "Cá Vàng.", "Cá Bống.", "Cá Mè.", "Cá Tầm."},
		  {"Cá Chình Trắng.", "Cá Trắm Cỏ.", "Cá Tuyết.", "Cá Mè Hoa.", "Cá Bá Vương."},
		  {"Cá Đồng.", "Cá Ngao Hoa.", "Cá Đầu To.", "Lươn To.", "Cá Ngát."},
		  {"Cá Trắm.", "Cá Chẽm.", "Cá Chim Trắng.", "Cá Lăng.", "Cá Trích."},
		  {"Cá Trê.", "Cá Kim Long.", "Cá Nóc.", "Cá Chạch.", "Cá Lô."}
		 };

--窗体激活时
function uidiaoyu:OnOpen(nParam)
	PgSet_ActivePage(Ui.UI_diaoyu, "PageSetMain", "PageOne");
	Btn_Check(Ui.UI_diaoyu, "BtnTestThree", Map.tbdiaoyu.nIsshare);
	for i = 1, 5 do
		Btn_Check(Ui.UI_diaoyu, "Diqu"..i, Map.tbdiaoyu.nDiquChk[i]);
	end
	uidiaoyu:ReLoadfish();
	uitimer =  Ui.tbLogic.tbTimer:Register(18 * 2, self.ReLoadfish, self);
	if not KFile.ReadTxtFile("\\interface2\\CauCa\\fixloi.txt") then
		Wnd_SetPos(Ui.UI_diaoyu, "BtnKeyReload", 999, 999); -- 调试
	end
end

--窗体关闭时
function uidiaoyu:OnClose()
	Ui.tbLogic.tbTimer:Close(uitimer);
end

--读取保存的数据
function uidiaoyu:ReLoadfish()
--	me.Msg("窗体刷新中！");
	for i = 1, 5 do
		for j = 1, 5 do
			Wnd_SetEnable(Ui.UI_diaoyu, "Btndq" .. i .. j, 0);
		end
	end

	if Map.tbdiaoyu:Infishtime() == 0 then -- 是否在活动时间
		if Map.tbdiaoyu.nAllfish ~= "*Không tự ý thay đổi các tọa độ" then
			Map.tbdiaoyu.nAllfish = "*Không tự ý thay đổi các tọa độ";
			KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", Map.tbdiaoyu.nAllfish);
		end
		return;
	end

	Map.tbdiaoyu.nAllfish = KFile.ReadTxtFile("\\interface2\\CauCa\\diaoyu.txt"); -- 防止多开，及时刷新

	for i = 1, 5 do
		for j = 1, 5 do
			if string.find(Map.tbdiaoyu.nAllfish, allfishs[i][j] .. "<") then
				Wnd_SetEnable(Ui.UI_diaoyu, "Btndq" .. i .. j, 1);
				local lPos1 = string.find(Map.tbdiaoyu.nAllfish, allfishs[i][j] .. "<");
				local lPos2 = string.find(Map.tbdiaoyu.nAllfish, ">", lPos1);
				local tbSplit	= Lib:SplitStr(string.sub(Map.tbdiaoyu.nAllfish, lPos1, lPos2), ",");
				local tbSplit	= Lib:SplitStr(tbSplit[1], "=");
				Wnd_SetTip(Ui.UI_diaoyu, "Btndq" .. i .. j, GetMapNameFormId(tonumber(tbSplit[2])));
			end
		end
	end
end
-- 鼠标点击事件
uidiaoyu.OnButtonClick = function(self, szWnd, nParam)
	if (szWnd == "BtnClose") then
		--关闭窗口
		UiManager:CloseWindow(Ui.UI_diaoyu);
	elseif (szWnd == "BtnKeyReload") then
		--重载键盘配置
		Ui.tbLogic.tbTimer:Close(uitimer);
		uidiaoyu:Reload();
	elseif (szWnd == "BtnKey1") then
		if Map.tbdiaoyu.nDiquChk[1] + Map.tbdiaoyu.nDiquChk[2] + Map.tbdiaoyu.nDiquChk[3] + Map.tbdiaoyu.nDiquChk[4] + Map.tbdiaoyu.nDiquChk[5] == 0 then
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=blank><color=white>Chọn khu vực muốn tìm cá,sau đó bắt đầu！");
			return;
		end
		me.Msg("Bắt đầu đọc tọa độ cá！");
		UiManager:CloseWindow(Ui.UI_diaoyu);
		Map.tbdiaoyu:zhaoyu1();
		
		
	elseif (szWnd == "BtnKey2") then
		me.Msg("Ngừng tìm kiếm cá！");
		Map.tbdiaoyu:stopall();
		UiManager:CloseWindow(Ui.UI_diaoyu);
	elseif string.find(szWnd, "Diqu") then
		if Map.tbdiaoyu.nDiquChk[tonumber(string.sub(szWnd, 5, 5))] == 1 then
			Map.tbdiaoyu.nDiquChk[tonumber(string.sub(szWnd, 5, 5))] = 0;
		else
			Map.tbdiaoyu.nDiquChk[tonumber(string.sub(szWnd, 5, 5))] = 1;
		end
	elseif (szWnd == "BtnTestThree") then
		if Map.tbdiaoyu.nIsshare == 1 then
			Map.tbdiaoyu.nIsshare = 0;
		else
			Map.tbdiaoyu.nIsshare = 1;
		end
	elseif (szWnd == "BtnExit") then
		--清除所有数据
		Map.tbdiaoyu.nAllfish = "*Không tự ý thay đổi các tọa độ";
		KFile.WriteFile("\\interface2\\CauCa\\diaoyu.txt", Map.tbdiaoyu.nAllfish);
		uidiaoyu:ReLoadfish();
		me.Msg("Thông tin vị trí cá đã được xóa！")
		UiManager:CloseWindow(Ui.UI_diaoyu);
	elseif string.find(szWnd, "Btndq") then
		local lfish = allfishs[tonumber(string.sub(szWnd, 6, 6))][tonumber(string.sub(szWnd, 7, 7))];
		local lPos1 = string.find(Map.tbdiaoyu.nAllfish, lfish .. "<");
		if lPos1 then
			lPos1 = string.find(Map.tbdiaoyu.nAllfish, "=", lPos1);
			local lPos2 = string.find(Map.tbdiaoyu.nAllfish, ">", lPos1);
			-- 主动帮助别人（特殊背包物品放置）
			----------------------------------
			local pItem1 = me.GetItem(Item.ROOM_MAINBAG, 4, 4);
			local pItem2 = me.GetItem(Item.ROOM_MAINBAG, 0, 7);
			if pItem1 and pItem2 then
				if pItem1.szName .. pItem2.szName == "Cẩm nang cá" then
					SendChatMsg(lfish .. "<pos=" .. string.sub(Map.tbdiaoyu.nAllfish, lPos1 + 1, lPos2 - 1) .. ">");
					return;
				end
				local ldiqufish = "";
				if pItem1.szName .. pItem2.szName == "Thực hành Pearl Phòng Thương mại hộp bộ sưu tập thẻ" then
					local ldiqu = tonumber(string.sub(szWnd, 6, 6));
					for i = 1, 5 do
						local lPos3 = string.find(Map.tbdiaoyu.nAllfish, allfishs[ldiqu][i] .. "<");
						if lPos3 then
							lPos3 = string.find(Map.tbdiaoyu.nAllfish, "=", lPos3);
							local lPos4 = string.find(Map.tbdiaoyu.nAllfish, ">", lPos3);
							local tbSplit	= Lib:SplitStr(string.sub(Map.tbdiaoyu.nAllfish, lPos3 + 1, lPos4 - 1), ",");
							ldiqufish = ldiqufish .. allfishs[ldiqu][i] .. ":" .. GetMapNameFormId(tonumber(tbSplit[1])) .. ";"
--							me.Msg(allfishs[ldiqu][i] .. ":" .. GetMapNameFormId(tonumber(tbSplit[1])) .. ";");
						end
					end
					SendChatMsg(ldiqufish);
					return;
				end
			end
			----------------------------------
			me.Msg(lfish .. "," .. string.sub(Map.tbdiaoyu.nAllfish, lPos1 + 1, lPos2 - 1));
--			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = lfish .. "," .. string.sub(Map.tbdiaoyu.nAllfish, lPos1 + 1, lPos2 - 1)});
			UiManager.tbLinkClass["pos"]:OnClick(lfish .. "," .. string.sub(Map.tbdiaoyu.nAllfish, lPos1 + 1, lPos2 - 1));
			UiManager:CloseWindow(Ui.UI_diaoyu);
		end
	end
end
--重新载入周末钓鱼插件（插件程序调试使用）
function uidiaoyu:Reload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
--	fnDoScript("\\interface\\\增强背包\\区分物品.lua");
--	fnDoScript("\\interface\\救助玉兔\\Jiuyutu.lua");
	fnDoScript("\\interface2\\CauCa\\diaoyu.lua");
	fnDoScript("\\interface2\\CauCa\\diaoyu1.lua");
	me.Msg("thành công tải lại câu cá！")
end
--注册插件窗体位置
Ui:RegisterNewUiWindow("UI_diaoyu", "diaoyu", {"a", 215, 75}, {"b", 215, 75}, {"c", 215, 75});
--注册插件热键
local tCmd={ "UiManager:SwitchWindow(Ui.UI_diaoyu)", "UI_diaoyu", "", "Shift+B", "Shift+B", "周末钓鱼"};
        AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	-----快捷键Shift+B
