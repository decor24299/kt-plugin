local RELOAD 		= UiManager;
local ReloadCH		= {};
local tbAutoPath		= Ui.tbLogic.tbAutoPath or {};
local tbScrCallUi	= Ui.tbScrCallUi or {}; 
Ui.tbScrCallUi	= tbScrCallUi;
local self = tbScrCallUi;
local UiScrCallUi = Ui.tbScrCallUi;

local Reload = 0
local nTimer_TienIch = 0

local filereload = {
"\\interface2\\All\\AutoAimUi.lua",
"\\interface2\\Auto_Mail\\Tools2_mail.lua",
"\\interface2\\All\\LenNgua.lua",
"\\interface2\\Giangthanhngt\\CheckSkill.lua",
"\\interface2\\MPGua_Train\\Train.lua",
--"\\interface2\\Kato\\ToDoiLuu.lua",
--"\\interface2\\Kato\\KhongTuoc.lua",
--"\\interface2\\All\\tools.lua",
--"\\interface2\\TeamControl\\AutoQuanDoanh.lua",
--"\\interface2\\TeamControl\\AutoChiLing.lua",

}

local state = 1;
local timer = 0;
local timer1 = 0;
function RELOAD.AutoAlert()
			
end
function RELOAD.AutoAlertGB()
	
end
function RELOAD.dotimer()
	if state == 0 then
		timer = Ui.tbLogic.tbTimer:Register(10,RELOAD.AutoAlert);
		timer1 = Ui.tbLogic.tbTimer:Register(20,RELOAD.AutoAlertGB);
		state = 1;
	end
	me.Msg("<color=pink>Done");
end

function RELOAD.OnOpen()
	--SendChannelMsg("NearBy", "thích viết gì thì viết vào đây");
	--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>thích viết gì thì viết vào đây");
	--me.Msg("<color=white>Thông báo:<color=green> ReLoad Begin")	
	--me.Msg("<color=orange>{-----------------------------------------------------------------}<color>")
	for i = 1,table.getn(filereload) do
		local str = KIo.ReadTxtFile(filereload[i]);
		if str ~= "" then
			assert(loadstring(str,filereload[i]))()
			me.Msg(tostring("<color=red>ReLoad: <color=white>"..filereload[i]))
		else
			me.Msg(tostring("Error:"..filereload[i]))
		end
	end
	--UiManager:CloseWindow(Ui.UI_JINGHUOFULIEX);
	--Ui(Ui.UI_ITEMBOX):OnMenuItemSelected("BtnClassification", 2, "Sắp xếp phần [5]")
	--UiManager:OpenWindow(Ui.UI_TOOLS);
	--UiManager:OpenWindow(Ui.UI_AutoQuanDoanh);
	--me.Msg("<color=orange>{-----------------------------------------------------------------}<color>")
	--me.Msg("<color=white>Thông báo:<color=green> ReLoad Done <color=red>ngày<color=yellow>: ".. GetLocalDate("%d-%m-%Y <color=red>lúc<color>: %H:%M:%S"))	
end

function tbScrCallUi.CloseWinDow()
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then	
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1 then
		UiManager:CloseWindow(Ui.UI_REPOSITORY);
	end
end


local szCmd	= [=[
		UiManager.OnOpen();
	]=];
UiShortcutAlias:AddAlias("GM_C5", szCmd);

