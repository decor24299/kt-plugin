Ui.UI_tbBossKim95				= "UI_tbBossKim95";
local tbBossKim95			= Ui.tbWnd[Ui.UI_tbBossKim95] or {};
tbBossKim95.UIGROUP			= Ui.UI_tbBossKim95;
Ui.tbWnd[Ui.UI_tbBossKim95]	= tbBossKim95

local self			= tbBossKim95 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossKim95:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di chuyển tọa độ boss kim 95 nào!!");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossKim95.OnTimer1()	
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
		tbBossKim95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1640,3358"});
	elseif me.szName == pt[3] then
		tbBossKim95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1676,2914"});
	elseif me.szName == pt[4] then
		tbBossKim95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1624,3180"});
	elseif me.szName == pt[5] then
		tbBossKim95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1455,3256"});
	elseif me.szName == pt[6] then
		tbBossKim95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1950,3629"});
	end

end

-------------------------------------------------------------------


function tbBossKim95.Stop()
	
	self.state1 = 1 
	tbBossKim95:State1()		
end
