
local self =ReLoadNgua;
local ReLoadNgua = Map.ReLoadNgua or {};
Map.ReLoadNgua = ReLoadNgua;
local nState = 0;
local nTimerId = 0;
local nTimerId1 = 0;
local nStep =0;

function ReLoadNgua:OnSwitch()
	if nState == 0 then
		nState = 1;
		nTimerId = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS,self.OnTimez,self);
	else
		nState = 0;
		nStep =0;
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end

function ReLoadNgua.OnTimez()
	if nStep > 2 then
		self:OnSwitch();
		
	else
		ReLoadNgua:Refresh();
		nStep=nStep+1;
	end
end
function ReLoadNgua:Refresh()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	local szFileReload = "\\interface2\\All\\LenNgua.lua";
	fnDoScript(szFileReload);	
end
function ReLoadNgua:Init()
	ReLoadNgua.EnterGame_bak	= ReLoadNgua.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		ReLoadNgua:OnEnterGame();
		ReLoadNgua.EnterGame_bak(Ui);
	end
end

function ReLoadNgua:OnEnterGame()
	if nState == 0 then
		Map.ReLoadNgua:OnSwitch();
	end
end
	Map.ReLoadNgua:Init();

