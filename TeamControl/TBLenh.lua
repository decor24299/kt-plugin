local TBLenh		= Ui.TBLenh or {};
Ui.TBLenh	= TBLenh
local self			= TBLenh 
local Dem = 0
self.state = 0;
local sTimer = 0

--local tCmd={"Ui.TBLenh:State()", "Ui.TBLenh", "", "Shift+G", "Shift+G", "dmm"};
--	 AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
--	 UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
function TBLenh:State()	
	if self.state == 0 then
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bắt đầu mở tinh binh Lệnh<color>");
		self.state = 1
	else	
		self.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Stop<color>");
		self.CloseWindows()
	end	
end

function TBLenh.OnTimer()	
	if self.state == 0 then	return  end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if Dem == 0 then
		if me.GetItemCountInBags(18,1,20614,1) > 0 then	
			local tbFind = me.FindItemInBags(18,1,20614,1); --Ruong tinh binh 1
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		elseif me.GetItemCountInBags(18,1,20614,2) > 0 then	
			local tbFind = me.FindItemInBags(18,1,20614,2); --Ruong tinh binh 1
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end	
		else
			Dem = 1
		end	
	end
	if Dem == 1 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận thưởng") then
						Dem = 2
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1)
					end					
				end
		else
			if me.GetItemCountInBags(18,1,20507,1) > 0 then
				local tbFind = me.FindItemInBags(18,1,20507,1);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				Dem = 2
			end		
		end
		
	end
	if Dem == 2 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận thưởng") then
						Dem = 3
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1)
					end					
				end
		else
			if me.GetItemCountInBags(18,1,20507,2) > 0 then
				local tbFind = me.FindItemInBags(18,1,20507,2);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				Dem = 3
			end		
		end
		
	end
	if Dem == 3 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận thưởng") then
						Dem = 4
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1)
					end					
				end
		else
			if me.GetItemCountInBags(18,1,20507,3) > 0 then
				local tbFind = me.FindItemInBags(18,1,20507,3);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				Dem = 4
			end		
		end
		
	end
	if Dem == 4 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận thưởng") then
						Dem = 5
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1)
					end					
				end
		else
			if me.GetItemCountInBags(18,1,20507,4) > 0 then
				local tbFind = me.FindItemInBags(18,1,20507,4);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				Dem = 5
			end		
		end
		
	end
	if Dem == 5 then 
		
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			UiManager:SwitchWindow(Ui.UI_SAYPANEL)
				for i = 1,table.getn(tbAnswers) do
					if string.find(tbAnswers[i],"Nhận thưởng") then
						Dem = 6
						return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1)
					end					
				end
		else
			if me.GetItemCountInBags(18,1,20507,5) > 0 then
				local tbFind = me.FindItemInBags(18,1,20507,5);
				for j, tbItem in pairs(tbFind) do
					me.UseItem(tbItem.pItem);
				end
			else
				Dem = 6
			end		
		end
		
	end
	if Dem == 6 then
		TBLenh:State();
	end
end

function TBLenh.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
	end
end
function TBLenh:Stop()	
	if self.state == 1 then
		self:State();
	end
	return;
end
function TBLenh:Start()	
	if self.state == 0 then
		self:State();
	end
	return;
end
