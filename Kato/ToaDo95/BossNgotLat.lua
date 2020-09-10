Ui.UI_tbBossNgotLat				= "UI_tbBossNgotLat";
local tbBossNgotLat			= Ui.tbWnd[Ui.UI_tbBossNgotLat] or {};
tbBossNgotLat.UIGROUP			= Ui.UI_tbBossNgotLat;
Ui.tbWnd[Ui.UI_tbBossNgotLat]	= tbBossNgotLat

local self			= tbBossNgotLat 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossNgotLat:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di Chuyển tọa độ boss ngột lạt nào");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossNgotLat.OnTimer1()	
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
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1752,3552"});
	elseif me.szName == pt[2] then
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1932,3730"});
	elseif me.szName == pt[3] then
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1944,3401"});
	elseif me.szName == pt[4] then
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1860,3280"});
	elseif me.szName == pt[5] then
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1683,3328"});
	elseif me.szName == pt[6] then
		tbBossNgotLat.Stop()
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2150,1813,3511"});
	end

end

-------------------------------------------------------------------


function tbBossNgotLat.Stop()
	
	self.state1 = 1 
	tbBossNgotLat:State1()		
end
