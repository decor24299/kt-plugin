Ui.tbPluginWndConfig = Ui.tbPluginWndConfig or {};
local tbPlugWnd = Ui.tbPluginWndConfig;

tbPlugWnd.tbWndPosXY = 
{
        ["UI_BUTTOND"]		= {"UI_MESSAGEPUSHVIEW",125,40},
        ["UI_TOOL"]		    = {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEB"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEC"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMED"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEE"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEG"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEH"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEI"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEDIY"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEF"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEL"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEIK"]	= {"UI_MESSAGEPUSHVIEW",88,65},
        ["UI_SHOWTIMEHD"]	= {"UI_MESSAGEPUSHVIEW",88,65},		
        ["UI_SHOWTIMEMULU"]	= {"UI_MESSAGEPUSHVIEW",88,65},
}
                

function tbPlugWnd:ResetPosWithWnd(szThisWnd)
	if szThisWnd and self.tbWndPosXY[szThisWnd] then
		local nX, nY = Wnd_GetPos(self.tbWndPosXY[szThisWnd][1], "Main");
		Ui:AddExWndConfig(szThisWnd, {"b",nX + self.tbWndPosXY[szThisWnd][2], nY + self.tbWndPosXY[szThisWnd][3]})
		Ui:LoadExWndConfig(szThisWnd)

	else
		local nX, nY = Wnd_GetPos("UI_PLAYERSTATE", "Main");
		if nX < 143  then
			Ui:AddExWndConfig("UI_PLAYERSTATE", {"b",0,0})
			Ui:LoadExWndConfig("UI_PLAYERSTATE") 			
		end

		for szWndName, tbWnd in pairs(self.tbWndPosXY) do
                        local nX, nY = Wnd_GetPos(tbWnd[1], "Main");
			Ui:AddExWndConfig(szWndName, {"b",nX + tbWnd[2], nY + tbWnd[3]})
			Ui:LoadExWndConfig(szWndName)
			--Wnd_SetPos(szWndName, "Main", nX + tbWnd[2], nY + tbWnd[3]);
		end
	end
end


