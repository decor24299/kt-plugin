Ui.UI_tbBossHoa95				= "UI_tbBossHoa95";
local tbBossHoa95			= Ui.tbWnd[Ui.UI_tbBossHoa95] or {};
tbBossHoa95.UIGROUP			= Ui.UI_tbBossHoa95;
Ui.tbWnd[Ui.UI_tbBossHoa95]	= tbBossHoa95

local self			= tbBossHoa95 

self.state1 = 0
local sTimers1 = 0
		

local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossHoa95:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di chuyển tọa độ boss hỏa 95 nào!!");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossHoa95.OnTimer1()	
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
		tbBossHoa95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1707,3945"});
	elseif me.szName == pt[3] then
		tbBossHoa95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1596,3329"});
	elseif me.szName == pt[4] then
		tbBossHoa95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1428,3093"});
	elseif me.szName == pt[5] then
		tbBossHoa95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1608,3535"});
	elseif me.szName == pt[6] then
		tbBossHoa95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1601,3366"});
	end

end

-------------------------------------------------------------------


function tbBossHoa95.Stop()
	
	self.state1 = 1 
	tbBossHoa95:State1()		
end
