
local tbTimer = Ui.tbLogic.tbTimer;
Ui.UI_PLAYERNAME_EX = "Ui.UI_PLAYERNAME_EX";
local uiPlayerNameEx = Ui.tbWnd[UI_PLAYERNAME_EX] or {};
uiPlayerNameEx.TIMER_FRAME	= Env.GAME_FPS;
uiPlayerNameEx.nTimerId = 0;

function uiPlayerNameEx:OnInit()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiPlayerNameEx.EnterGame_bak(Ui);
		uiPlayerNameEx.nTimerId = tbTimer:Register(uiPlayerNameEx.TIMER_FRAME, uiPlayerNameEx.OnTimer, uiPlayerNameEx);
	end
end

function uiPlayerNameEx:OnTimer()
	for _, pNpc in ipairs(KNpc.GetAroundNpcList(me, 30)) do
		if (pNpc.nKind == 1 and not pNpc.GetPlayer()) then
			local szFact = Ui(Ui.UI_TEAMPORTRAIT):GetFactionShortName(pNpc.nFaction)
			local szName = string.format("%s [%s-%d]", pNpc.szName, szFact, pNpc.nLevel);
			pNpc.SetDisplayName(szName);
		end
	end
end

uiPlayerNameEx:OnInit();