local tbKhongTuoc		= Ui.tbKhongTuoc or {};
Ui.tbKhongTuoc	= tbKhongTuoc
local self			= tbKhongTuoc 
local Dem,m = 0,0
self.state = 0;
local sTimer = 0
local sTimerOsy = 0
local tCmd={"Ui.tbKhongTuoc:State()", "Ui.tbKhongTuoc", "", "Shift+G", "Shift+G", "dmm"};
	 AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	 
function tbKhongTuoc:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbKhongTuoc.Say_bak	= tbKhongTuoc.Say_bak or uiMsgPad.OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway, nSpeTitle)
		tbKhongTuoc.Say_bak(uiMsgPad, szChannelName, szName, szMsg, szGateway, nSpeTitle);
		local function fnOnSay()			
			tbKhongTuoc:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle);
			return 0;
		end

		Ui.tbLogic.tbTimer:Register(1,fnOnSay);
	end
end
function tbKhongTuoc:OnSay(szChannelName, szName, szMsg, szGateway, nSpeTitle)
	if string.find(szMsg,"Hoàn thành.") and szChannelName == "GM" then
		if Dem == 8 then
			Dem = 9
			return Env.GAME_FPS * 1
		elseif Dem == 20 then
			Dem = 21
			return Env.GAME_FPS * 1
		elseif Dem == 26 then
			Dem = 27
			return Env.GAME_FPS * 1
		elseif Dem == 36 then
			Dem = 37
			return Env.GAME_FPS * 1	
		elseif Dem == 38 then
			Dem = 39
			return Env.GAME_FPS * 1		
		end
	elseif string.find(szMsg,"chưa đến giai đoạn") and szChannelName == "GM" then
		if Dem == 38 then
			Dem = 39
			return Env.GAME_FPS * 1	
		elseif Dem == 20 then
			Dem = 21
			return Env.GAME_FPS * 1	
		end
	elseif string.find(szMsg,"Bật lửa gỗ") or string.find(szMsg,"không thể phóng hỏa") or string.find(szMsg,"vật phẩm nhiệm vụ") and szChannelName == "GM" then
		if Dem == 38 then
			Dem = 39
			return Env.GAME_FPS * 1	
		elseif Dem == 20 then
			Dem = 21
			return Env.GAME_FPS * 1	
		end		
	end	
			
	if  string.find(szMsg,"Tăng Dem") and szChannelName=="Team" then
		Dem = Dem + 1
	end
	if  string.find(szMsg,"Giảm Dem") and szChannelName=="Team" then
		Dem = Dem - 1
	end
	if  string.find(szMsg,"tieptuc") and szChannelName=="Team" then
		Dem = tonumber(string.sub(szMsg,1,2))
		--Dem = Dem + 1
	end
	if  string.find(szMsg,"Step") and (szChannelName=="Team" or szChannelName=="GM") then
		for i=1,44 do
			local str = "Step "..i
			if szMsg == str then
				Dem = i
				break
			end	
		end
	end
	
end

function tbKhongTuoc:State()	
	if self.state == 0 then
		sTimerOsy = Ui.tbLogic.tbTimer:Register(1,self.ModifyUi,self);
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 1.5,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu nhiệm vụ khổng tước hà <color>");
		self.state = 1
	else	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimerOsy);
		Ui.tbLogic.tbTimer:Close(sTimer);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		self.CloseWindows()
	end	
end
function tbKhongTuoc.DoiThoaiNPC(idNPC)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
		for _, pNpc in ipairs(tbAroundNpc) do		
			if (pNpc.nTemplateId == idNPC) then					
				AutoAi.SetTargetIndex(pNpc.nIndex)
			end
		end
end
function tbKhongTuoc.OnTimer()	
	if self.state == 0 then	return  end
		me.Msg("Dem: "..Dem)
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if me.IsDead() == 1 then
		Dem = Dem - 1
		me.SendClientCmdRevive(0);
	end
	me.CreateTeam()
	if Dem == 0 then
		if nMyPosX==1807 and nMyPosY==3614 then
			Dem = 1 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1807,3614"});
		end	
	end
	if Dem == 1 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Giương đông kích tây") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						Dem = 2
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
				Dem = 2
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
		end
		
	end
	if Dem == 2 then 
		if nMyPosX==1805 and nMyPosY==3475 then
			Dem = 3 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1805,3475"});
		
		end
	end
	if Dem == 3 then 
		if nMyPosX==1850 and nMyPosY==3137 then
			Dem = 4 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1850,3137"});
		end
	end
	if Dem == 4 then 
		if nMyPosX==1678 and nMyPosY==3136 then
			Dem = 5 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1678,3136"});
		end
	end
	
	if Dem == 5 then 
		if nMyPosX==1869 and nMyPosY==3278 then
			Dem = 6 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1869,3278"});
		end
	end
	if Dem == 6 then -- Di lau lan nhặt hoa sen
		if me.GetNpc().IsRideHorse() ~= 0 then
			Switch([[horse]]);
		end
		me.AutoFight(1)
			if me.FindItemInBags(20,1,951,1)[1] then
				Dem = 7 
				return Env.GAME_FPS * 1
			else
				local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
				local tbAroundNpc	= KNpc.GetAroundNpcList(me, 1000);
				for _, pNpc in ipairs(tbAroundNpc) do		
					AutoAi.SetTargetIndex(pNpc.nIndex);
					AutoAi.PickAroundItem(Space)
				end	
				
			end
	end
	
	if Dem == 7 then 
		if nMyPosX==1702 and nMyPosY==3235 then
			Dem = 8 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1702,3235"});
		end
	end
	
	
	if Dem == 8 then
		if me.GetNpc().IsRideHorse() ~= 0 then
			Switch([[horse]]);
		end
		me.AutoFight(1)
		return Env.GAME_FPS * 1
	end
	
	if Dem == 9 then	
		if nMyPosX==1729 and nMyPosY==3286 then
			Dem = 10
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1729,3286"});
		end
	end
	if Dem == 10 then
		if me.FindItemInBags(20,1,951,1)[1] then
			local tbFind = me.FindItemInBags(20,1,951,1);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				--	break
					return Env.GAME_FPS * 15
				end
		else
			Dem = 11
			return Env.GAME_FPS * 1
		end	
	end
	if Dem == 11 then
		if nMyPosX==1807 and nMyPosY==3614 then
			Dem = 12 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1807,3614"});
		end	
	end
	if Dem == 12 then 
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Giương đông kích tây") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						Dem = 13
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
				Dem = 13
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
		end
	end
	
	if Dem == 13 then
		if nMyPosX==1807 and nMyPosY==3614 then
			Dem = 14 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1807,3614"});
		end	
	end
	if Dem == 14 then 
		if m==2 then
			Dem = 15
			m = 0 
		end	
			
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Cốc Khoáng") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
				
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
			m = m + 1
		end
	end
	
	if Dem == 15 then 
		if nMyPosX==1639 and nMyPosY==3291 then
			Dem = 16 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1639,3291"});
		end
	end
	
	if Dem == 16 then
		if me.GetItemCountInBags(20,1,955,1) == 5 then 
			Dem = 17
			return Env.GAME_FPS * 1
		else
			tbKhongTuoc.DoiThoaiNPC(11394);	
			return Env.GAME_FPS * 6
			
		end	
	end	
	if Dem == 17 then
		if nMyPosX==1843 and nMyPosY==3452 then
			Dem = 18
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1843,3452"});
		end
	end	
	if Dem == 18 then
		if me.GetItemCountInBags(20,1,956,1) == 5 then 
			Dem = 19
			return Env.GAME_FPS * 1
		else
			tbKhongTuoc.DoiThoaiNPC(11401);
			return Env.GAME_FPS * 6			
		end	
	end
	if Dem == 19 then
		if nMyPosX==1818 and nMyPosY==3351 then
			Dem = 20 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1818,3351"});
		end
	end	
	if Dem == 20 then
		tbKhongTuoc.DoiThoaiNPC(11387);	
		return Env.GAME_FPS * 8
	end
	
	if Dem == 21 then
		if nMyPosX==1806 and nMyPosY==3616 then
			Dem = 22 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1806,3616"});
		end
	end	
	if Dem == 22 then 
		if m==2 then
			Dem = 23
			m = 0
			return Env.GAME_FPS * 1
		end	
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Cốc Khoáng") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
			m = m+1	
		end
	end
	if Dem == 23 then
		if nMyPosX==1807 and nMyPosY==3614 then
			Dem = 24 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1807,3614"});
		end	
	end
	if Dem == 24 then 
		if m==2 then
			Dem = 25
			m = 0
			return Env.GAME_FPS * 1
		end	
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"khoáng mạch") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
			m = m+1	
		end
	end
	if Dem == 25 then
		if nMyPosX==1744 and nMyPosY==3146 then
			Dem = 26 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1744,3146"});
		end
	end	
	
	if Dem == 26 then
		if me.GetNpc().IsRideHorse() ~= 0 then
			Switch([[horse]]);
		end
		me.AutoFight(1)
		return Env.GAME_FPS * 1
	end	
	
	if Dem == 27 then
		--if me.AutoFight(1) then me.AutoFight(0) end
		if nMyPosX==1779 and nMyPosY==3268 then
			Dem = 28
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1779,3268"});
		end
	end
	if Dem == 28 then
		if me.AutoFight(1) then me.AutoFight(0) end
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"khoáng mạch") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						Dem = 29 
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
		else
			tbKhongTuoc.DoiThoaiNPC(11393);
		end
	end
	if Dem == 29 then
		if nMyPosX==1807 and nMyPosY==3614 then
			Dem = 30 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1807,3614"});
		end	
	end
	
	if Dem == 30 then 
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"khoáng mạch") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						Dem = 31
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
				Dem = 31
		else
			tbKhongTuoc.DoiThoaiNPC(11390);
		end
	end
	if Dem == 31 then
		if nMyPosX==1775 and nMyPosY==3608 then
			Dem = 32 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1775,3608"});
		end	
	end
	
	if Dem == 32 then 
		if m==4 then
			m=0
			Dem = 33
		end	
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"tra quân") or string.find(tbAnswers[i],"Liên Thiên") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
		else
			tbKhongTuoc.DoiThoaiNPC(11389);
			m=m+1
		end
	end
	
	if Dem == 33 then
		if nMyPosX==1678 and nMyPosY==3647 then 
			Dem = 34 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1678,3647"});
		end	
	end
	if Dem == 34 then 
		
		Map.tbSuperMapLink:move(1674,3651)
		Dem = 35
		return Env.GAME_FPS * 1
	end
	
	if Dem == 35 then	
		if nMyPosX==1850 and nMyPosY==3137 then
			Dem = 36
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1850,3137"});
		end
	end
	if Dem == 36 then
		if me.nFightState==1 then
			if me.FindItemInBags(20,1,958,1)[1] then
				local tbFind = me.FindItemInBags(20,1,958,1);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				--	break
					Dem = 37
					return Env.GAME_FPS * 8
				end
			end	
		else
			Dem =33
		end	
	end
	if Dem == 37 then
		if me.nFightState==1 then	
			if nMyPosX==1818 and nMyPosY==3351 then
				Dem = 38 
				return Env.GAME_FPS * 1
			else
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1818,3351"});
			end
		else
			Dem =33
		end	
	end	
	if Dem == 38 then
		if me.nFightState==1 then	
			tbKhongTuoc.DoiThoaiNPC(11387);	
			return Env.GAME_FPS * 8
		else 
			Dem = 33
		end	
	end
	
	if Dem == 39 then 
		if nMyPosX==1868 and nMyPosY==3007 then
			Dem = 40 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1868,3007"});
		
		end
	end
	if Dem == 40 then 
		Map.tbSuperMapLink:move(1872,3002)
		Dem =41
		return Env.GAME_FPS * 1	
	end
	if Dem == 41 then
		if nMyPosX==1775 and nMyPosY==3608 then
			Dem = 42 
			return Env.GAME_FPS * 1
		else
			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2316,1775,3608"});
		end	
	end
	
	if Dem == 42 then 
		if m==4 then
			m=0
			Dem = 43
		end	
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"tra quân") or string.find(tbAnswers[i],"Liên Thiên") then
						me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
						return Env.GAME_FPS * 1, me.AnswerQestion(i-1)
					end					
				end
		else
			tbKhongTuoc.DoiThoaiNPC(11389);
			m=m+1
		end
	end
	
	
	if Dem == 43 then
		tbKhongTuoc:State();
	end
end

function tbKhongTuoc.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
	end
end
function tbKhongTuoc:Stop()	
	if self.state == 1 then
		self:State();
	end
	return;
end
function tbKhongTuoc:Start()	
	if self.state == 0 then
		self:State();
	end
	return;
end
