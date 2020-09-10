local tbTimer = Ui.tbLogic.tbTimer;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

Ui.UI_DETECTOR = "Ui.UI_DETECTOR";
local uiDetector =  Map.uiDetector or {};--Ui.tbWnd[UI_DETECTOR]
Map.uiDetector	 = uiDetector;
local self  = uiDetector
uiDetector.nTimerId = 0;
local sTimerOsy = 0
local ChouRen =0;
local X0,Y0 = 0,0;
local nDirection = 0;
self.nSwitch = 0;
self.Track = 0;
 
function uiDetector:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	uiDetector.Say_bak	= uiDetector.Say_bak or uiMsgPad.OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway, nSpeTitle)
		uiDetector.Say_bak(uiMsgPad, szChannelName, szName, szMsg, szGateway, nSpeTitle);
		local function fnOnSay()			
			uiDetector:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle);
			return 0;
		end

		Ui.tbLogic.tbTimer:Register(1,fnOnSay);
	end
end

function uiDetector:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle)
	
	if  string.find(szMsg,"Boss") and szChannelName=="Team" then
		local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
		local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
		local str = Lib:SplitStr(szMsg, ",");
		if nMapId ~= tonumber(str[3]) then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],str[2]) then
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1);
					end					
				end	
			else
				if me.GetItemCountInBags(18,1,85,1) > 0 then
					local tbFind = me.FindItemInBags(18,1,85,1);
					for j, tbItem in pairs(tbFind) do
						me.UseItem(tbItem.pItem);
					end
				end
			end
		else
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
			return Env.GAME_FPS * 1
		end	
	end
	
end

function uiDetector:OnInit()
	print("uiDetector:OnInit()");
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		print("Ui:EnterGame()");
		uiDetector.EnterGame_bak(Ui);
	end

	local szCmd	= [=[
		Map.uiDetector:Switch();
	]=];
	UiShortcutAlias:AddAlias("GM_C2", szCmd);	-- 热键：Ctrl+2
end

--开关
function uiDetector:Switch()
	if (self.nSwitch == 0 and self.Track == 0) then
		self.nSwitch = 1;
		sTimerOsy = Ui.tbLogic.tbTimer:Register(1,self.ModifyUi,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Mở thăm dò tìm BOSS");
		uiDetector.nTimerId = tbTimer:Register(Env.GAME_FPS*1, uiDetector.OnTimer, uiDetector);
	--elseif (self.nSwitch == 1 and self.Track == 0) then
		--self.Track = 1;
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=yellow>开启追踪提示");
	else
		self.nSwitch, self.Track = 0,0;
		UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đóng thăm dò tìm BOSS");
		tbTimer:Close(uiDetector.nTimerId);
	end
end

function uiDetector:OnTimer()
	for _, pNpc in ipairs(KNpc.GetAroundNpcList(me, 120)) do
		if me.HasRelation(pNpc.szName, 4) == 1 and me.nFightState == 1 then
			local Class = "Cừu nhân"
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos(); --仇人位置
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);

			if (pNpc.szName == ChouRen and nPosX == X0 and nPosY == Y0) then
				return;
			else
				Ui.tbLogic.tbMsgInfo:Clear();
				ChouRen = pNpc.szName;
				X0,Y0 = nPosX, nPosY;
				nDirection = uiDetector:GetDirection(nX,nY);
				PlaySound("\\interface2\\All\\enemy.wav", 0);
				me.Msg(string.format("Chú ý! Phát hiện cừu nhân[<color=yellow>%s<color>]<color=yellow>%d<color>Cấp，phía trước môn phái：<color=yellow>%s<color>，Vị Trí <color=yellow>%s %d/%d<color>",pNpc.szName,pNpc.nLevel,Player.tbFactions[pNpc.nFaction].szName,nDirection,tostring(nPosX),tostring(nPosY)));
				if self.Track == 1 then
					Map.uiDetector:Tracking(Class,szName,nX,nY);
				end
			end
		elseif pNpc.nTemplateId == 7278 then --年兽
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);
			me.AutoPath(nX,nY);
			local tbFind = me.FindItemInBags(18,1,1167,1);--鞭炮
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				break;
			end
		elseif pNpc.GetNpcType() == 1 then
			local Class = "Quái Tinh Anh"
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);

			if (nPosX == X0 and nPosY == Y0) then
				return;
			else
				Ui.tbLogic.tbMsgInfo:Clear();
				X0,Y0 = nPosX, nPosY;
				nDirection = uiDetector:GetDirection(nX,nY);
				PlaySound("\\interface2\\All\\enemy.wav", 0);
				me.Msg(string.format("Chú ý! Phát hiện Quái Tinh Anh[<color=yellow>%sTinh anh<color>]vị trí<color=yellow>%s %d/%d<color>",pNpc.szName,nDirection,tostring(nPosX),tostring(nPosY)));
				--Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>注意！Phát hiện thấy精英怪："..pNpc.szName.."，Ở vào"..nDirection.." "..tostring(nPosX).."/"..tostring(nPosY));
				if self.Track == 1 then
					Map.uiDetector:Tracking(Class,szName,nX,nY);
				end
			end

		elseif pNpc.GetNpcType() == 2 then
			local Class = "Quái Thủ Lĩnh"
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);

			if (nPosX == X0 and nPosY == Y0) then
				return;
			else
				Ui.tbLogic.tbMsgInfo:Clear();
				X0,Y0 = nPosX, nPosY;
				nDirection = uiDetector:GetDirection(nX,nY);
				PlaySound("\\interface2\\All\\enemy.wav", 0);
				me.Msg(string.format("Chú ý! Phát hiện Quái Thủ Lĩnh[<color=yellow>%s·Thủ lĩnh<color>]Vị trí<color=yellow>%s %d/%d<color>",pNpc.szName,nDirection,tostring(nPosX),tostring(nPosY)));
				--Ui(Ui.UI_TASKTIPS):Begin("<bclr=red><color=yellow>注意！Phát hiện thấy首领怪："..pNpc.szName.."，Ở vào"..nDirection.." "..tostring(nPosX).."/"..tostring(nPosY));
				if self.Track == 1 then
					Map.uiDetector:Tracking(Class,szName,nX,nY);
				end
			end
		elseif pNpc.nTemplateId == 3633 then --颜如玉（闲逛）3633
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);
			me.AutoPath(nX,nY);
		elseif pNpc.nTemplateId == 7250 then --圣诞老人
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);
			me.AutoPath(nX,nY);
		elseif pNpc.nTemplateId == 2703 then --颜如玉2703
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			if (nPosX == X0 and nPosY == Y0) then
				return;
			else
				X0,Y0 = nPosX, nPosY;
				SendChannelMsg("Team","Phát hiện Nhan như ngọc ở <pos="..nM..","..nPosX..","..nPosY..">，bà con mau tới！")
				if	UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
					AutoAi.SetTargetIndex(pNpc.nIndex);
				end
			end
		
		elseif pNpc.nTemplateId == 2964 then --颜如玉2964
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			if (nPosX == X0 and nPosY == Y0) then
				return;
			else
				X0,Y0 = nPosX, nPosY;
				SendChannelMsg("Tong","Phát hiện thằng thương nhân ở <pos="..nM..","..nPosX..","..nPosY..">，bà con mau tới！")
				if	UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
					AutoAi.SetTargetIndex(pNpc.nIndex);
				end
			end
		

		elseif pNpc.nTemplateId == 3140 then		--恶狼
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện Sói Hoang_Hồi máu[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3150 then		--鳄鱼
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện Cá sấu[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3153 then		--花豹
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Báo Đốm[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3156 then		--野猴
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Khỉ Hoang[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3141 then		--野狼
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Sói Hoang[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3144 then		--黑熊
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Gấu đen[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3147 then		--黄虎
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Hổ Vàng[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3165 then		--蝮蛇
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy: Rắn Hổ[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3166 then		--叛军士兵
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Sĩ Binh Phản Quân[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3173 then		--果农
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Quả Nông[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3179 then		--幽冥鬼
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy U Minh Quỷ[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 3183 then		--闯谷贼
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Sấm cốc tặc[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 5005 then		--逍遥谷张德恒
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Trương đức hằng[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 4474 then		--逍遥谷宝果子
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Bảo quả tử[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 4476 then		--逍遥谷二丫
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Nhi A[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 4478 then		--逍遥小荷
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Tiểu Hà[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 4480 then		--逍遥谷小楚
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Tiểu sở[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		elseif pNpc.nTemplateId == 2701	then
			local _, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX/8);
			local nPosY = math.floor(nY/16);

			if (nPosX == X0 and nPosY == Y0) then
				return;
			else
				X0,Y0 = nPosX, nPosY;
				AutoAi.SetTargetIndex(pNpc.nIndex);
				SendChannelMsg("Team","Phát hiện thấy Cờ Tầm Bảo[Ở vào "..tostring(nPosX).."/"..tostring(nPosY).."，大家快来！")
				if	UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQuestion(0);
				else
					AutoAi.SetTargetIndex(pNpc.nIndex);
				end
			end
		elseif pNpc.nTemplateId == 2401	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Vân tuyết sơn ( thổ ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2402	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Hình bộ đầu ( thổ ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2403	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Vạn Lão điên ( hỏa ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2404	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Cao Sĩ Hiền ( mộc ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2405	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Thác Bạt Sơn Uyên ( kim ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 2406	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Dương Liễu ( thủy ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 2407	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Thần Thương Phương Vãn ( kim ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2408	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Triệu ứng Tiên ( mộc ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2409	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Hương Ngọc Tiên ( thủy ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2410	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Man Tăng Bất Giới hòa thượng ( hỏa ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2411	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Nam Quách Nho ( thổ ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2421	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Nhu Tiểu Thúy ( kim ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		elseif pNpc.nTemplateId == 2422	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Trương Thiện đức ( mộc ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		elseif pNpc.nTemplateId == 2423	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Giả Dật Sơn (thủy):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			
		elseif pNpc.nTemplateId == 2424	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Ô Sơn Thanh ( hỏa ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		elseif pNpc.nTemplateId == 2425	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Trần Vô Mệnh ( thổ ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		elseif pNpc.nTemplateId == 3124	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			SendChannelMsg("Team","Boss,"..me.szName..","..nM..",Bach Vo Thuong :Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 2426	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			SendChannelMsg("Team","Phát hiện thấy Tần Thủy Hoàng-Tử Vi(vô):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 2475	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Tần Thủy Hoàng-Mị Ảnh(vô):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2474	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Tần Thủy Hoàng-Hoan Thần(Vô):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2451	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Đồ Tôn Tần Lăng_Tiểu BOSS (Kim):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		------- Tầng Lăng--------
		elseif pNpc.nTemplateId == 2452	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy iên Viên Thanh Thanh	Tần Lăng_Tiểu BOSS (Mộc):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2453	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Thái Sử Khang	Tần Lăng_Tiểu BOSS (Thủy):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2454	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Bạch Khởi	Tần Lăng_Tiểu BOSS (Hỏa):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2455	then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);

			SendChannelMsg("Team","Phát hiện thấy Thủ Lăng Cơ Quan Nhân	Tần Lăng_Tiểu BOSS (Thổ):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2432	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện thấy Quỷ Mẫu Tinh Anh Tần Lăng 2 [<color=yellow>Quỷ mẫu<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện thấy Quỷ mẫu:Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2435	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện Lý Thanh Tinh Anh Tần Lăng[<color=yellow>Lý Thanh<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện Lý Thanh Tinh Anh Tần Lăng:Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2438	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện Khiên Hồn sư[<color=yellow>Khiên hồn sư<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện khiên hồn sư，Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 2429	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện Tà Hồn Sư[<color=yellow>Tà Hồn Sư<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện tà hồn sư，Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		------ Lâu Lan------
		elseif pNpc.nTemplateId == 7366	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện Thiện Thiện-A Y Hãn	BOSS Lâu Lan[<color=yellow>Lâu Lan Vương Tử<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện đại BOSS Thiện Thiện-A Y Hãn BOSS Lâu Lan:Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 7353	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện thấy Quái Tinh Anh：<color=yellow>Luân Hồi Sử Giả<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện luân hồi sử giả:Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 7354	then
			local szName = pNpc.szName;
			local nM, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			me.Msg(string.format("Phát hiện thấy Quái Tinh Anh[<color=yellow>Đại mạc vu sư<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
			SendChannelMsg("Team","Phát hiện đại mạc vu sư:Ở vào <pos="..nM..","..nPosX..","..nPosY..">")

		elseif pNpc.nTemplateId == 7364 then		--荒漠羚羊
			local szName = pNpc.szName;
			local _, nX, nY	= pNpc.GetWorldPos();
			nDirection = uiDetector:GetDirection(nX,nY);	 
			me.Msg(string.format("Phát hiện thấy Linh Dương Hoang Mạc[<color=yellow>%s<color>]Ở vào<color=yellow>%s <color>",pNpc.szName,nDirection));
		------ Khắc Di Môn-----
		elseif pNpc.nTemplateId == 20211 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posNhat.txt", szpos);
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ (Nhật):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Nhật):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 20212 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posNguyet.txt", szpos);	
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ(Nguyệt):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Nguyệt):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			
		elseif pNpc.nTemplateId == 20213 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posPhong.txt", szpos);
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ(Phong):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Phong):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
		
		elseif pNpc.nTemplateId == 20214 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posVan.txt", szpos);
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ (Vân):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Vân):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			
		elseif pNpc.nTemplateId == 20215 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posLoi.txt", szpos);
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ (Lôi):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Lôi):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
					
		elseif pNpc.nTemplateId == 20216 then
			local nM, nX, nY	= pNpc.GetWorldPos();
			local nPosX = math.floor(nX);
			local nPosY = math.floor(nY);
			local szpos = nM..","..nX..","..nY
			KIo.WriteFile("\\interface2\\Kato\\BaoBoss\\posDien.txt", szpos);	
			SendChannelMsg("Team","Đã thấy Long Hồn Sứ (Điện):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			SendChannelMsg("Kin","Đã thấy Long Hồn Sứ(Điện):Ở vào <pos="..nM..","..nPosX..","..nPosY..">")
			
		end
	end
end

function uiDetector:GetDirection(nX,nY)
	local _, x, y	= me.GetWorldPos();
	local nDistance = math.sqrt((nY-y)^2+(nX-x)^2)
	local nDegree = math.deg(math.asin((y-nY)/nDistance));
	if nDegree <= 22.5 and nDegree >= -22.5 then
		if nX > x then
			nDirection = "Bên phải";
		elseif nX < x then
			nDirection = "Bên trái";
		end
	elseif nDegree > 22.5 and nDegree <= 67.5 then
		if nX > x then
			nDirection = "Phía trên phải";
		elseif nX < x then
			nDirection = "Phía trên trái";
		end
	elseif 	nDegree > 67.5 and nDegree <= 90 then
		nDirection = "Phía trên";
	elseif nDegree < -22.5 and nDegree >= -67.5 then
		if nX > x then
			nDirection = "phía dưới phải";
		elseif nX < x then
			nDirection = "phía dưới trái";
		end
	elseif 	nDegree < -67.5 and nDegree >= -90 then
		nDirection = "phía dưới";
	end
	return nDirection;
end

function uiDetector:Tracking(Class,szName,nX,nY)
	local tbMsg = {};
	tbMsg.szTitle = "Hệ thống thăm dò và theo dõi";
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Không", "Có" };
	tbMsg.nTimeout = 10;
	tbMsg.szMsg = "Phát hiện thấy "..Class.." <color=yellow>"..szName.."<color>，đi đến ko？";
	function tbMsg:Callback(nOptIndex, varParm1, varParam2, ...)
		if (nOptIndex == 0 or nOptIndex == 1) then
			return;
		elseif (nOptIndex == 2) then
			me.StartAutoPath(nX,nY);
		end
	end
	local szKey = "MsgBoxExample";
	tbMsgInfo:AddMsg(szKey, tbMsg, "Có", "Không", "...");
end
uiDetector:OnInit();
