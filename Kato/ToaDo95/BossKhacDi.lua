Ui.UI_tbBossKhacDi				= "UI_tbBossKhacDi";
local tbBossKhacDi			= Ui.tbWnd[Ui.UI_tbBossKhacDi] or {};
tbBossKhacDi.UIGROUP			= Ui.UI_tbBossKhacDi;
Ui.tbWnd[Ui.UI_tbBossKhacDi]	= tbBossKhacDi

local self			= tbBossKhacDi 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossKhacDi:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di Chuyển tọa độ boss Khắc di nào");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossKhacDi.OnTimer1()	
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
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1863,3435"});
	elseif me.szName == pt[2] then
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1967,3286"});
	elseif me.szName == pt[3] then
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,2029,3396"});
	elseif me.szName == pt[4] then
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1862,3659"});
	elseif me.szName == pt[5] then
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1770,3573"});
	elseif me.szName == pt[6] then
		tbBossKhacDi.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2147,1729,3284"});
	end
end

-------------------------------------------------------------------


function tbBossKhacDi.Stop()
	
	self.state1 = 1 
	tbBossKhacDi:State1()		
end
