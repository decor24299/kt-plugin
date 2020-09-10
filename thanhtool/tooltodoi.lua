--- Thanh TOOLtd - di chuyển nhanh ---
Ui.UI_TOOLtd		= "UI_TOOLtd";
local uiTOOLtd			= Ui.tbWnd[Ui.UI_TOOLtd] or {};	
uiTOOLtd.UIGROUP		= Ui.UI_TOOLtd;
Ui.tbWnd[Ui.UI_TOOLtd] = uiTOOLtd

local BTNRac					= "BtnRac"
local BTNBuff					= "BtnBuff"
local BTNCallKin				= "BtnCallKin"
local BTNToDoiLuu				= "BtnToDoiLuu"
local BTNToDoiRoi				= "BtnToDoiRoi"
local BTNToDoiVao				= "BtnToDoiVao"

Ui:RegisterNewUiWindow("UI_TOOLtd", "tooltodoi", {"a", 353, 485}, {"b", 355, 630}, {"c", 392, 32});
uiTOOLtd.OnButtonClick_Bak = uiTOOLtd.OnButtonClick_Bak or uiTOOLtd.OnButtonClick

uiTOOLtd.OnButtonClick=function(self,szWnd, nParam)
	if szWnd == BTNCallKin then
		Map.tbSuperCall:Callto2()
    elseif szWnd == BTNBuff then
		Map.tbAutoAsist:Asistswitch();
	elseif szWnd == BTNToDoiLuu then
		local check = 0
		local szData = KFile.ReadTxtFile("\\interface2\\Kato\\Acc.txt");
		local pt = Lib:SplitStr(szData, "\n");
		if Ui(Ui.UI_TEAM):IsTeamLeader() == 1 then
			local tbMember = me.GetTeamMemberInfo();
			local tdmoi = me.szName
			for i = 1, #tbMember do
				tdmoi=tdmoi..","..tbMember[i].szName
			end
			for i=1, #pt do
				if string.find(pt[i], me.szName) then
					pt[i] = tdmoi
					check = 1
				end
			end
			local tdluu= pt[1]
			for i= 2, #pt do
				tdluu=tdluu.."\n"..pt[i]
			end
			if check == 1  then
				KIo.WriteFile("\\interface2\\Kato\\Acc.txt", tdluu);
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Update Tổ Đội Thành Công<color>");
			else
				tdluu = tdluu.."\n"..tdmoi
				KIo.WriteFile("\\interface2\\Kato\\Acc.txt", tdluu);
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Red>Lưu Tổ Đội Thành Công<color>");
			end	
		end	
    elseif szWnd ==	BTNToDoiRoi then
		me.TeamLeave()
		SendChannelMsg("Friend","Anh em rời nhóm nào!!!")
	elseif szWnd ==	BTNToDoiVao then
		local szData = KFile.ReadTxtFile("\\interface2\\Kato\\Acc.txt");
		local pt = Lib:SplitStr(szData, "\n");
		local nhom = ""
		for i=1, #pt do
			if string.find(pt[i],me.szName) then
				nhom = pt[i]
			end
		end
		local ptrow = Lib:SplitStr(nhom, ",");
		for i=2, #ptrow do
			me.TeamInvite(0,ptrow[i]);
			--me.Msg("pt: "..ptrow[i])
		end
		elseif szWnd ==	BTNRac then
		 Map.tbbanrac:banrac();
	end
	self:OnButtonClick_Bak(szWnd, nParam);
end

--LoadUiGroup(Ui.UI_POPBAR, "popbar.ini");