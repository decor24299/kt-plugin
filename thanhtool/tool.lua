Ui.UI_TOOL				= "UI_TOOL";
local uiTool			= Ui.tbWnd[Ui.UI_TOOL] or {};
uiTool.UIGROUP			= Ui.UI_TOOL;
Ui.tbWnd[Ui.UI_TOOL]	= uiTool
Map.tbTool		= uiTool;
-----------------------------------------------------------------------
local BtnST1							= "BtnST1"
local BtnST2					        = "BtnST2"
local BtnST3				            = "BtnST3"

local BtnST4							= "BtnST4"
local BtnST5							= "BtnST5"
local BtnST6							= "BtnST6"
local BtnST7							= "BtnST7"
local BtnST8							= "BtnST8"
local BtnST9							= "BtnST9"
local BtnST10							= "BtnST10"

local BtnST11							= "BtnST11"
local BtnST12							= "BtnST12"
local BtnST13							= "BtnST13"
local BtnST14							= "BtnST14"
local BtnST15							= "BtnST15"
local self								= uiTool 
local tbTimer = Ui.tbLogic.tbTimer;
Ui:RegisterNewUiWindow("UI_TOOL", "tool", {"a", 714, 229}, {"b", 752,267}, {"c", 1240, 245});


function uiTool:OnButtonClick(szWnd)
--------------------------------------
	if (szWnd == BtnST1) then
		Ui.RungGaiHL:RRungGai();
	elseif (szWnd == BtnST2) then
		Map.tbSuperCall:QuangAnhThach();
	elseif (szWnd == BtnST3) then
		Map.tbSuperCall:AutoPuFire();
--------------------------------------
	elseif (szWnd == BtnST4) then
		Ui.VuotRaoHS:JumpSwitch();
	elseif (szWnd == BtnST5) then
		Map.tbAutoEgg2:AutoPick();	
	elseif (szWnd == BtnST6) then 
		Map.tbAutoEgg1:AutoPick();
	elseif (szWnd == BtnST7) then
		uiTool.DaoJu();	
	elseif (szWnd == BtnST8) then
		uiTool.NKT();
	elseif (szWnd == BtnST9) then
		uiTool.DBC();
	elseif (szWnd == BtnST10) then
		uiTool:FishHook();		
--------------------------------------
	elseif szWnd == BtnST11 then		    
		Ui(Ui.UI_COMPOSE):SwitchCompose();
		--UIManager:hexuan();
	elseif szWnd == BtnST12 then	
		UiManager:StartBao();
	elseif szWnd == BtnST13 then	
		--AutoAi:StartAutoFight();
		UiManager:StopBao();
	elseif szWnd == BtnST14 then
		UiManager:StartGua();	
	elseif szWnd == BtnST15 then	
		UiManager:SwitchWindow(Ui.UI_SPRBAO_SETTING);

	end
end

uiTool.DaoJu=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,603,1)
		SendChannelMsg("Team", string.format("Công cụ %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
	end
end

uiTool.NKT=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,623,1)
		SendChannelMsg("Team", string.format("Nhiếp Không Thảo %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Bách Man Sơn<color>");
	end
end

uiTool.DBC=function(self)
	if me.GetMapTemplateId() > 65500 then
		local nCount=me.GetItemCountInBags(20,1,626,1)
		SendChannelMsg("Team", string.format("Đuôi Bọ Cạp %d", nCount));
	else
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Bách Man Sơn<color>");
		end
end

uiTool.FishHook_Two=function(self)
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
	if nWorldPosX==13216/8 and nWorldPosY==62048/16 then
		me.RemoveSkillEffect(Player.HEAD_STATE_AUTOPATH)
		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then 
			local tbFind = me.FindItemInBags(20,1,253,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		end
		if me.GetItemCountInBags(20,1,617,1)>=10 then
			me.Msg("Cá")
			Ui.tbLogic.tbTimer:Close(self.FishHookId)
		end
	else
		me.AutoPath(13216/8,62048/16)
		me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH)
	end
end
uiTool.FishHook=function(self)
	Ui.tbLogic.tbTimer:Close(self.FishHookId)
	if me.GetMapTemplateId() > 65500 then
		me.Msg("<color=yellow>Bắt đầu tự động Câu cá<color>")
		if me.GetItemCountInBags(20,1,253,1)>=1 or me.GetItemCountInBags(20,1,254,1)>=1 then
			self.FishHookId=tbTimer:Register(Env.GAME_FPS, self.FishHook_Two, self);
		end
	else
UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chức năng này chỉ hoạt động trong Hậu Phục Ngưu Sơn<color>");
	end
end
