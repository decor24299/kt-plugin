Ui.UI_tbBossTho95				= "UI_tbBossTho95";
local tbBossTho95			= Ui.tbWnd[Ui.UI_tbBossTho95] or {};
tbBossTho95.UIGROUP			= Ui.UI_tbBossTho95;
Ui.tbWnd[Ui.UI_tbBossTho95]	= tbBossTho95

local self			= tbBossTho95 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossTho95:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di chuyển tọa độ boss thổ 95 nào!!");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossTho95.OnTimer1()	
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
		tbBossTho95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1905,3280"});
	elseif me.szName == pt[3] then
		tbBossTho95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",120,1617,3846"});
	elseif me.szName == pt[4] then
		tbBossTho95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1722,2877"});
	elseif me.szName == pt[5] then
		tbBossTho95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",118,1828,3453"});
	elseif me.szName == pt[6] then
		tbBossTho95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",121,1588,3085"});
	end

end

-------------------------------------------------------------------


function tbBossTho95.Stop()
	
	self.state1 = 1 
	tbBossTho95:State1()		
end
