
Ui.UI_BUTTONE88		= "UI_BUTTONE88";
local BUTTONE88		= Ui.tbWnd[Ui.UI_BUTTONE88] or {};	
BUTTONE88.UIGROUP		= Ui.UI_BUTTONE88;
Ui.tbWnd[Ui.UI_BUTTONE88]	= BUTTONE88
local self = BUTTONE88
self.nC = 1

Ui:RegisterNewUiWindow("UI_BUTTONE88", "giaodien",  {"a", 608, 2}, {"b", 960, 205}, {"c", 1080, 1}, {"d", 1080, 1});


BUTTONE88.BTN_MENU1	= "BtnMenu1"


BUTTONE88.OnButtonClick_Bak = BUTTONE88.OnButtonClick;


BUTTONE88.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_MENU1) then
		if self.nC == 1 then
			self:SetJM1()
		elseif self.nC == 2 then
			self:SetJM2()
		elseif self.nC == 3 then
			self:SetJM3()
		elseif self.nC == 4 then
			self:SetJM4()
		end
	end
end

function BUTTONE88:OpenJM()
	UiManager:OpenWindow(Ui.UI_BUTTOND)	
end

function BUTTONE88:SetJM1()
	Ui.tbPluginWndConfig:ResetPosWithWnd();
end

function BUTTONE88:SetJM2()
	Ui:AddExWndConfig("UI_BUTTOND", {"b",950, 245})
	Ui:LoadExWndConfig("UI_BUTTOND") 			
	Ui:AddExWndConfig("UI_TOOL", {"b",935, 272})
	Ui:LoadExWndConfig("UI_TOOL") 				
	Ui:AddExWndConfig("UI_SHOWTIMEMULU", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEMULU") 			

	Ui:AddExWndConfig("UI_SHOWTIMEB", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEB")
	Ui:AddExWndConfig("UI_SHOWTIMEC", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEC")
	Ui:AddExWndConfig("UI_SHOWTIMED", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMED")
	Ui:AddExWndConfig("UI_SHOWTIMEE", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEE")
	Ui:AddExWndConfig("UI_SHOWTIMEG", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEG")
	Ui:AddExWndConfig("UI_SHOWTIMEF", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEF")
	Ui:AddExWndConfig("UI_SHOWTIMEH", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEH")
	Ui:AddExWndConfig("UI_SHOWTIMEI", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEI")
	Ui:AddExWndConfig("UI_SHOWTIMEIK", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEIK")
	Ui:AddExWndConfig("UI_SHOWTIMEL", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEL")
	Ui:AddExWndConfig("UI_SHOWTIMEHD", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEHD")		
	Ui:AddExWndConfig("UI_SHOWTIMEDIY", {"b",935, 272})
	Ui:LoadExWndConfig("UI_SHOWTIMEDIY")

	self.nC = 3
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Chuyển sang chế độ 2<color>");
	self:OpenJM()
end

function BUTTONE88:SetJM3()
	local nX = 391
	local nY = 8

	Ui:AddExWndConfig("UI_BUTTOND", {"b",950+nX, 245+nY})
	Ui:LoadExWndConfig("UI_BUTTOND") 			
	Ui:AddExWndConfig("UI_TOOL", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_TOOL") 				
	Ui:AddExWndConfig("UI_SHOWTIMEMULU", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEMULU") 			

	Ui:AddExWndConfig("UI_SHOWTIMEB", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEB")
	Ui:AddExWndConfig("UI_SHOWTIMEC", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEC")
	Ui:AddExWndConfig("UI_SHOWTIMED", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMED")
	Ui:AddExWndConfig("UI_SHOWTIMEE", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEE")
	Ui:AddExWndConfig("UI_SHOWTIMEG", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEG")
	Ui:AddExWndConfig("UI_SHOWTIMEF", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEF")	
	Ui:AddExWndConfig("UI_SHOWTIMEH", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEH")
	Ui:AddExWndConfig("UI_SHOWTIMEI", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEI")
	Ui:AddExWndConfig("UI_SHOWTIMEIK", {"b",935+nX, 272+nY})	
	Ui:LoadExWndConfig("UI_SHOWTIMEIK")
	Ui:AddExWndConfig("UI_SHOWTIMEL", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEL")
	Ui:AddExWndConfig("UI_SHOWTIMEHD", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEHD")	
	Ui:AddExWndConfig("UI_SHOWTIMEDIY", {"b",935+nX, 272+nY})
	Ui:LoadExWndConfig("UI_SHOWTIMEDIY")

	self.nC = 1
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Chuyển sang chế độ 3<color>");
	self:OpenJM()
end

function BUTTONE88:SetJM4()
	self.nC = 1
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Chuyển sang chế độ 4<color>");
	self:OpenJM()

end

function BUTTONE88:Reloadset()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\"..Ui:GetPlugFolder().."\\chuyengiaodien\\giaodien.lua");
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Chuyển đổi giao diện hoàn thành<color>");
	me.Msg("<color=yellow>Chuyển đổi giao diện hoàn thành<color>");
	UiManager:OpenWindow(Ui.UI_BUTTONE88)
end

--LoadUiGroup(Ui.UI_BUTTONE88, "giaodien.ini");