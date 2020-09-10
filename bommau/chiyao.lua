local tbAutoAim	= Map.tbAutoAim or {};
Map.tbAutoAim	= tbAutoAim;

tbAutoAim.DATA_KEY	= "AutoAim";

local self = tbAutoAim
self.nYaoTimer = 0

local tbTimer = Ui.tbLogic.tbTimer;

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

function tbAutoAim:Init()
	self.bYaoDelay 	= 0.3;
	self.life_left 	= 80;              
	self.mana_left 	= 60;              
end

local YAO = {"fulimedicine", "domainmedicine", "songjinmedicine", "localmedicine","medicine", "travelmedicine"};

function tbAutoAim:UpdateYaoCfg(tbAutoYaoCfg)
	self.bYaoDelay 	= tbAutoYaoCfg.nYaoDelay;
	self.life_left 	= tbAutoYaoCfg.nLifeRet;
	self.mana_left 	= tbAutoYaoCfg.nManaRet;
end

function tbAutoAim:FAutoYao()
	if  self.nYaoTimer == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Mở tự uống thuốc");
		me.Msg("Khi cuộc sống < "..string.format("<color=yellow>%d",self.life_left).."%<color> Tự uống máu đỏ");
		me.Msg("<color=blue>Khi nội lực<color> < "..string.format("<color=yellow>%d",self.mana_left).."%<color> <color=blue>Tự uống máu xanh<color>");
		self.nYaoTimer = tbTimer:Register(self.bYaoDelay * Env.GAME_FPS, self.YaoTimer, self);
		Btn_SetTxt(Ui.UI_AUTOAIM, "BtnAutoYao", "Bật");
		Btn_Check(Ui.UI_AUTOAIM,"BtnAutoYao",1);

	else
		UiManager:OpenWindow("UI_INFOBOARD", "<color=red><color><color=pink>Tắt tự uống thuốc<color>");
		Timer:Close(self.nYaoTimer);
		self.nYaoTimer = 0
		Btn_SetTxt(Ui.UI_AUTOAIM, "BtnAutoYao", "Tắt");
		Btn_Check(Ui.UI_AUTOAIM,"BtnAutoYao",0);
	end
end

function tbAutoAim:YaoTimer()
	if (me.nCurLife*100/me.nMaxLife >= self.life_left) and (me.nCurMana*100/me.nMaxMana >= self.mana_left) then
		return;
	end
	for i,szClassName in pairs(YAO) do
		local tbFind = me.FindClassItemInBags(szClassName);
		for j, tbItem in pairs(tbFind) do
			local tbBaseAttrib = tbItem.pItem.GetBaseAttrib();
			for _, tb in ipairs(tbBaseAttrib) do
				if (me.nCurLife*100/me.nMaxLife < self.life_left) and tb.szName == "lifepotion_v" then
					me.UseItem(tbItem.pItem);
					return;
				end
				if (me.nCurMana*100/me.nMaxMana < self.mana_left) and tb.szName == "manapotion_v" then
					me.UseItem(tbItem.pItem);
					return;
				end
			end
		end
	end
end

self:Init();
