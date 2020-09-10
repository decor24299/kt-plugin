
local self = tbClose;

local tbClose	= Map.tbClose or {};
Map.tbClose		= tbClose;

local nClose = 0;

function tbClose:OnStart()
	nClose = Ui.tbLogic.tbTimer:Register(15 * Env.GAME_FPS,self.Start,self);
end


function tbClose:Start()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional2")
		uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
		UiManager:CloseWindow(Ui.UI_GUTAWARD)
		return
	end
	--if UiManager:WindowVisible(Ui.UI_JINGHUOFULIEX) == 1 then
		--UiManager:CloseWindow(Ui.UI_JINGHUOFULIEX);
	--end

end

Map.tbClose:OnStart();