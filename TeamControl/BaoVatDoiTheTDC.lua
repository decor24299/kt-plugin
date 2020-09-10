local BaoVatDoiTheTDC = Ui:GetClass("BaoVatDoiTheTDC")

BaoVatDoiTheTDC.state = 0
local sTimer = 0

local uiSayPanel = Ui(Ui.UI_SAYPANEL)

function BaoVatDoiTheTDC:State()	
	if BaoVatDoiTheTDC.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 2,BaoVatDoiTheTDC.Timers);
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Bật - Đổi thẻ Tiêu Dao<color>");
		Ui(Ui.UI_TASKTIPS):Begin("<color=white>Đổi thẻ Tiêu Dao: <color=green>Begin");
		BaoVatDoiTheTDC.state = 1
	else				
		BaoVatDoiTheTDC.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=white>Tắt - Đổi thẻ Tiêu Dao<color>");
		Ui(Ui.UI_TASKTIPS):Begin("<color=white>Đổi thẻ Tiêu Dao: <color=red>Stop");
		sTimer = 0
		Ui.tbScrCallUi.CloseWinDow()
	end	
end

function BaoVatDoiTheTDC.Check_VatPham()
	if (me.GetItemCountInBags(18,1,315,1) > 0)
	or (me.GetItemCountInBags(18,1,316,1) > 0)
	or (me.GetItemCountInBags(18,1,317,1) > 0)
	or (me.GetItemCountInBags(18,1,334,1) > 0)
	or (me.GetItemCountInBags(18,1,335,1) > 0)
	or (me.GetItemCountInBags(18,1,200,1) > 0)
	or (me.GetItemCountInBags(18,1,201,1) > 0)
	or (me.GetItemCountInBags(18,1,202,1) > 0)
	or (me.GetItemCountInBags(18,1,203,1) > 0)
	or (me.GetItemCountInBags(18,1,204,1) > 0) then
		return true
	else		
		--me.Msg("<color=white>Thông báo:<color> Đã hết vật phẩm trao đổi")
		return false	
	end		
end

function BaoVatDoiTheTDC.Timers()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local szQuestion, tbAnswers = UiCallback:GetQuestionAndAnswer();
	if BaoVatDoiTheTDC.Check_VatPham() then
		local HPTDC = Ui.tbScrCallUi:TimNPC_TEN("Hiểu Phi")
		if HPTDC then
			if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 0 then
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then			
					for i = 1,table.getn(tbAnswers) do
						if string.find(tbAnswers[i],"Bảo vật đổi thẻ") then
							me.Msg(tostring("<color=white>Chọn: <color>"..tbAnswers[i]))
							return Env.GAME_FPS * 1.5, me.AnswerQestion(i-1), Ui.tbScrCallUi:CloseWinDow();
						end					
					end
				else
					return Env.GAME_FPS * 1.5, AutoAi.SetTargetIndex(HPTDC.nIndex)		
				end
			else
				if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
					UiManager:SwitchWindow(Ui.UI_ITEMBOX)
				end
				for j = 315, 317 do
					local nCount = me.GetItemCountInBags(18,1,j,1)
					if me.GetItemCountInBags(18,1,j,1) > 0 then						
						BaoVatDoiTheTDC.DoiVatPham(18,1,j,1,nCount)
						local uiGift = Ui(Ui.UI_ITEMGIFT)
						uiGift.OnButtonClick(uiGift,"BtnOk")
						UiManager:CloseWindow(Ui.UI_ITEMGIFT)
						return 1;
					end
				end
				for j = 334, 335 do
					local nCount = me.GetItemCountInBags(18,1,j,1)
					if me.GetItemCountInBags(18,1,j,1) > 0 then						
						BaoVatDoiTheTDC.DoiVatPham(18,1,j,1,nCount)
						local uiGift = Ui(Ui.UI_ITEMGIFT)
						uiGift.OnButtonClick(uiGift,"BtnOk")
						UiManager:CloseWindow(Ui.UI_ITEMGIFT)
						return 1;
					end
				end
				for j = 200, 204 do
					local nCount = me.GetItemCountInBags(18,1,j,1)
					if me.GetItemCountInBags(18,1,j,1) > 0 then						
						BaoVatDoiTheTDC.DoiVatPham(18,1,j,1,nCount)
						local uiGift = Ui(Ui.UI_ITEMGIFT)
						uiGift.OnButtonClick(uiGift,"BtnOk")
						UiManager:CloseWindow(Ui.UI_ITEMGIFT)
						return 1;
					end
				end
				return
			end			
		else
			local Xnpc,Ynpc = KNpc.ClientGetNpcPos(me.GetMapTemplateId(),3319);
			if Xnpc and Xnpc ~= 0 then
				Ui.tbScrCallUi:StartGoTo(me.GetMapTemplateId(),Xnpc,Ynpc)
			else
				Ui.tbScrCallUi:StartGoTo(342,1614,3217) 
			end
			return
		end
	else
		return Env.GAME_FPS * 1, Ui.tbScrCallUi:CloseWinDow(), BaoVatDoiTheTDC.Stop();
	end	
end


function BaoVatDoiTheTDC.DoiVatPham(nG,nD,nP,nL,count)
	local nSoLuongDaDatVao = 0
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX)
	end
	if UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1 then
		for nCont = 1, 11 do
			for j = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nLine - 1 do
				for i = 0, Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].nRoom, i, j);						
					if pItem then
						if pItem.nGenre == nG and pItem.nDetail == nD and pItem.nParticular == nP and pItem.nLevel == nL then
						local tbObj = Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont].tbObjs[j][i];
								if nSoLuongDaDatVao < count and tbObj ~= nil  then
								if pItem.nCount > count-nSoLuongDaDatVao then
									me.SplitItem(pItem,pItem.nCount - count + nSoLuongDaDatVao)
								end
								Ui(Ui.UI_ITEMBOX).tbBagExCont[nCont]:UseObj(tbObj,i,j)	
								nSoLuongDaDatVao = nSoLuongDaDatVao + pItem.nCount
								if nSoLuongDaDatVao >= count then
									return
								end
							end
						end
					end
				end
			end
		end
	end
end
---------hết-------------

function BaoVatDoiTheTDC.Start()
	if BaoVatDoiTheTDC.state == 0 then		
		BaoVatDoiTheTDC:State()		
	end	
end

function BaoVatDoiTheTDC.Stop()
	if BaoVatDoiTheTDC.state == 1 then		
		BaoVatDoiTheTDC:State()		
	end	
end

Ui:RegisterNewUiWindow("UI_THEBIBAOTDC", "BaoVatDoiTheTDC", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local szCmd = [=[
	Ui(Ui.UI_THEBIBAOTDC):State();
]=];
UiShortcutAlias:AddAlias("GM_C6", szCmd);	
