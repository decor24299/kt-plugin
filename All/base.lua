--cyberdemon--
local tbObject	= Ui.tbLogic.tbObject;
local tbMouse	= Ui.tbLogic.tbMouse;
local tbPreViewMgr	= Ui.tbLogic.tbPreViewMgr;
local tbBase	= tbObject.tbContClass.base;

tbBase.LinkOwnItem=function(self,tbOwnItem, nX, nY)
	local pItem = me.GetItem(tbOwnItem.nRoom, tbOwnItem.nX, tbOwnItem.nY);
	if (pItem) then
		SetItemLink(pItem.nIndex)
	end
end

tbBase.PreViewItem=function(self,tbPreViewItem, nX, nY)
	local pItem = me.GetItem(tbPreViewItem.nRoom, tbPreViewItem.nX, tbPreViewItem.nY);
	if (pItem) then
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
			UiManager:CloseWindow(Ui.UI_PREVIEW)
		end
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
			UiManager:OpenWindow(Ui.UI_PREVIEW,pItem)
		end
	end
end

tbBase.PreViewTempItem=function(self,tbPreViewTempItem, nX, nY)
	local pItem = tbPreViewTempItem.pItem;
	if (pItem) then
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) == 1) then
			UiManager:CloseWindow(Ui.UI_PREVIEW);
		end
		if (UiManager:WindowVisible(Ui.UI_PREVIEW) ~= 1) then
			UiManager:OpenWindow(Ui.UI_PREVIEW,pItem);
		end
	end
end