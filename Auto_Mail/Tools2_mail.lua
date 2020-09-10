---------------------------====== Sửa Bởi Quốc Huy ======---------------------------
Ui.UI_TOOLS2			= "UI_TOOLS2";
local uiTools2			= Ui.tbWnd[Ui.UI_TOOLS2] or {};	
uiTools2.UIGROUP		= Ui.UI_TOOLS2;
Ui.tbWnd[Ui.UI_TOOLS2] 	= uiTools2
 
local MailSwitch,MailTimer = 0,0

function uiTools2:SwitchDelMails()
    MailSwitch = 1 - MailSwitch;
    if MailSwitch == 1 then
        
        SysMsg("<bclr=0,0,200><color=white>Bắt Đầu Đọc Thư [Ctrl+I]<color><bclr>");
        
        MailTimer = Timer:Register(1.2*Env.GAME_FPS , uiTools2.DelMails ,self)
    else
        
        SysMsg("<bclr=200,0,0><color=white>Dừng Đọc Thư [Ctrl+I]<color><bclr>");
        
        Timer:Close(MailTimer);
        MailTimer = 0;
        UiManager:CloseWindow(Ui.UI_MAIL);
    end
end

function uiTools2:DelMails()
    if (Mail.nMailCount < 1) or (AutoAi:DelMails() == 0) then
        uiTools2:SwitchDelMails()
        return
    else
        return
    end
end
local szCmd = [=[
        Ui.tbWnd[Ui.UI_TOOLS2]:SwitchDelMails()      
    ]=];
UiShortcutAlias:AddAlias("", szCmd);
