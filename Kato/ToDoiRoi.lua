Ui.UI_ToDoiRoi				= "UI_ToDoiRoi";
local ToDoiRoi			= Ui.tbWnd[Ui.UI_ToDoiRoi] or {};
ToDoiRoi.UIGROUP			= Ui.UI_ToDoiRoi;
Ui.tbWnd[Ui.UI_ToDoiRoi]	= ToDoiRoi

local self			= ToDoiRoi 

self.state1 = 0
local sTimers1 = 0
		

local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function ToDoiRoi:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		--me.Msg("<color=white>Thông báo:<color>Bắt đầu rời tổ đội");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
	--	me.Msg("<color=white>Thông báo:<color> Stop");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function ToDoiRoi.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
	local tbMember = me.GetTeamMemberInfo();
	local szData = KFile.ReadTxtFile("\\interface2\\Kato\\Acc.txt");
	local ptt = Lib:SplitStr(szData, "\n");
			
		local nhom = ""
		for i=1, #ptt do
			if string.find(ptt[i],me.szName) then
				nhom = ptt[i]
			end
		end
	local pt = Lib:SplitStr(nhom, ",");
	
	if me.szName == pt[1] then
		ToDoiRoi.Stop();
	elseif not me.nTeamId then
		ToDoiRoi.Stop();
	elseif #tbMember == 0 then 
		return Env.GAME_FPS * 0.5, me.TeamLeave(), ToDoiRoi.Stop();
	elseif tbMember[1].szName == pt[1] then
		ToDoiRoi.Stop();
	else
		return Env.GAME_FPS * 0.5, me.TeamLeave(), ToDoiRoi.Stop();
	--if Ui(Ui.UI_TEAM):IsTeamLeader() == 1 and me.szName ~= pt[1] then
	--	return Env.GAME_FPS * 0.5, me.TeamLeave(), ToDoiRoi.Stop();
	--end	
	end
	
end

-------------------------------------------------------------------

function ToDoiRoi.Stop()
	self.state1 = 1
	ToDoiRoi:State1()		
end
