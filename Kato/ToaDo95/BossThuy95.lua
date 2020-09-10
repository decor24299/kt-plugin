Ui.UI_tbBossThuy95				= "UI_tbBossThuy95";
local tbBossThuy95			= Ui.tbWnd[Ui.UI_tbBossThuy95] or {};
tbBossThuy95.UIGROUP			= Ui.UI_tbBossThuy95;
Ui.tbWnd[Ui.UI_tbBossThuy95]	= tbBossThuy95

local self			= tbBossThuy95 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossThuy95:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di chuyển tọa độ boss thủy 95 nào!!");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossThuy95.OnTimer1()	
	if (self.state1 == 0) then
		return
	end
		
	local szData = KFile.ReadTxtFile("\\interface2\\Kato\\Acc.txt");
	local ptt = Lib:SplitStr(szData, "\n");
			
		local nhom = ""
		for i=1, #ptt do
			if string.find(ptt[i],me.szName) then
				nhom = ptt[i]
			end
		end
	local pt = Lib:SplitStr(nhom, ",");
		
	if me.szName == pt[2] then
		tbBossThuy95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1555,3488"});
	elseif me.szName == pt[3] then
		tbBossThuy95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1485,3426"});
	elseif me.szName == pt[4] then
		tbBossThuy95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1910,3850"});
	elseif me.szName == pt[5] then
		tbBossThuy95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1841,3420"});
	elseif me.szName == pt[6] then
		tbBossThuy95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1875,3835"});
	end

end

-------------------------------------------------------------------


function tbBossThuy95.Stop()
	
	self.state1 = 1 
	tbBossThuy95:State1()		
end
