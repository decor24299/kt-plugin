Ui.UI_AUTOFUBEN				= "UI_AUTOFUBEN";
local uiAutoFuBen			= Ui.tbWnd[Ui.UI_AUTOFUBEN] or {};
uiAutoFuBen.UIGROUP			= Ui.UI_AUTOFUBEN;
Ui.tbWnd[Ui.UI_AUTOFUBEN]	= uiAutoFuBen;

local self = uiAutoFuBen;

self.DATA_KEY		= "FuBen";
self.tbSetting		= {};

self.BTN_CLOSE			= "BtnClose";
self.BTN_START			= "BtnStart";
self.BTN_MYREPUTE		= "BtnMyRepute";
self.BTN_SAVE			= "BtnSave";

local tbMyRepute =
{
	"Hạt giống bắp",
	"Hạt giống lúa",
	"Rẽ củ khoai tây",
	"Giống cây táo",
	"Giống cây hồng",
	"Giống cây sơn tra",
	"Hạt giống hoa đỗ quyên",
	"Hạt giống hoa thiên điểu",
	"Hạt giống hoa sơn trà"
}

function uiAutoFuBen:OnOpen()
	PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN);
	self:LoadSetting();
	self:SetAwardLabel();
end

function uiAutoFuBen:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY) or {};
	if not self.tbSetting.nMyRepute then
		self.tbSetting.nMyRepute = 9;
	end
end

function uiAutoFuBen:OnButtonClick(szWnd, nParam)
	if (szWnd == uiAutoFuBen.BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == uiAutoFuBen.BTN_START) then
		Map.tbKinZhongZhi:Switch();
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.BTN_MYREPUTE then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,9,0,
		tbMyRepute[1],1,
		tbMyRepute[2],2,
		tbMyRepute[3],3,
		tbMyRepute[4],4,
		tbMyRepute[5],5,
		tbMyRepute[6],6,
		tbMyRepute[7],7,
		tbMyRepute[8],8,
		tbMyRepute[9],9
		);
	elseif (szWnd == uiAutoFuBen.BTN_SAVE) then
		self:SaveData();
	end
end


function uiAutoFuBen:OnMenuItemSelected(szWnd, nItemId, nParam)
	if szWnd == self.BTN_MYREPUTE then
		self.tbSetting.nMyRepute = nItemId
	end
	self:SetAwardLabel();
end

function uiAutoFuBen:SetAwardLabel()
	Btn_SetTxt(self.UIGROUP,self.BTN_MYREPUTE,tbMyRepute[self.tbSetting.nMyRepute]);
end

function uiAutoFuBen:SaveData()
	self:Save(self.DATA_KEY, self.tbSetting);
end

function uiAutoFuBen:Save(szKey, tbData)
	self.m_szFilePath="\\user\\plant\\"..me.szName.."_giongcay.txt";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KFile.WriteFile(self.m_szFilePath, szData);
		me.Msg("<color=orange>Lưu dữ liệu thành công");
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function uiAutoFuBen:Load(key)
	self.m_szFilePath="\\user\\plant\\"..me.szName.."_giongcay.txt";
	self.m_tbData = {};
	print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then
			self.m_tbData = Lib:Str2Val(szData);
		else
			KFile.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	print(self.m_tbData);
	return tbData;
end

function uiAutoFuBen:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	
			return 0;
		end
	end
	return 1;
end

LoadUiGroup(Ui.UI_AUTOFUBEN, "TrongCayGiaToc.ini");

