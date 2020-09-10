
------------------ tự mở rương MĐT , HGP , NHT --------------
local uiTextInput = Ui(Ui.UI_TEXTINPUT);
local nTimerId = 0;
local nMoDaoTimerId = 0;
local nLastOpenTime = 0;
local nWaitTime = 5; 


function AutoAi:ReclaimXiaoYaoXiang()
	if me.nTeamId == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Bạn chưa tạo nhóm! Ko thể bật điều khiển tổ đội được<color>")
	end
        me.Msg("<color=yellow>Bắt đầu tự cất tất cả các loại rương thuốc");
        local tbYao = me.FindItemInBags(17,8,1,1)[1] or	me.FindItemInBags(17,7,1,1)[1] or me.FindItemInBags(17,6,1,1)[1]
				   or me.FindItemInBags(17,8,1,2)[1] or me.FindItemInBags(17,7,1,2)[1] or me.FindItemInBags(17,6,1,2)[1]
				   or me.FindItemInBags(17,8,1,3)[1] or me.FindItemInBags(17,7,1,3)[1] or me.FindItemInBags(17,6,1,3)[1]
				   or me.FindItemInBags(17,8,3,1)[1] or me.FindItemInBags(17,7,2,1)[1] or me.FindItemInBags(17,6,2,1)[1]
				   or me.FindItemInBags(17,8,3,2)[1] or me.FindItemInBags(17,7,2,2)[1] or me.FindItemInBags(17,6,2,2)[1]
				   or me.FindItemInBags(17,8,3,3)[1] or me.FindItemInBags(17,7,2,3)[1] or me.FindItemInBags(17,6,2,3)[1]
				   or me.FindItemInBags(17,8,2,1)[1] or me.FindItemInBags(17,7,3,1)[1] or me.FindItemInBags(17,6,3,1)[1]
				   or me.FindItemInBags(17,8,2,2)[1] or me.FindItemInBags(17,7,3,2)[1] or me.FindItemInBags(17,6,3,2)[1]
				   or me.FindItemInBags(17,8,2,3)[1] or me.FindItemInBags(17,7,3,3)[1] or me.FindItemInBags(17,6,3,3)[1]
				   or me.FindItemInBags(17,8,1,4)[1] 
				   or me.FindItemInBags(17,8,2,4)[1] 
				   or me.FindItemInBags(17,8,3,4)[1]
				   or me.FindItemInBags(17,13,1,4)[1]
				   or me.FindItemInBags(17,13,3,4)[1]
				   or me.FindItemInBags(17,13,1,3)[1]
				   or me.FindItemInBags(17,13,3,3)[1]
				   or me.FindItemInBags(17,13,1,2)[1]
				   or me.FindItemInBags(17,13,3,2)[1]
				   or me.FindItemInBags(17,13,1,1)[1]
				   or me.FindItemInBags(17,13,3,1)[1]
				   or me.FindItemInBags(17,13,1,5)[1]
				   or me.FindItemInBags(17,13,3,5)[1]
        if tbYao then
                local pItem = tbYao.pItem
                local pBind = pItem.IsBind();
                local szType,szTimeOut = pItem.GetTimeOut();
                local nCount = me.GetItemCountInBags(pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel)
                local tbXiang = me.FindClassItemInBags("xiang")
                for i = 1,#tbXiang do
                        local XiangType,XiangTimeOut = tbXiang[i].pItem.GetTimeOut();
                        local XiangBind = tbXiang[i].pItem.IsBind();
                        if XiangTimeOut then
                                if XiangBind == pBind and szType == XiangType and ( (XiangTimeOut > 0 and math.abs(XiangTimeOut - szTimeOut) <= 60) or szTimeOut == XiangTimeOut) then
                                        local function fnReclaim()
                                                if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
                                                        me.AnswerQestion(1);
                                                        UiManager:CloseWindow(Ui.UI_SAYPANEL);
                                                        return
                                                end
                                                if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
                                                        me.CallServerScript({ "DlgCmd", "InputNum", nCount });
                                                        UiManager:CloseWindow(Ui.UI_TEXTINPUT);
                                                        return 0;
                                                end
                                        end

                                        me.UseItem(tbXiang[i].pItem);
                                        Ui.tbLogic.tbTimer:Register(18,fnReclaim);
                                        return 0;
                                end
                        end
                end
        end
end


