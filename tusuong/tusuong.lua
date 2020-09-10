
Ui.UI_UNREAL         ="UI_UNREAL";
local uiUnreal	= Ui.tbWnd[Ui.UI_UNREAL] or {};
uiUnreal.UIGROUP	= Ui.UI_UNREAL;
Ui.tbWnd[Ui.UI_UNREAL] = uiUnreal

local tbSaveData 	= Ui.tbLogic.tbSaveData;
local tbUnreal 	= Ui.tbLogic.tbUnreal;
uiUnreal.DATA_KEY	= "Unreal";

Ui:RegisterNewUiWindow("UI_UNREAL", "UNREAL", {"a", 520, 220}, {"b", 520, 220}, {"c", 520, 220}, {"d", 1011, 429});


local BUTTON_CLOSE ="BtnClose"
local BUTTON_LONG ="BtnLong"
local BUTTON_FENG="BtnFeng"
local BUTTON_QING="BtnQing"
local BUTTON_ACT="BtnAct"
local BUTTON_CAN="BtnCan"
local EDIT_CONTENT 	= "EdtContent";
local BUTTON_ABE="Btnabe"

local self = uiUnreal
local nUnrealTimerId = 0
local nUrTime = 10
self.nULong=0
self.nUFeng=0
self.nUQing=0
self.nJinQuan=0
self.nLingGuan=0
self.nWang=0
self.nBian=0
self.nUnRealState=0
self.nUnRealCode=903

self.nTTime = 0
self.nBianHuan =0

uiUnreal.OnButtonClick=function(self,szWnd, nParam)
        if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP); 
	elseif (szWnd == BUTTON_LONG) then
                self.nULong=nParam
		if nParam==1 then
                   me.AddSkillEffect(408)
                else
                   me.RemoveSkillEffect(408)
		end
	elseif (szWnd == BUTTON_FENG) then
                self.nUFeng=nParam
		if nParam==1 then
                   me.AddSkillEffect(407)
                else
                   me.RemoveSkillEffect(407)
		end
	elseif (szWnd == BUTTON_QING) then
                self.nUQing=nParam
		if nParam==1 then
                   me.AddSkillEffect(406)
                else
                   me.RemoveSkillEffect(406)
		end

	elseif szWnd == "BtnJinQuan" then
		self.nJinQuan=nParam
		if nParam==1 then
                   me.AddSkillEffect(350)
                else
                   me.RemoveSkillEffect(350)
		end

	elseif szWnd == "BtnLingGuan" then
		self.nLingGuan=nParam
		if nParam==1 then
                   me.AddSkillEffect(360)
                else
                   me.RemoveSkillEffect(360)
		end

	elseif szWnd == "BtnWang" then
		self.nWang=nParam
		if nParam==1 then
			me.AddSkillEffect(354)
			me.AddSkillEffect(355)
                else
			me.RemoveSkillEffect(354)
			me.RemoveSkillEffect(355)
		end

	elseif szWnd == "BtnBian" then
		self.nBian=nParam
		if nParam==1 then
			self.nBianHuan = Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS, self.BianHuan, self);
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Mở Biến Hình<color>")
		else
			Ui.tbLogic.tbTimer:Close(self.nBianHuan);
			self.nBianHuan = 0
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tắt Biến Hình<color>")
		end

        elseif (szWnd == BUTTON_ABE) then
                self.nUnRealState=nParam
		if nParam==1 then
		  me.Msg("<color=0,255,255>Chu kỳ<color>");
                  if self.nULong == 1 then
                     self.nUnRealCode = 408;
                  elseif self.nUFeng == 1 then
                     self.nUnRealCode = 407;
                  elseif self.nUQing == 1 then
                     self.nUnRealCode = 406;
                  elseif self.nJinQuan == 1 then
                     self.nUnRealCode = 350;
                  elseif self.nLingGuan == 1 then
                     self.nUnRealCode = 360;
                  elseif self.nWang == 1 then
                     self.nUnRealCode = 354;
                  else
                     self.nUnRealCode = Edt_GetInt(self.UIGROUP, EDIT_CONTENT)
                  end
	          nUnrealTimerId = Ui.tbLogic.tbTimer:Register(nUrTime * Env.GAME_FPS, self.unrealact, self);
	        else
		  me.Msg("<color=0,255,255>Vòng Khép Kín<color>");
	          Ui.tbLogic.tbTimer:Close(nUnrealTimerId);
                  me.RemoveSkillEffect(self.nUnRealCode)
		if self.nWang == 1 then
			me.RemoveSkillEffect(355);
		end
                  nUnrealTimerId = 0;
                  self.nULong = 0;
                  self.nUFeng = 0;
                  self.nUQing = 0;
	          self:UpdateWnd();
		end
        elseif (szWnd == BUTTON_ACT) then
                  local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		    if nTimes >= 1 and  nTimes <= 903 then
                    self.nUnRealCode=nTimes
                   me.AddSkillEffect(self.nUnRealCode)
                   end
        elseif (szWnd == BUTTON_CAN) then
               local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		    if nTimes >= 1 and  nTimes <= 903 then
                    self.nUnRealCode=nTimes
                   me.RemoveSkillEffect(self.nUnRealCode)
                   end
        end

end

function uiUnreal:BianHuan()
	if self.nBianHuan == 0 then
		return
	end
	me.RemoveSkillEffect(self.nTTime)
	self.nTTime = MathRandom(1,903);
	me.AddSkillEffect(self.nTTime)
end

function uiUnreal:OnEditChange(szWnd, nParam)
	if (szWnd == EDIT_CONTENT) then
		local nTimes = Edt_GetInt(self.UIGROUP, EDIT_CONTENT);
		if nTimes > 903 then
			Edt_SetInt(self.UIGROUP, EDIT_CONTENT, 903);
		end
	end
end

function uiUnreal:unrealact()
        if self.nUnRealCode then
		me.AddSkillEffect(self.nUnRealCode);
		if self.nWang == 1 then
			me.AddSkillEffect(355);
		end
        end
end
-------------------------------------------
function uiUnreal:SaveData()
	self.tbUnrealSetting = { nULong = self.nULong, nUFeng=self.nUFeng, nUQing= self.nUQing,nUnRealState=self.nUnRealState,n1=self.nJinQuan,n2=self.nLingGuan,n3=self.nWang,n4=self.nBian, } 
	tbSaveData:Save(self.DATA_KEY, self.tbUnrealSetting);
end

function uiUnreal:LoadSetting()
	local tbUnrealSetting = tbSaveData:Load(self.DATA_KEY);
	if tbUnrealSetting.nULong then
		self.nULong = tbUnrealSetting.nULong;
	end
	if tbUnrealSetting.nUFeng then
		self.nUFeng = tbUnrealSetting.nUFeng;
	end
	if tbUnrealSetting.nUQing then
		self.nUQing = tbUnrealSetting.nUQing;
	end
	if tbUnrealSetting.nUnRealState then
		self.nUnRealState = tbUnrealSetting.nUnRealState;
	end

	if tbUnrealSetting.n1 then
		self.nJinQuan = tbUnrealSetting.n1
	end
	if tbUnrealSetting.n2 then
		self.nLingGuan = tbUnrealSetting.n2
	end
	if tbUnrealSetting.n3 then
		self.nWang = tbUnrealSetting.n3
	end
	if tbUnrealSetting.n4 then
		self.nBian = tbUnrealSetting.n4
	end

	tbUnrealSetting = { nULong = self.nULong, nUFeng=self.nUFeng, nUQing= self.nUQing,nUnRealState=self.nUnRealState,  n1=self.nJinQuan,n2=self.nLingGuan,n3=self.nWang,n4=self.nBian, } 


	if self.tbUnrealSetting then
		self.nULong = tbUnrealSetting.nULong;
		self.nUFeng = tbUnrealSetting.nUFeng;
		self.nUQing = tbUnrealSetting.nUQing;
		self.nUnRealState = tbUnrealSetting.nUnRealState;
		self.nJinQuan = tbUnrealSetting.n1
		self.nLingGuan = tbUnrealSetting.n2
		self.nWang = tbUnrealSetting.n3
		self.nBian = tbUnrealSetting.n4
	end
end

function uiUnreal:OnOpen()
	self:LoadSetting();
	self:UpdateWnd();
        Edt_SetInt(self.UIGROUP, EDIT_CONTENT, self.nUnRealCode);
end

function uiUnreal:UpdateWnd()
	Btn_Check(self.UIGROUP, BUTTON_LONG, self.nULong);
	Btn_Check(self.UIGROUP, BUTTON_FENG, self.nUFeng);
	Btn_Check(self.UIGROUP, BUTTON_QING, self.nUQing);
	Btn_Check(self.UIGROUP, "BtnJinQuan", self.nJinQuan);
	Btn_Check(self.UIGROUP, "BtnLingGuan", self.nLingGuan);
	Btn_Check(self.UIGROUP, "BtnWang", self.nWang);
	Btn_Check(self.UIGROUP, "BtnBian", self.nBian);
	Btn_Check(self.UIGROUP, BUTTON_ABE, self.nUnRealState);
end

LoadUiGroup(Ui.UI_UNREAL, "tusuong.ini");