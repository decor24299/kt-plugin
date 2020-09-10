---------------------------====== Sửa Bởi Quốc Huy ======---------------------------
if not MODULE_GAMECLIENT then
	return
end

local self = AutoAi;

function AutoAi:DelMails()
    if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then
        return 1
    end
    if (self.MailItem == 1) or (self.MailMoney == 1) then
        self.MailItem = 0
        self.MailMoney = 0
        UiManager:CloseWindow(Ui.UI_MAILVIEW)
        return 1
    end
    local tbTempTable    = me.GetTempTable("Mail")
    local tbList         = tbTempTable.tbMailList
    for i, tbMail in ipairs(tbList) do
        me.Msg("Mail: <color=yellow>"..tbMail.szCaption.."<color>")-- ("..tbMail.nId..")")
            if UiManager:WindowVisible(Ui.UI_MAILVIEW) ~= 1 then
                Mail:RequireMail(tbMail.nId, tbMail.byClient)
                return 1
            elseif (tbTempTable.tbMailContent.nMailId == tbMail.nId) and (tbTempTable.tbMailContent.nMoney > 0) then
                self.MailMoney = 1
                me.Msg("Lấy tiền: <color=yellow>"..tbTempTable.tbMailContent.nMoney.."<color>")-- ("..tbMail.nId..")")
                me.MailFetchMoney(tbMail.nId)
                return 1
            elseif (tbTempTable.tbMailContent.nMailId == tbMail.nId) and (tbTempTable.tbMailContent.nItemCount > 0) and (me.CountFreeBagCell() > 0) then
                self.MailItem = 1
                me.Msg("Lấy vật phẩm: <color=yellow>"..tbMail.szCaption.."<color>")-- ("..tbMail.nId..")")
                me.CallServerScript({ "MailCmd", "ApplyProcess", tbMail.nId, 0 })
                return 1
            elseif (tbTempTable.tbMailContent.nMailId == tbMail.nId) then
                me.Msg("Xoá thư: <color=yellow>"..tbMail.szCaption.."<color>")-- ("..tbMail.nId..")")
                Ui(Ui.UI_MAIL):DeleteMail(tbMail.nId)
                UiManager:CloseWindow(Ui.UI_MAILVIEW)
                return 1
            end
    end
    return 0
end