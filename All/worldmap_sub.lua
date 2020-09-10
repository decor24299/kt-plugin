local uiWorldMap_Sub	= Ui(Ui.UI_WORLDMAP_SUB);
local tbMap				= Ui.tbLogic.tbMap;
uiWorldMap_Sub.OnOpen_bak = uiWorldMap_Sub.OnOpen_bak or uiWorldMap_Sub.OnOpen;
uiWorldMap_Sub.szYellowSpr = "\\image\\ui\\001a\\minimap\\yellowpoint.spr"
function uiWorldMap_Sub:OnOpen(nMapId)
	self:OnOpen_bak(nMapId);
	self.tbNpcInfoEx = {};
	self:ReadWantedInfo(nMapId);
	self:ReadTreaMapInfo(nMapId);
	self:DrawMyMapEx();
end

function uiWorldMap_Sub:DrawMyMapEx()
	for i = 1, #self.tbNpcInfoEx do
		local nCId = #self.tbCanvasId + 1;
		self.tbCanvasId[nCId] = {};
		local szSprPath = self.tbNpcInfoEx[i][6];
		local nImageWidth, nImageHeight = Canvas_GetImageSize(self.UIGROUP, self.IMAGE_SUBMAP, szSprPath);
		
		if self.tbNpcInfoEx[i][1] > 0 and self.tbNpcInfoEx[i][2] > 0 then
			local nImagePosX = self.tbNpcInfoEx[i][1] - nImageWidth / 2;
			local nImagePosY = self.tbNpcInfoEx[i][2] - nImageHeight / 2;
			local nImageId = Canvas_CreateImage(self.UIGROUP, self.IMAGE_SUBMAP, nImagePosX, nImagePosY, szSprPath, 1);	
			self.tbCanvasId[nCId][1] = nImageId;
		end	
		local nFontSize = self.tbNpcInfoEx[i][4];
		local szText = self.tbNpcInfoEx[i][3];
		if self.tbNpcInfoEx[i][7] > 0 and self.tbNpcInfoEx[i][8] > 0 then
			local nTextPosX = self.tbNpcInfoEx[i][7] - (nFontSize * #szText) / 4;	
			local nTextPosY = self.tbNpcInfoEx[i][8] - nFontSize / 2;				
			local nTextId = Canvas_CreateText(self.UIGROUP, self.IMAGE_SUBMAP, nFontSize, szText, self.tbNpcInfoEx[i][5], nTextPosX, nTextPosY);
			self.tbCanvasId[nCId][2] = nTextId;
		end
	end	
end

function uiWorldMap_Sub:ReadTreaMapInfo(nMapId)
	local pTabFile = Lib:LoadTabFile("\\setting\\task\\treasuremap\\treasuremap_pos.txt");
	for ni, tbMapinfo in ipairs(pTabFile) do
		local nWantMapId 		= tonumber(tbMapinfo.MapId) or 0;
		if nMapId == nWantMapId then
			local nSprPosX		= tonumber(tbMapinfo.MapX) or 0;
			local nSprPosY		= tonumber(tbMapinfo.MapY) or 0;
			local szColor		= "yellow";
			local szTaskName		= tbMapinfo.Desc;
			nSprPosX, nSprPosY 	 = tbMap:WorldPosToImgPos(self.nMapControlId, nSprPosX, nSprPosY);
			table.insert(self.tbNpcInfoEx, { nSprPosX, nSprPosY, szTaskName, 12, szColor, self.szYellowSpr, nSprPosX, nSprPosY-16})
		end
	end
	return 1;
end

function uiWorldMap_Sub:ReadWantedInfo(nMapId)
	local pTabFile = Lib:LoadTabFile("\\interface2\\All\\worldmap.txt");
	for ni, tbMapinfo in ipairs(pTabFile) do
		local nWantMapId 		= tonumber(tbMapinfo.MapId) or 0;
		if nMapId == nWantMapId then
			local nSprPosX		= tonumber(tbMapinfo.PosX) or 0;
			local nSprPosY		= tonumber(tbMapinfo.PosY) or 0;
			local szColor		= tbMapinfo.color;
			local szTaskName		= tbMapinfo.TaskName;
			nSprPosX, nSprPosY 	 = tbMap:WorldPosToImgPos(self.nMapControlId, nSprPosX, nSprPosY);
			table.insert(self.tbNpcInfoEx, { nSprPosX, nSprPosY, szTaskName, 12, szColor, self.szYellowSpr, nSprPosX, nSprPosY-16})
		end
	end
	return 1;
end
