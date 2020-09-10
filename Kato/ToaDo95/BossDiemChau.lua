Ui.UI_tbBossDiemChau				= "UI_tbBossDiemChau";
local tbBossDiemChau			= Ui.tbWnd[Ui.UI_tbBossDiemChau] or {};
tbBossDiemChau.UIGROUP			= Ui.UI_tbBossDiemChau;
Ui.tbWnd[Ui.UI_tbBossDiemChau]	= tbBossDiemChau

local self			= tbBossDiemChau 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossDiemChau:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di Chuyển tọa độ boss diêm châu nào");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossDiemChau.OnTimer1()	
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
	
	if me.szName == pt[1] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1879,3358"});
	elseif me.szName == pt[2] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1774,3267"});
	elseif me.szName == pt[3] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1752,3484"});
	elseif me.szName == pt[4] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1750,3633"});
	elseif me.szName == pt[5] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1910,3736"});
	elseif me.szName == pt[6] then
		tbBossDiemChau.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2149,1932,3568"});
	end

end

-------------------------------------------------------------------


function tbBossDiemChau.Stop()
	
	self.state1 = 1 
	tbBossDiemChau:State1()		
end
