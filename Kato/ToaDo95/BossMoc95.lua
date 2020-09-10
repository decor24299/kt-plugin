Ui.UI_tbBossMoc95				= "UI_tbBossMoc95";
local tbBossMoc95			= Ui.tbWnd[Ui.UI_tbBossMoc95] or {};
tbBossMoc95.UIGROUP			= Ui.UI_tbBossMoc95;
Ui.tbWnd[Ui.UI_tbBossMoc95]	= tbBossMoc95

local self			= tbBossMoc95 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossMoc95:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di chuyển tọa độ boss mộc 95 nào!!");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossMoc95.OnTimer1()	
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
		tbBossMoc95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",114,1893,3402"});
	elseif me.szName == pt[3] then
		tbBossMoc95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",117,1496,3141"});
	elseif me.szName == pt[4] then
		tbBossMoc95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",119,1711,3781"});
	elseif me.szName == pt[5] then
		tbBossMoc95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",115,1747,3228"});
	elseif me.szName == pt[6] then
		tbBossMoc95.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",116,1582,3811"});
	end

end

-------------------------------------------------------------------


function tbBossMoc95.Stop()
	
	self.state1 = 1 
	tbBossMoc95:State1()		
end
