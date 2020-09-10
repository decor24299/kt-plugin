Ui.UI_tbBossDongHa				= "UI_tbBossDongHa";
local tbBossDongHa			= Ui.tbWnd[Ui.UI_tbBossDongHa] or {};
tbBossDongHa.UIGROUP			= Ui.UI_tbBossDongHa;
Ui.tbWnd[Ui.UI_tbBossDongHa]	= tbBossDongHa

local self			= tbBossDongHa 

self.state1 = 0
local sTimers1 = 0


local uiSayPanel = Ui(Ui.UI_SAYPANEL)


function tbBossDongHa:State1()	
	if self.state1 == 0 then	
		sTimers1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 0.5,18,self.OnTimer1); --2
		me.Msg("<color=white>Thông báo:<color>Di Chuyển tọa độ boss đông hạ nào");
		self.state1 = 1
	else		
		self.state1 = 0
		Ui.tbLogic.tbTimer:Close(sTimers1);
		me.Msg("<color=white>Thông báo:<color> Đã đến nơi");
		sTimers1 = 0
		Ui.tbScrCallUi:CloseWinDow()
	end	
end

function tbBossDongHa.OnTimer1()	
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
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1900,2842"});
	elseif me.szName == pt[2] then
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1848,3029"});
	elseif me.szName == pt[3] then
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1920,3129"});
	elseif me.szName == pt[4] then
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1805,3304"});
	elseif me.szName == pt[5] then
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1611,3247"});
	elseif me.szName == pt[6] then
		tbBossDongHa.Stop();
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ",2148,1677,2992"});
	end

end

-------------------------------------------------------------------


function tbBossDongHa.Stop()
	
	self.state1 = 1 
	tbBossDongHa:State1()		
end
