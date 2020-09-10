--local UiLockAccount = Ui:GetClass("lockaccount");
local UiLockAccount = Ui(Ui.UI_LOCKACCOUNT);
UiLockAccount.BTN_ACCOUNTLOCKAUTOPASS = "BtnAccountLockAutoPass"
UiLockAccount.BTN_ACCOUNTLOCKSETAUTOPASSWORD = "BtnAccountLockSetAutoPassword"
-- UiLockAccount.BTN_CARDAUTOPASS = "BtnCardAutoPass"
-- UiLockAccount.BTN_CARDSET = "BtnCardSet"

local tbHEX = {{"8"},{"9"},{"A"},{"B"},{"C"},{"D"},{"E"},{"F"},{"0"},{"1"},}
local nLockSn =	"";
UiLockAccount.Unlock_Lock = 1 
-------------------------------------------------------------------------------------


local EnterGame_bak	= EnterGame_bak or Ui.EnterGame;
function Ui:EnterGame()
	EnterGame_bak(Ui);
	UiLockAccount:OnEnterGame();
end

function UiLockAccount:OnEnterGame()
	if self.Unlock_Lock == 1 then
		self:AutoUnlock();
	end
end

UiLockAccount.OnButtonClick_Bak = UiLockAccount.OnButtonClick;

function UiLockAccount:OnButtonClick(szWndName, nParam)
	-----------------------------------
	if szWndName == self.BTN_ACCOUNTLOCKAUTOPASS then
		self:AutoAccountPass();
	end

	if szWndName == self.BTN_ACCOUNTLOCKSETAUTOPASSWORD then
		self:SetOrMide()
	end

	if szWndName == self.BTN_CARDAUTOPASS then
		self:AutoCardPass()
	end

	if szWndName == self.BTN_CARDSET then
		UiManager:SwitchWindow(Ui.UI_CARDSET);
	end
	--------------------------------------------------
	self:OnButtonClick_Bak(szWndName, nParam);
end


function UiLockAccount:UpdateCardPositionText()
	local tbMatrixKey = self:ParseMatrix(me.GetMatrixPosition());
	if tbMatrixKey then

		local szTxt1 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[1].."<color>, cột thứ <color=yellow>"..tbMatrixKey[2].."<color> là: ";
		local szTxt2 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[3].."<color>, cột thứ <color=yellow>"..tbMatrixKey[4].."<color> là: ";
		local szTxt3 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[5].."<color>, cột thứ <color=yellow>"..tbMatrixKey[6].."<color> là: ";

		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM1, szTxt1);
		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM2, szTxt2);
		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM3, szTxt3);

		nLockSn = tbMatrixKey[1]..tbMatrixKey[2]..tbMatrixKey[3]..tbMatrixKey[4]..tbMatrixKey[5]..tbMatrixKey[6]
		-----------------------------------------------------
	end
end

function UiLockAccount:AutoUnlock()
	if self.bSafeCard == 1 then
		UiManager:OpenWindow(self.UIGROUP);
		self:AutoCardPass(); 
	elseif self.bAccountLock == 1 then
		UiManager:OpenWindow(self.UIGROUP);
		self:AutoAccountPass()
	end
end

function UiLockAccount:AutoCardPass()
	local sPass = ""
	if self.bSafeCard == 1	then
		--self:ShowMiniKeyBoard();
		local nPwdSn = nLockSn;
		local s1 = string.sub(nPwdSn,1,1);
		local n1 = tonumber(string.sub(nPwdSn,2,2));
		if n1 == 0 then
		    n1 = 10
		end

		local s2 = string.sub(nPwdSn,3,3);
		local n2 = tonumber(string.sub(nPwdSn,4,4));
		if n2 == 0 then
		    n2 = 10
		end
		local s3 = string.sub(nPwdSn,5,5);
		local n3 = tonumber(string.sub(nPwdSn,6,6));
		if n3 == 0 then
		    n3 = 10
		end
		-- sPass = self:ReadProtectCard(n1,n2,n3,s1,s2,s3) or ""
	end

	if string.len(sPass) == 0 then
		UiManager:OpenWindow(Ui.UI_LOCKACCOUNT);
		return
	end

	local nkey1 = string.sub(sPass,1,2)
	local nkey2 = string.sub(sPass,3,4)
	local nkey3 = string.sub(sPass,5,6)

	Edt_SetTxt(self.UIGROUP,self.EDT_CARD_NUM1,nkey1)
	Edt_SetTxt(self.UIGROUP,self.EDT_CARD_NUM2,nkey2)
	Edt_SetTxt(self.UIGROUP,self.EDT_CARD_NUM3,nkey3)

	self:SafeCardLogin();
	UiManager:CloseWindow(self.UIGROUP);
end

function UiLockAccount:AutoAccountPass()
	local sPass=""
	if self.bAccountLock == 1 then
		self.nr1 = MathRandom(63);
		self.nr2 = MathRandom(63);
		self.nr3 = MathRandom(65535) / 65536;
		local szTxt=tostring(self:LoadKey())
		if string.len(szTxt) == 0 then
			UiManager:OpenWindow(Ui.UI_LOCKACCOUNT);
			me.Msg("Chưa lưu mật khẩu")
			return
		end

		print(szTxt)
		local s=""
		local str=szTxt
		local i=1
		while i<=6 do
			str=string.sub(szTxt,i)
			s=string.sub(str,1,1)
			--print(str)
			for j=1,#tbHEX do
				if tbHEX[j][1]==s then
					sPass=sPass..tostring(j-1)
					break--j=#tbHEX+1
					--me.Msg(sPass)
				end
			end
			i=i+1
		end
	end

	local nkey=tonumber(sPass)

	for j=1,6 do
		local d=10^(6-j)
		local nk=math.floor(nkey/d);
		print(d,nk)
		UiNotify:OnNotify(UiNotify.emUIEVENT_MINIKEY_SEND, nk);
		nkey=math.mod(nkey,d);
	end

	self:SafeAccountLockLogin()
	UiManager:CloseWindow(self.UIGROUP);
end
function UiLockAccount:Save(szKey, tbData)
	self.m_szFilePath="\\user\\UiLockAccount\\"..me.szName..tostring(me.nFaction).."_key.dat";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function UiLockAccount:Load(Files,key)
	local m_szFilePath=Files
	local szData = KIo.ReadTxtFile(m_szFilePath);
	local m_tbData = {}
	if (szData) then
		if self:CheckErrorData(szData) == 1 then
			m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(m_szFilePath, "nil");
		end
		--KIo.CloseTabFile(m_szFilePath);
	end
	local tbData = m_tbData[key];
	print(self.m_tbData);
	return tbData
end

function UiLockAccount:LoadKey()
	local file="\\user\\UiLockAccount\\"..me.szName..tostring(me.nFaction).."_key.dat"	
	local tbKey = self:Load(file,"PassWord");
	if not tbKey then
		tbKey = {};
		return ""
	end
	if tbKey.szPW then
		return tbKey.szPW;
	end
end

-- function UiLockAccount:ReadProtectCard(n1,n2,n3,s1,s2,s3)

	-- local szClassList = "\\save\\UiLockAccount\\"..me.szName..tostring(me.nFaction).."_mbk.dat"
	-- local pTabFile = KIo.OpenTabFile(szClassList);
	-- if (not pTabFile) then
		-- me.Msg("Không thấy");
		-- return;
	-- else
		-- local tbCard = pTabFile.AsTable();
		-- local h1 = self:ToNum(s1);
		-- local p1 = tostring(tbCard[h1][n1])
		-- local h2 = self:ToNum(s2);
		-- local p2 = tostring(tbCard[h2][n2])
		-- local h3 = self:ToNum(s3);
		-- local p3 = tostring(tbCard[h3][n3])
		-- KIo.CloseTabFile(pTabFile);
		-- local nPsw = p1..p2..p3
		-- return nPsw
	-- end
-- end

function UiLockAccount:ToString(nPassWord)
	local sPass="";
	local sPassWord=tostring(nPassWord)
	for i=1,6 do
		local s=math.floor(nPassWord/(10^(6-i)))
		sPass=sPass..tbHEX[s+1][1]
		nPassWord=nPassWord-(s*(10^(6-i)))
	end
	return sPass
end

function UiLockAccount:ToNum(nSn)
	if nSn == "A" then
		return 1
	elseif nSn == "B" then
		return 2
	elseif nSn == "C" then
		return 3
	elseif nSn == "D" then
		return 4
	elseif nSn == "E" then
		return 5
	elseif nSn == "F" then
		return 6
	elseif nSn == "G" then
		return 7
	elseif nSn == "H" then
		return 8
	end
end

function UiLockAccount:SetOrMide()
	local tbFundParam = {};
	tbFundParam.tbTable = self;
	tbFundParam.fnAccept = self.AcceptGetInPutPass;
	tbFundParam.nMaxLen=6
	tbFundParam.szTitle = "Nhập mật mã";
	UiManager:OpenWindow(Ui.UI_TEXTINPUT,tbFundParam)
end

function UiLockAccount:AcceptGetInPutPass(nPass)
	if tonumber(nPass) < 100000 then
		me.Msg("Chưa có mã");
		UiManager:CloseWindow(Ui.UI_TEXTINPUT)
		self:SetOrMide()
		return
	end

	UiManager:CloseWindow(Ui.UI_TEXTINPUT)
	local szTxt=self:ToString(nPass)
	local tbData={
		szPW=szTxt,
		}

	self:Save("PassWord",tbData)

end

function UiLockAccount:CheckErrorData(szDate)
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

function UiLockAccount:Reload()
    local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\lockaccount\\lockaccount.lua");
	me.Msg("LockAccount " .. GetLocalDate("%Y%m%d %H:%M:%S"));
end
