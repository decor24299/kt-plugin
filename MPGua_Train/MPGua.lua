Ui.UI_TBMPGUA		= "UI_TBMPGUA";
local tbMPGua		= Ui.tbWnd[Ui.UI_TBMPGUA] or {};	
tbMPGua.UIGROUP		= Ui.UI_TBMPGUA;
Ui.tbWnd[Ui.UI_TBMPGUA] = tbMPGua
local self=tbMPGua;

local nDenJi = 5;		

tbMPGua.BTN_CLOSE	="BtnClose";
tbMPGua.BTN_POS1	="BtnPos1";
tbMPGua.EDT_POS1	="EdtPos1";
tbMPGua.BTN_POS2	="BtnPos2";
tbMPGua.EDT_POS2	="EdtPos2";
tbMPGua.BTN_POS3	="BtnPos3";
tbMPGua.EDT_POS3	="EdtPos3";
tbMPGua.BTN_POS4	="BtnPos4";
tbMPGua.EDT_POS4	="EdtPos4";
tbMPGua.BTN_POS5	="BtnPos5";
tbMPGua.EDT_POS5	="EdtPos5";
tbMPGua.BTN_POS6	="BtnPos6";
tbMPGua.EDT_POS6	="EdtPos6";
tbMPGua.BTN_POS7	="BtnPos7";
tbMPGua.EDT_POS7	="EdtPos7";
tbMPGua.BTN_POS8	="BtnPos8";
tbMPGua.EDT_POS8	="EdtPos8";
tbMPGua.BTN_POS9	="BtnPos9";
tbMPGua.EDT_POS9	="EdtPos9";
tbMPGua.BTN_POS10	="BtnPos10";
tbMPGua.EDT_POS10	="EdtPos10";
tbMPGua.BTN_POS11	="BtnPos11";
tbMPGua.EDT_POS11	="EdtPos11";
tbMPGua.BTN_POS12	="BtnPos12";
tbMPGua.EDT_POS12	="EdtPos12";
tbMPGua.BTN_POS13	="BtnPos13";
tbMPGua.EDT_POS13	="EdtPos13";
tbMPGua.BTN_POS14	="BtnPos14";
tbMPGua.EDT_POS14	="EdtPos14";
tbMPGua.BTN_POS15	="BtnPos15";
tbMPGua.EDT_POS15	="EdtPos15";
tbMPGua.BTN_POS16	="BtnPos16";
tbMPGua.EDT_POS16	="EdtPos16";

tbMPGua.BTN_RED1	="BtnRedDrug1";
tbMPGua.BTN_RED2	="BtnRedDrug2";
tbMPGua.EDT_REDNUM	="EdtRedDrugNum";
tbMPGua.BTN_BLUE1	="BtnBlueDrug1";
tbMPGua.BTN_BLUE2	="BtnBlueDrug2";
tbMPGua.EDT_BLUENUM	="EdtBlueDrugNum";	

tbMPGua.BTN_TQHeXuan	="BtnTQHeXuan";		
tbMPGua.BTN_HX1		="BtnHeXuan1";		
tbMPGua.BTN_YMZ		="BtnYeMingZhu";	
tbMPGua.BTN_BuyCai1	="BtnBuyCai1";	

tbMPGua.BTN_HX2		="BtnHeXuan2";		
tbMPGua.BTN_BUYCAI2	="BtnBuyCai2"		
tbMPGua.EDT_CAINUM	="EdtCaiNum";		
tbMPGua.BTN_FIREWAIT	="BtnFireWait";		

tbMPGua.BTN_START	="BtnStart";		
tbMPGua.BTN_SAVE	="BtnSave";		
tbMPGua.BTN_RESET	="BtnReset";		
tbMPGua.TXT_POS		="TxtPosInfo";		

tbMPGua.tbPos		={};
tbMPGua.nState		=0;
tbMPGua.nCurPos		=0;

tbMPGua.nTimes		=0;

tbMPGua.nMapId		=0;
tbMPGua.nRedDrugType	=2;	
tbMPGua.nBlueDrugType	=2;	
tbMPGua.nRedNum		=-1;
tbMPGua.nBlueNum	=-1;
tbMPGua.nHX1		=1;
tbMPGua.nYeMingZhu	=0;
tbMPGua.nTQHeXuan	=0;
tbMPGua.nHX2		=0;
tbMPGua.nBuyCai		=1;
tbMPGua.nCaiNum		=6;
tbMPGua.nFireWait	=1;

tbMPGua.bAutoClose	=0;

tbMPGua.nCountDead	=0;

local mypos		=0;
local nSkillId		=0;

local nPao = 0
local nMeSit = 0

tbMPGua.BTN_Tu1 = "BtnTu1"
tbMPGua.Page = 0
self.nZmap = 0

function tbMPGua:OnOpen()
	for i=1,16 do
		Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "");
	end
	if(self.nState==0) then
		if self.Page == 0 then
			self:Load(0);
		else
			self:Load(1);
		end
	end
	self:OnSet()
end

function tbMPGua:OnSet()
	for i=1,#self.tbPos do
		Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "("..self.tbPos[i][1]..","..self.tbPos[i][2]..")");
	end

	if(self.nRedDrugType==1) then
		Btn_Check(self.UIGROUP,self.BTN_RED1,1);
	else
		Btn_Check(self.UIGROUP,self.BTN_RED2,1);
	end

	if(self.nBlueDrugType==1) then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,1);
	else
		Btn_Check(self.UIGROUP,self.BTN_BLUE2,1);
	end

	Btn_Check(self.UIGROUP,self.BTN_TQHeXuan,self.nTQHeXuan);
	Btn_Check(self.UIGROUP,self.BTN_HX1,self.nHX1);
	Btn_Check(self.UIGROUP,self.BTN_YMZ,self.nYeMingZhu);
	Edt_SetInt(self.UIGROUP,self.EDT_REDNUM,self.nRedNum);
	Edt_SetInt(self.UIGROUP,self.EDT_BLUENUM,self.nBlueNum);

	if(self.nRedNum==-1) then
		Edt_SetInt(self.UIGROUP, self.EDT_REDNUM, 2);
	end

	if(self.nBlueNum==-1)	then
		Edt_SetInt(self.UIGROUP, self.EDT_BLUENUM, 0);
	end

	Btn_Check(self.UIGROUP,self.BTN_BUYCAI2,self.nBuyCai);
	Edt_SetInt(self.UIGROUP,self.EDT_CAINUM,self.nCaiNum);
	Btn_Check(self.UIGROUP,self.BTN_HX2,self.nHX2);
	Btn_Check(self.UIGROUP,self.BTN_FIREWAIT,self.nFireWait);

	if(self.nState==0) then
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Luyen");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_SAVE,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_Tu1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_TQHeXuan,1);

	else
			for i=1,16 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,0);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,0);
			end
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,0);
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Ngưng");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_SAVE,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_Tu1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_TQHeXuan,0);
	end

        Btn_Check(self.UIGROUP,self.BTN_BuyCai1,1);
	Wnd_SetEnable(self.UIGROUP,self.BTN_BuyCai1,0);
	if(self.nMapId>0) then
		Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Điểm nhớ "..GetMapNameFormId(self.nMapId).." Treo");
	end
end

function tbMPGua:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_START then					
		self:MPGstart();
		if(self.nState==0) then
			for i=1,16 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,1);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,1);
			end
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Luyen");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_SAVE,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_Tu1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_TQHeXuan,1);
			if(self.nMapId>0) then
				Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Treo tại "..GetMapNameFormId(self.nMapId).." Luyện Cong");
			end

		else
			if(self.nMapId==0 or (self.nMapId <30 and self.nMapId >22) or (self.nMapId <9 and self.nMapId >0)) then
				me.Msg("Map An toan!!!");
				return;
			end

			self.nCountDead=0;

			self.nRedNum	=Edt_GetInt(self.UIGROUP,self.EDT_REDNUM);
			self.nBlueNum	=Edt_GetInt(self.UIGROUP,self.EDT_BLUENUM);
			self.nCaiNum	=Edt_GetInt(self.UIGROUP,self.EDT_CAINUM);
			for i=1,16 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,0);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,0);
			end

			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Ngung");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_SAVE,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_Tu1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_TQHeXuan,0);
		end

	elseif szWnd == self.BTN_CLOSE then
		UiManager:SwitchWindow(Ui.UI_TBMPGUA);
	elseif szWnd == self.BTN_POS1 then
		local nMapId,nX,nY = me.GetWorldPos();
		self.nMapId=nMapId;
		self.tbPos[1]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS1, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS2 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[2]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS2, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS3 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[3]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS3, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS4 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[4]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS4, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS5 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[5]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS5, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS6 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[6]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS6, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS7 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[7]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS7, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS8 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[8]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS8, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS9 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[9]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS9, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS10 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[10]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS10, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS11 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[11]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS11, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS12 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[12]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS12, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS13 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[13]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS13, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS14 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[14]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS14, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS15 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[15]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS15, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS16 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[16]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS16, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_RED1 then
		Btn_Check(self.UIGROUP,self.BTN_RED1,1);
        	Btn_Check(self.UIGROUP,self.BTN_RED2,0);
		self.nRedDrugType=1;
	elseif szWnd == self.BTN_RED2 then
		Btn_Check(self.UIGROUP,self.BTN_RED1,0);
        	Btn_Check(self.UIGROUP,self.BTN_RED2,1);
		self.nRedDrugType=2;
	elseif szWnd == self.BTN_BLUE1 then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,1);
        	Btn_Check(self.UIGROUP,self.BTN_BLUE2,0);
		self.nBlueDrugType=1;
	elseif szWnd == self.BTN_BLUE2 then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,0);
        	Btn_Check(self.UIGROUP,self.BTN_BLUE2,1);
		self.nBlueDrugType=2;
	elseif szWnd == self.BTN_HX1 then
		self.nHX1=nParam;
	elseif szWnd == self.BTN_YMZ then
		self.nYeMingZhu=nParam;
	elseif szWnd == self.BTN_BUYCAI2 then
		self.nBuyCai=nParam;
	elseif szWnd == self.BTN_HX2 then
		self.nHX2=nParam;
	elseif szWnd == self.BTN_FIREWAIT then
		self.nFireWait=nParam;
	elseif szWnd == self.BTN_SAVE then
		self:Save(self.Page);
	elseif szWnd == self.BTN_RESET then
		for i=1,16 do
			Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,1);
			Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,1);
			Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "");
		end
		self.tbPos={};
		self.nMapId=0;

	elseif szWnd == self.BTN_Tu1 then
		for i=1,16 do
			Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "");
		end

		if self.Page == 0 then
			self.Page = 1
			me.Msg("<color=0,255,255>Tọa độ mới<color>")
			local szData = KFile.ReadTxtFile("\\user\\MPGua_Train\\MPGua\\"..me.szName.."_MPGua222.dat");
			if (not szData) then
				self.tbPos={};
				self.nMapId=0;
				return;
			end
			self:Load(1);
			self:OnSet()

		else
			self.Page = 0
			self:Load(0);
			self:OnSet()
			me.Msg("<color=yellow>Tọa độ cũ<color>")
		end
	elseif szWnd == self.BTN_TQHeXuan then
		self.nTQHeXuan=nParam;
	end
end

local szCmd = [=[
	Ui(Ui.UI_TBMPGUA):MPGstart();
	]=];		
	UiShortcutAlias:AddAlias("GM_S4", szCmd);	

function tbMPGua:MPGstart()	
	if(self.nState==0) then
		self.nState=1;
		self.nCurPos=1;
		self.nTimerId=Ui.tbLogic.tbTimer:Register(0.3* Env.GAME_FPS,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bat Luyen Cong<color>")
		if (me.nTemplateMapId==1536) or (me.nTemplateMapId==1537) or (me.nTemplateMapId==1538) or (me.nTemplateMapId==1539) then
			Ui(Ui.UI_TASKTIPS):Begin("Treo Tan Lang")
		elseif me.nTemplateMapId > 0 and me.nTemplateMapId < 1536 then
			Ui(Ui.UI_TASKTIPS):Begin("Treo May Danh NPC")
		end
		local function fnCloseSay()
			if self.nState==0 then
				return 0
			end
			if me.nAutoFightState == 1 then
				self:TeHeXuan()
			end
		end
		if self.nTQHeXuan == 1 then
			--Ui(Ui.UI_COMPOSE):StartCompose();		
			Ui.tbLogic.tbTimer:Register(180, fnCloseSay);
		end
	else
		self.nState=0;
		nPao = 0;
		mypos = 0;
		self.nZmap = 0;
		Ui.tbLogic.tbTimer:Close(self.nTimerId);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Tat Luyen Cong<color>")
		Ui(Ui.UI_COMPOSE):StopCompose();
		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
	end
end

function tbMPGua:TeHeXuan()        
		local nCount_Xuan41 = me.GetItemCountInBags(18,1,1,4)
        local nCount_Xuan42 = me.GetItemCountInBags(18,1,114,4)
        local nCount_Xuan4 = nCount_Xuan41+nCount_Xuan42
        local nCount_Xuan51 = me.GetItemCountInBags(18,1,1,5)
        local nCount_Xuan52 = me.GetItemCountInBags(18,1,114,5)
        local nCount_Xuan5 = nCount_Xuan51+nCount_Xuan52
	local num = me.CountFreeBagCell();
	me.Msg("<color=yellow>Ô trống hiện tại là <color><color=white>: <color>"..num)
	if num > 13 then
		if (nCount_Xuan4 > 12 or nCount_Xuan5 > 12) and self:IsMoving() == 0 then
			Ui(Ui.UI_COMPOSE):SwitchCompose()
		end
	else
		if (nCount_Xuan4 > 3 or nCount_Xuan5 > 3) and self:IsMoving() == 0 then
			Ui(Ui.UI_COMPOSE):SwitchCompose()
		end
	end
end

function tbMPGua:IsMoving()
	local nRunning = 0;
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		nRunning = 1;
	end
	return nRunning;
end

function tbMPGua:OnTimer()
	--self:NewCheck();
	local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
	if (nMyMapId <= 0 or nMyPosX <= 0) then	
		return;	
	end
	
	if self.nZmap == 1 and me.nTemplateMapId < 30 then		
		self.nZmap = 0
		Ui(Ui.UI_TASKTIPS):Begin("Đi đến NPC")
		me.Msg("<color=yellow>Đi đến NPC<color>")
		if self.nState ~= 0 then
			if UiManager:WindowVisible(Ui.UI_TBMPGUA) ~= 1 then
				UiManager:SwitchWindow(Ui.UI_TBMPGUA)
			end
			local tbMPGua = Ui(Ui.UI_TBMPGUA)
			tbMPGua.OnButtonClick(tbMPGua,"BtnStart")
			UiManager:SwitchWindow(Ui.UI_TBMPGUA)
		end
		me.CallServerScript({"ApplyUpdateOnlineState", 1});
		return;
	end
	if me.nTemplateMapId == 1536 or me.nTemplateMapId == 1537 or me.nTemplateMapId == 1538 then
		self.nZmap = 1
	end

	self.nTimes=self.nTimes+1;

	if(self.nTimes%25==0) then
		--UiManager:OpenWindow("UI_INFOBOARD", string.format("<color=yellow>Luyện Công!!!<color>"));
		print("Luyen Cong Tai self.nState="..self.nState.."    mypos="..mypos.."play");
	end


	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			self.bAutoClose=0;
	end

	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			UiManager:CloseWindow(Ui.UI_SHOP);
			self.bAutoClose=0;
	end

	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1) then
			UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE);
			self.bAutoClose=0;
	end


	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;	
	end


	if(self.nState==1) then			
		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		if (me.IsDead() == 1) then
			self.nCountDead=self.nCountDead+1;
			me.SendClientCmdRevive(0);
			AutoAi.SetTargetIndex(0);
			return ;
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).." Di chuyển đến TĐ "..self.nCurPos.." Đánh NPC");
		end

		local nMapId=me.nTemplateMapId;
		if (nMapId>0 and nMapId ~=self.nMapId) then
			local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
			if self.nMapId > 1535 and self.nMapId < 1540 and ((nMapId > 0 and nMapId < 9) or (nMapId == 132) or (nMapId > 22 and nMapId < 30)) then
				--Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,2441,1"});
				--UiManager.tbLinkClass["npcpos"]:OnClick(",132,2441,1");				
				local LTT = tbMPGua.TimNPC_TEN("Lương Tiếu Tiếu")
				if LTT then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						if string.find(szQuestion,"Lương Tiếu Tiếu: Lâu lắm rồi ta chưa thấy một tên trộm nào dám mò vào đây,") then
							me.Msg("<color=White>Hỏi : <color>"..szQuestion)
							for i = 1,table.getn(tbAnswers) do
								if string.find(tbAnswers[i],"Được thôi! Đưa ta đi nào!") then								
									me.Msg(tostring("<bclr=0,0,200><color=White>Chọn : <bclr><color>"..tbAnswers[i]))
									return Env.GAME_FPS * 0.5, me.AnswerQestion(i-1), UiManager:CloseWindow(Ui.UI_SAYPANEL);
								end
							end
						end
					else
						AutoAi.SetTargetIndex(LTT.nIndex)
					end
				else
					tbMPGua.GoTo(132,KNpc.ClientGetNpcPos(me.GetMapTemplateId(),2441));
					--tbMPGua.GoTo(132,1948,3306)
				end
				
				return
			end
			if nMapId == 1536 and me.nFightState == 0 then
				self:Check();
				if self.nState ~= 7 then
					self.nState = 9
				end				
				return
			end
			-- if me.nTemplateMapId == 1536 then
				-- tbMPGua.GoTo(1536,1768,4016)
			-- elseif me.nTemplateMapId == 1537 then
				-- tbMPGua.GoTo(1537,1968,3682)
			-- end
			--Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ","..self.nMapId..","..self.tbPos[self.nCurPos][1]..","..self.tbPos[self.nCurPos][2]});
			--UiManager.tbLinkClass["pos"]:OnClick(","..self.nMapId..","..self.tbPos[self.nCurPos][1]..","..self.tbPos[self.nCurPos][2]);
			
			tbMPGua.GoTo(self.nMapId,self.tbPos[self.nCurPos][1],self.tbPos[self.nCurPos][2])
			return 2*Env.GAME_FPS;
		end

		local _,nX,nY = me.GetWorldPos();
		if (self.tbPos[self.nCurPos][1]-nX)^2+(self.tbPos[self.nCurPos][2]-nY)^2 > 5400 then
			if me.GetNpc().nIsRideHorse == 0 then
				Switch([[horse]]);
			end
		end

		if(math.abs(nX-self.tbPos[self.nCurPos][1]) < 5 and math.abs(nY-self.tbPos[self.nCurPos][2]) < 5) then
			self.nState=2;
		else
			if me.nFightState ~= 1 and nMapId == 1536 then
				nPao = self:nCPaos()
				self.nState = 9
			end
			AutoAi.SetTargetIndex(0);
			me.AutoPath(self.tbPos[self.nCurPos][1],self.tbPos[self.nCurPos][2]);
		end

		self:Check();

	elseif (self.nState==2) then		
		if me.nAutoFightState == 0 and me.nFightState == 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end

 		if UiManager:WindowVisible(Ui.UI_PAYONLINE) == 1 then
			UiManager:CloseWindow(Ui.UI_PAYONLINE);
		end

		if (me.IsDead() == 1) then
			self.nCountDead=self.nCountDead+1;
			me.SendClientCmdRevive(0);
			self.nState=1;
			AutoAi.SetTargetIndex(0);
			return ;
		end

		if(me.GetActiveAuraSkill()==0 and nSkillId>0) then
			UseSkill(nSkillId);
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).." Tọa độ "..self.nCurPos.." Đánh NPC");
		end

		local tbAroundNpc= KNpc.GetAroundNpcList(me,300);
		local nCount=0;
		local nWtime=0.3;
		local mX, mY = me.GetNpc().GetMpsPos();
		for i=1,#tbAroundNpc do
			local nX,nY=tbAroundNpc[i].GetMpsPos();

			if(tbAroundNpc[i].nKind==0 and self:GetToNpcDistance(mX, mY,nX,nY) < 700 and AutoAi.AiTargetCanAttack(tbAroundNpc[i].nIndex)==1) then
				nCount=nCount+1;
			end

			if(self.nFireWait==1 and tbAroundNpc[i].nTemplateId==2626) then
				nCount=1;
				nMeSit = 0;
				break;
			end

			if(tbAroundNpc[i].GetNpcType() == 1 or tbAroundNpc[i].GetNpcType() == 2) then
				nWtime=8;
			end
		end

		if me.GetNpc().nDoing == Npc.DO_SIT then
			nMeSit = nMeSit +1
		end

		if(#self.tbPos>1 and nCount<1 and nWtime<5) or nMeSit > 3 then
			if(self.nCurPos<#self.tbPos) then
				self.nCurPos=self.nCurPos+1;
			else
				self.nCurPos=1;
			end
			nMeSit = 0;
			self.nState=1;

		end

		self:Check();

		return nWtime*Env.GAME_FPS;

	elseif (self.nState==3) then

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).."Hỗ trợ  TLL");
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		local _,nX,nY = me.GetWorldPos();		

		if(mypos==2 and math.abs(nX-1746)<5 and math.abs(nY-3196)<5) then	
			self.nState=4;
			return;
		end

		if(mypos==1 and math.abs(nX-1762)<5 and math.abs(nY-3191)<5) then	
			mypos=2;
			return;
		end

		if(mypos==0 and math.abs(nX-1789)<3 and math.abs(nY-3240)<3) then	
			mypos=1;
		end

		if(mypos==0) then
			AutoAi.SetTargetIndex(0);
			me.AutoPath(1789,3240);
		end

		if(mypos==1) then
			self:MoveTo(1801,3226);		
			return	0.1* Env.GAME_FPS;
		end

		if(mypos==2) then
			self:MoveTo(1746,3196);
			return	0.1* Env.GAME_FPS;
		end

	elseif (self.nState==4) then	

		local nIndex_YeSou	=0;
		local nIndex_YeLianShi	=0;

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).." Tìm Tôn Cương");
		end

		if me.nTemplateMapId == 1538 then
			local tbAroundNpc	= KNpc.GetAroundNpcList(me,200);
			for i=1,#tbAroundNpc do
				if(nIndex_YeSou>0 and nIndex_YeLianShi>0) then
					break;
				end

				if(tbAroundNpc[i].nTemplateId==2447) then
					nIndex_YeSou=tbAroundNpc[i].nIndex;
				end
				if(tbAroundNpc[i].nTemplateId==3574) then
					nIndex_YeLianShi=tbAroundNpc[i].nIndex;					
				end
			end

			if(nIndex_YeSou==0 or nIndex_YeLianShi==0) then
				return;
			end
		end

		if me.nTemplateMapId == 1536 then
			nIndex_YeSou = UiManager:GetAroundNpcId(2443)
			if not nIndex_YeSou then
				self:MoveTo(1562,3618);
				return
			end

		end

		if(self.nHX1==1) then			
			local bHeX,ts=self:HeXuan(nIndex_YeLianShi);
			if(bHeX==1) then
				return ts;
			end
		end

		local nCount_Cai = me.GetItemCountInBags(19,3,1,5);
		if (nCount_Cai<5 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(825, 5-nCount_Cai);
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	1* Env.GAME_FPS;
		end

		if(nCount_Cai<5 and UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			AutoAi.SetTargetIndex(nIndex_YeSou);
			return	1* Env.GAME_FPS;
		end

		if (nCount_Cai<5 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(1);
			self.bAutoClose	=1 ;
			return	1* Env.GAME_FPS;
		end

		local nCount_HuiTianD=me.GetItemCountInBags(17,1,1,4);
		local nCount_JiuZhuanD=me.GetItemCountInBags(17,1,1,5);
		local nCount_DaBuSan=me.GetItemCountInBags(17,3,1,4);
		local nCount_ShouWuD=me.GetItemCountInBags(17,3,1,5);

		if (self.nRedDrugType==1 and self.nBlueDrugType==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(679, self.nRedNum-nCount_HuiTianD);		
			me.ShopBuyItem(689, self.nBlueNum-nCount_DaBuSan);
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==1 and self.nBlueDrugType==2 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(679, self.nRedNum-nCount_HuiTianD);		
			me.ShopBuyItem(690, self.nBlueNum-nCount_ShouWuD);
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==2 and self.nBlueDrugType==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(680, self.nRedNum-nCount_JiuZhuanD);
			me.ShopBuyItem(689, self.nBlueNum-nCount_DaBuSan);		
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==2 and self.nBlueDrugType==2 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(680, self.nRedNum-nCount_JiuZhuanD);
			me.ShopBuyItem(690, self.nBlueNum-nCount_ShouWuD);		
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);		
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		local bFlag=0;
		if((self.nRedDrugType==1 and nCount_HuiTianD<self.nRedNum) or (self.nRedDrugType==2 and nCount_JiuZhuanD<self.nRedNum)) then
			bFlag=1;
		end

		if((self.nBlueDrugType==1 and nCount_DaBuSan<self.nBlueNum) or (self.nBlueDrugType==2 and nCount_ShouWuD<self.nBlueNum)) then
			bFlag=1;
		end

		if(bFlag==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			AutoAi.SetTargetIndex(nIndex_YeSou);
			return	1* Env.GAME_FPS;
		end

		if (bFlag==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0);
			self.bAutoClose	=1 ;
			return	1.5* Env.GAME_FPS;
		end
		--------------------------------------
		if me.nTemplateMapId == 1538 then
			self.nState=5;
		else
			self.nState=9;
		end
		mypos=0;

	elseif (self.nState==5) then		

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).." ra khỏi khu an toàn");
		end

		local _,nX,nY = me.GetWorldPos();
		
		if(mypos==3 and math.abs(nX-1746)<5 and math.abs(nY-3267)<5) then
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

		if(mypos==0 and math.abs(nX-1786)<5 and math.abs(nY-3190)<5) then	
			me.Msg("Thay đổi 1");
			mypos=1;
		elseif(mypos==1 and math.abs(nX-1813)<3 and math.abs(nY-3216)<3) then
			me.Msg("Thay đổi 2");
			mypos=2;
		elseif(mypos==2 and math.abs(nX-1801)<5 and math.abs(nY-3226)<5) then 
			me.Msg("Thay đổi 3");
			mypos=3;
		end

		if(mypos==0) then
			self:MoveTo(1786,3190);
			return	0.1* Env.GAME_FPS;
		end

		if(mypos==1) then
			self:MoveTo(1811,3216);
			return	0.1* Env.GAME_FPS;
		end
		if(mypos==2) then
			self:MoveTo(1801,3226);
			return	0.1* Env.GAME_FPS;
		end
		if(mypos==3) then
			self:MoveTo(1789,3240);
			return	0.1* Env.GAME_FPS;
		end
	elseif (self.nState==6) then		

		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return;
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Luyện Công "..GetMapNameFormId(self.nMapId).." Về Giang Tân Thôn");
		end

		if(me.GetActiveAuraSkill()>0) then
			nSkillId	=me.GetActiveAuraSkill();
			UseSkill(nSkillId);
		end

		local nPosX,nPosY=self.tbPos[self.nCurPos][1],self.tbPos[self.nCurPos][2];
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();

		if (mypos<2 and nCurMapId>0 and nCurMapId~=5)  then

			if (nCurMapId <30 and nCurMapId >22) or (nCurMapId <9 and nCurMapId >0) then
				mypos=1;
				nPosX,nPosY=0,0;
			end

			if(mypos==0) then
				if(me.GetNpc().nIsRideHorse ~= 1) then
					Switch("horse");
				end

				local szInfoFile	= Map.tbSuperMapLink.tbAllMapInfo[nCurMapId].szInfoFile;
				local tbFileData	= Lib:LoadTabFile("\\setting\\map\\map_info\\" .. szInfoFile .. "\\info.txt");
				for nRowNum, tbRow in ipairs(tbFileData or {}) do
					if (tbRow.NpcTemplateId == "2525") then  
						AutoAi.SetTargetIndex(0);
						me.AutoPath(tonumber(tbRow.XPos)/32+MathRandom(-10, 10), tonumber(tbRow.YPos)/32+MathRandom(-10, 10));
						break;
					end
				end
				mypos=1;
				return 2.5* Env.GAME_FPS;
			end

			if(mypos==1 and ((nPosX-nWorldPosX)^2 + (nPosY-nWorldPosY)^2)>1500) then
				me.StopAutoPath();
				--Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "ho,5,1597,3149"});				
				--UiManager.tbLinkClass["pos"]:OnClick(",5,1597,3149");
				tbMPGua.GoTo(5,1597,3149)
				mypos=0;
				return 3* Env.GAME_FPS;
			else
				mypos=0;
				return 1.5* Env.GAME_FPS;
			end
		end

		if (mypos<4 and nCurMapId==5) then
			local nIndex_DaLaoBai,nIndex_YeLianShi=0,0;
			local tbAroundNpc	= KNpc.GetAroundNpcList(me,200);
			for i=1,#tbAroundNpc do
				if(nIndex_DaLaoBai>0 or nIndex_YeLianShi>0) then
					break;
				end

				if(tbAroundNpc[i].nTemplateId==3566) then
					nIndex_DaLaoBai=tbAroundNpc[i].nIndex;
				end
				if(tbAroundNpc[i].nTemplateId==3574) then
					nIndex_YeLianShi=tbAroundNpc[i].nIndex;
				end
			end

			local bFlag,ts=0,0;
			
			if(mypos<2 and self.nHX2==1) then				
				bFlag,ts=self:HeXuan(0);
				if(bFlag==1) then
					mypos=2;
				else
					me.Msg("...");
					mypos=3;
				end
			elseif(mypos<2) then
				mypos=3;
			end
			
			if(mypos==2) then
				local nX1, nY1 = KNpc.ClientGetNpcPos(5, 3574);
				if(math.abs(nWorldPosX-nX1)<5 and math.abs(nWorldPosY-nY1)<5) then
					print("nIndex_YeLianShi"..nIndex_YeLianShi);
					local bFlag,ts=self:HeXuan(nIndex_YeLianShi);
					if(bFlag==0) then
						mypos=3;
						me.Msg("Ghép huyền tinh xong...");
					end
					return ts;
				else					
					AutoAi.SetTargetIndex(0);
					me.AutoPath(nX1, nY1);
					return 1* Env.GAME_FPS;
				end
			end

			local nCaiLevel,nCaiID
			if me.nLevel < 30 then
				nCaiLevel=1
				nCaiID = 821
			end
			if (me.nLevel > 29) and (me.nLevel < 50) then
				nCaiLevel=2
				nCaiID = 822
			end
			if (me.nLevel > 49) and (me.nLevel < 70) then
				nCaiLevel=3
				nCaiID = 823
                        end
			if (me.nLevel > 69) and (me.nLevel < 90) then
				nCaiLevel =4
				nCaiID = 824
			end
			if me.nLevel >= 90 then
				nCaiLevel = 5
				nCaiID = 825
			end
			local nCount_Cai = me.GetItemCountInBags(19,3,1,nCaiLevel); 
			local nX1, nY1 = KNpc.ClientGetNpcPos(5, 3566);
			if(mypos==3  and math.abs(nWorldPosX-nX1)>5 and math.abs(nWorldPosY-nY1)>5) then
				AutoAi.SetTargetIndex(0);
				me.AutoPath(nX1, nY1);
				return 1* Env.GAME_FPS;
			end

			if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
				if(nCount_Cai<self.nCaiNum) then
					me.ShopBuyItem(nCaiID, self.nCaiNum-nCount_Cai);
				end
		     		UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
				self.bAutoClose	=1 ;
				mypos=4;
				return	2.5* Env.GAME_FPS;
			end

			if(UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nIndex_DaLaoBai);
				return	1* Env.GAME_FPS;
			end

			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				me.AnswerQestion(1);
				self.bAutoClose	=1 ;
				return	1* Env.GAME_FPS;
			end

		end

		if(mypos==4 and nCurMapId>0) then
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

	elseif (self.nState==7) then

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Tại "..GetMapNameFormId(self.nMapId).." Về khu an toàn");
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end

		AutoAi.SetTargetIndex(0);

		local nM,nX,nY = me.GetWorldPos();

		if me.nTemplateMapId==1536 and me.nFightState == 0 then
			self.nState = 8
			return;
		end

		if 3685 < self.tbPos[1][2] then
			if self.tbPos[1][1] < 1455 then
				me.AutoPath(1545,3653)
				nPao = 3
			else
				me.AutoPath(1590,3664)
				nPao = 1
			end

		else
			if self.tbPos[1][1] > 1567 then
				me.AutoPath(1590,3607)
				nPao = 2
			else
				me.AutoPath(1545,3653)
				nPao = 3
			end

		end

	elseif (self.nState==8) then
		if self.nHX1 == 1 then
			local nId = UiManager:GetAroundNpcId(3574)
			if nId then				
				local bHeX,ts=self:HeXuan(nId);
				if(bHeX==1) then					
					return ts;
				end
			else
				self:MoveTo(1574,3633);
				return	0.1* Env.GAME_FPS;
			end
		end

	elseif (self.nState==9) then

		if me.nFightState == 1 and me.nTemplateMapId == 1536 then
			self.nState = 1
			mypos = 0;
			nPao = 0;
			return
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"Khu an toàn "..GetMapNameFormId(self.nMapId).." Đang chạy ra");
		end

		local _,nX,nY = me.GetWorldPos();

		if(mypos==3 and math.abs(nX-1534)<5 and math.abs(nY-3662)<5) then
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

		if(mypos==0 and math.abs(nX-1565)<5 and math.abs(nY-3630)<5) then
			me.Msg("rời khu an toàn tầng 1");
			mypos=1;
		end

		if(mypos==0) then
			self:MoveTo(1565,3630);
			return	0.1* Env.GAME_FPS;
		end

		if(mypos==1) then
			if nPao == 1 then
				self:MoveTo(1586,3657);
			elseif nPao == 2 then
				self:MoveTo(1585,3610);
			elseif nPao == 3 or nPao == 0 then
				self:MoveTo(1549,3648);
			end
			return	0.1* Env.GAME_FPS;
		end

	end

end

function tbMPGua:nCPaos()
	local nPaos = 0
	if 3685 < self.tbPos[1][2] then
		if self.tbPos[1][1] < 1455 then
			nPaos = 3
		else
			nPaos = 1
		end

	else
		if self.tbPos[1][1] > 1567 then
			nPaos = 2
		else
			nPaos = 3
		end
	end
	return nPaos;
end

function tbMPGua:NewCheck()
	if (me.nTemplateMapId==1538 or me.nTemplateMapId==1536) then 
		local bNeedBuyCai=0
		local bNeedDrug=0
		local bNeedRepair=0
		if(bNeedBuyCai==1 or bNeedDrug==1 or nCount_FreeBag<3 or bNeedRepair==1) then			
			return;
		else
			
		end		
	end
	if (me.nTemplateMapId < 8 and me.nTemplateMapId > 0) or (me.nTemplateMapId < 30 and me.nTemplateMapId > 22) then
		
	end
end

function tbMPGua:Check()

	if (me.nTemplateMapId==1538) or (me.nTemplateMapId==1536) then
		local nCount_FreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
		if(nCount_FreeBag<3) then
			me.Msg("Hành Trang Đã đầy về xử lý mau");
		end
		local nCount_Cai = me.GetItemCountInBags(19,3,1,5);
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
		local bNoFoodEaten = 1;
		if (not nTime or nTime < 36) then
			bNoFoodEaten = 0
		end
		local bNeedBuyCai=0
		if bNoFoodEaten == 0 and nCount_Cai==0 then
			bNeedBuyCai=1
			me.Msg("Cần Rau");
		end


		local bNeedDrug=0
		local nCount_HuiTianD=me.GetItemCountInBags(17,1,1,4);
		local nCount_JiuZhuanD=me.GetItemCountInBags(17,1,1,5);
		local nCount_DaBuSan=me.GetItemCountInBags(17,3,1,4);
		local nCount_ShouWuD=me.GetItemCountInBags(17,3,1,5);

		if(self.nRedNum>0 and self.nRedDrugType==1 and nCount_HuiTianD<1) then
			bNeedDrug=1;
			me.Msg("Hồi thiên đơn");
		end
		if(self.nRedNum>0 and self.nRedDrugType==2 and nCount_JiuZhuanD<1) then
			bNeedDrug=1;
			me.Msg("Cửu Chuyển Hồi Hoàn Đan");
		end
		if(self.nBlueNum>0 and self.nBlueDrugType==1 and nCount_DaBuSan<1) then
			bNeedDrug=1;
			me.Msg("Thất Xảo Bổ Tâm Đơn");
		end
		if(self.nBlueNum>0 and self.nBlueDrugType==2 and nCount_ShouWuD<1) then
			bNeedDrug=1;
			me.Msg("Ngũ Hoa Ngọc Lộ Hoàn");
		end

		local bNeedRepair=0
		for i = 0, Item.EQUIPPOS_NUM - 1 do
			local pItem = me.GetItem(Item.ROOM_EQUIP,i,0);
			if pItem and pItem.nCurDur < Item.DUR_MAX / 10 then    
				bNeedRepair=1
			end
		end
		if bNeedRepair==1 then
			me.Msg("E Y O");
		end

		if(self.nYeMingZhu==1) then
			local nLevel, nState, nTime = me.GetSkillState(1413);
			local nCount_YeMingZ = me.GetItemCountInBags(18,1,357,1);

			if(nTime==nil and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				me.AnswerQestion(0);
				self.bAutoClose	=1;
				return;
			end

			if(nCount_YeMingZ>0 and nTime==nil) then
	     			local tbFind = me.FindItemInBags(18,1,357,1);
	     			me.UseItem(tbFind[1].pItem);
				me.Msg("<color=white>Dùng Dạ Minh Châu");
			end
		end

		if(bNeedBuyCai==1 or bNeedDrug==1 or nCount_FreeBag<3 or bNeedRepair==1) then

	
			if me.nTemplateMapId == 1538 then
				self.nState=3;		
			else
				self.nState=7;

			end
			mypos=0;		
		end

	elseif me.nTemplateMapId==1537 or me.nTemplateMapId==1539 then	

		if(self.nYeMingZhu==1) then
			local nLevel, nState, nTime = me.GetSkillState(1413);
			local nCount_YeMingZ = me.GetItemCountInBags(18,1,357,1);

			if(nTime==nil and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				me.AnswerQestion(0);
				self.bAutoClose	=1;
				return;
			end

			if(nCount_YeMingZ>0 and nTime==nil) then
	     			local tbFind = me.FindItemInBags(18,1,357,1);
	     			me.UseItem(tbFind[1].pItem);
				me.Msg("<color=white>Dùng Dạ Minh Châu");
			end
		end

	elseif(me.nTemplateMapId>0) then		
		if self.nHX2 == 0 and self.nBuyCai == 0 then
			return;
		end

		local nCount_FreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
		if(nCount_FreeBag<2) then
			me.Msg("Hành trang đầy");
		end

		local nCaiLevel
		if me.nLevel < 30 then
			nCaiLevel=1
		elseif (me.nLevel > 29) and (me.nLevel < 50) then
			nCaiLevel=2
		elseif (me.nLevel > 49) and (me.nLevel < 70) then
			nCaiLevel=3
                elseif (me.nLevel > 69) and (me.nLevel < 90) then
			nCaiLevel =4
		elseif me.nLevel >= 90 then
			nCaiLevel = 5
		end

		local nCount_Cai = me.GetItemCountInBags(19,3,1,nCaiLevel);
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
		local bNoFoodEaten = 1;
		if (not nTime or nTime < 50) then
			bNoFoodEaten = 0
		end
		local bNeedBuyCai=0
		if bNoFoodEaten == 0 and nCount_Cai==0 then   
			bNeedBuyCai=1
			me.Msg("<color=pink>Hết Rau");
		end

		local bNeedRepair=0
		for i = 0, Item.EQUIPPOS_NUM - 1 do
			local pItem = me.GetItem(Item.ROOM_EQUIP,i,0);
			if pItem and pItem.nCurDur < Item.DUR_MAX / 20 then     
				bNeedRepair=1
			end
		end
		if bNeedRepair==1 then
			me.Msg("E Y O");
		end

		if (bNeedBuyCai==1 or (nCount_FreeBag < 2 and self.nHX2 == 1) or bNeedRepair==1) then
			--if me.GetNpc().GetRangeDamageFlag() == 1 then
				--PlaySound("\\interface2\\Data\\enemy.wav", 0);
				
			--else
				self.nState=6;
				mypos=0;
			--end
		end
	end
end

function tbMPGua:HeXuan(nIndex)		
		local bFlag = 0;   
		local nCount={};
		for i = 1,nDenJi do
			nCount[i] = me.GetItemCountInBags(18,1,1,i);
			if nCount[i] >=4 and i <= nDenJi then
				bFlag=1;
			end
		end
		for i = 1,nDenJi do
			nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i);
			if nCount[i] >=4 and i <= nDenJi   then
				bFlag=1;
			end
		end
		
		if(nIndex==0) then
			return bFlag,1* Env.GAME_FPS;
		end

		if bFlag==0 then
			if me.nTemplateMapId == 1536 then
				self.nState = 4;
			end
			if(UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1) then--UI_EQUIPCOMPOSE
				self.bAutoClose=1;				
				return 1,1* Env.GAME_FPS;
			end
			return bFlag,1* Env.GAME_FPS;
		end

		
		if (UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1) then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			for i=1,nDenJi do
				if  nCount[i] >=13 then					
					self:MyFindItem2(18,1,1,i,1,13,114);					
					local function HebX()
 						me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
						return 0
					end
					Ui.tbLogic.tbTimer:Register(15, HebX);
					return bFlag,2* Env.GAME_FPS;
				end
			end

			for i=1,nDenJi do
				if  nCount[i] >=4 then
					self:MyFindItem2(18,1,1,i,1,4,114);
					local function HebX()
 						me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
						return 0
					end
					Ui.tbLogic.tbTimer:Register(15, HebX);
					return bFlag,2* Env.GAME_FPS;
				end
			end
		--end
		else--if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) ~= 1 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
				AutoAi.SetTargetIndex(nIndex);
			end
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
				me.AnswerQestion(0)
				me.AnswerQestion(0)
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return	bFlag,2* Env.GAME_FPS;			
		end

		return bFlag,2* Env.GAME_FPS;
end

function tbMPGua:MyFindItem2(g,d,p,l,bOffer,count,p1)
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then
		UiManager:SwitchWindow(Ui.UI_ITEMBOX); 
	end
	local k = 0;

	for nCont = 1, 11 do						
		if Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont] then
			for i = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRoom, i, 0);
				if pItem then
					local tbObj =Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].tbObjs[0][i];
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,0);
							if k >= count then
								return k;
							end
						end
					end
				end
			end
		end
	end
	return 0;
end

function tbMPGua:GetToNpcDistance(x1,y1,x2,y2)
	local dx = x1 - x2;
	local dy = y1 - y2;
	local nDistance = math.sqrt(dx^2 + dy^2);
	return nDistance;
end

function tbMPGua:MoveTo(x,y)
	local _, nX, nY	= me.GetWorldPos();
	local nDx		= x - nX + MathRandom(-2, 2);
	local nDy		= y - nY + MathRandom(-2, 2);
	local nDir		= math.fmod(64 - math.atan2(nDx, nDy) * 32 / math.pi, 64);
	MoveTo(nDir, 0);
end

function tbMPGua:Save(Tu)
	local	szUserFilePath1
	if Tu == 0 then
		szUserFilePath1 = "\\user\\MPGua_Train\\MPGua\\"..me.szName.."_MPGua.dat";
	else
		szUserFilePath1 = "\\user\\MPGua_Train\\MPGua\\"..me.szName.."_MPGua222.dat";
	end
	self.nRedNum	=Edt_GetInt(self.UIGROUP,self.EDT_REDNUM);
	self.nBlueNum	=Edt_GetInt(self.UIGROUP,self.EDT_BLUENUM);
	self.nCaiNum	=Edt_GetInt(self.UIGROUP,self.EDT_CAINUM);
	local	tbSetting=
		{
			nMapId		=self.nMapId;
			tbPos		=self.tbPos;
			nRedDrugType	=self.nRedDrugType;
			nBlueDrugType	=self.nBlueDrugType;
			nRedNum		=self.nRedNum;
			nBlueNum	=self.nBlueNum;
			nHX1		=self.nHX1;
			nYeMingZhu	=self.nYeMingZhu;
			nHX2		=self.nHX2;
			nBuyCai		=self.nBuyCai;
			nCaiNum		=self.nCaiNum;
			nFireWait	=self.nFireWait;
			nTQHeXuan	=self.nTQHeXuan
		};

	local szData	= Lib:Val2Str(tbSetting);
	KFile.WriteFile(szUserFilePath1, szData);
end

function tbMPGua:Load(Tu)
	local 	szUserFilePath1

	if Tu == 0 then
		szUserFilePath1	= "\\user\\MPGua_Train\\MPGua\\"..me.szName.."_MPGua.dat";
	else
		szUserFilePath1 = "\\user\\MPGua_Train\\MPGua\\"..me.szName.."_MPGua222.dat";
	end

	local 	szData = KFile.ReadTxtFile(szUserFilePath1);

	if (not szData) then
		return;
	end
	local	tbSetting={};
	local 	tbMyData	= Lib:Str2Val(szData);
	for k, v in pairs(tbMyData) do
		tbSetting[k]	= v;
	end

	if(tbSetting.nMapId) then
		self.nMapId=tbSetting.nMapId;
	end

	if(tbSetting.tbPos) then
		self.tbPos=tbSetting.tbPos;
	end

	if(tbSetting.nRedDrugType) then
		self.nRedDrugType=tbSetting.nRedDrugType;
	end


	if(tbSetting.nBlueDrugType) then
		self.nBlueDrugType=tbSetting.nBlueDrugType;
	end


	if(tbSetting.nRedNum) then
		self.nRedNum=tbSetting.nRedNum;
	end


	if(tbSetting.nBlueNum) then
		self.nBlueNum=tbSetting.nBlueNum;
	end


	if(tbSetting.nHX1) then
		self.nHX1=tbSetting.nHX1;
	end

	if(tbSetting.nTQHeXuan) then
		self.nTQHeXuan=tbSetting.nTQHeXuan;
	end

	if(tbSetting.nYeMingZhu) then
		self.nYeMingZhu=tbSetting.nYeMingZhu;
	end


	if(tbSetting.nHX2) then
		self.nHX2=tbSetting.nHX2;
	end


	if(tbSetting.nBuyCai) then
		self.nBuyCai=tbSetting.nBuyCai;
	end

	if(tbSetting.nCaiNum) then
		self.nCaiNum=tbSetting.nCaiNum;
	end


	if(tbSetting.nFireWait) then
		self.nFireWait=tbSetting.nFireWait;
	end
end

function tbMPGua.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPCOMPOSE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPCOMPOSE);
	end
end

function tbMPGua.StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end	
end

function tbMPGua.TimNPC_TEN(sName)
	local tbNpcList = KNpc.GetAroundNpcList(me,1000);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc and pNpc.szName == sName then
			return pNpc
		end
	end
end
local nLastMapId = 0
local nLastMapX = 0 
local nLastMapY = 0
function tbMPGua.GoTo(M,X,Y)
	tbMPGua.CloseWindows()
	if me.nAutoFightState == 1 then
		tbMPGua.StopAutoFight()
	end
	if me.GetNpc().nIsRideHorse == 0 then
		me.Msg("<color=pink>Tự động lên ngựa")
		Switch("horse")
	end	
	local nMapId,nMyPosX,nMyPosY = me.GetWorldPos()
	if nMapId == M and nMyPosX == X and nMyPosY == Y then
		--me.Msg("Đến rồi chạy chi nữa")
		return
	end
	if nLastMapId ~= M or nLastMapX ~= X or nLastMapY ~= Y then
		me.Msg("<bclr=blue><color=white>Di chuyển")
		nLastMapId = M
		nLastMapX = X
		nLastMapY = Y
	else
		if me.GetNpc().nDoing == 3 then
			return
		end
	end

	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	
	local tbPos = {}
	tbPos.nMapId = M
	tbPos.nX = X
	tbPos.nY = Y
	Ui.tbLogic.tbAutoPath:GotoPos(tbPos)
end

function tbMPGua:ReLoad1()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface2\\MPGua\\MPGua.lua");
	me.Msg("<color=yellow>MPGua reload !!!<color>")
	UiManager:OpenWindow("UI_INFOBOARD", "<color=red>MPGua reload !!!")
end

Ui:RegisterNewUiWindow("UI_TBMPGUA", "MPGua", {"a",320, 222}, {"b",320, 222}, {"c",320, 222}, {"d",320, 222});

local tCmd={"UiManager:SwitchWindow(Ui.UI_TBMPGUA)", "UI_TBMPGUA", "", "Alt+J", "Alt+J", "UI_TBMPGUA"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	
LoadUiGroup(Ui.UI_TBMPGUA, "MPGua.ini");
	