local tbBall	= UiManager

local nLevelMax = 3;

local OtherName1 = {"ThiênHuyền","TiểuThiệnNhân","ĐạiĐịaBạoHùng","muonkhocqua","LeungChiuWai","HỏaTìnhLiêm","y0ungkeen","SjêuChuối"};
local OtherName = {"ThiênHuyền"};

function tbBall:Init()
 	Ui.tbLogic.tbTimer:Register(Env.GAME_FPS*5, tbBall.OnUseBall, tbBall);
end

function tbBall:OnUseBall()
	local nMapId,nX,_ = me.GetWorldPos()
	if nMapId <= 0 or nX <= 0 then
		return;
	end
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		return;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	local tbItem = me.FindItemInBags(18,1,1699,1)[1];
	if not tbItem then
		return 0;
	end
	local nState, bActive, nLevel = Item:GetDragonBallState(me);
	if nState >= Item.DRAGONBALL_MAX_STATE_LEVEL * 2 then
		return 0;
	end
	if bActive == 0 then
		return;
	end
	if nLevel <= 3 then
		me.UseItem(tbItem.pItem);
		SendChannelMsg("Team", "Đã hấp thụ Long Ảnh Châu xong!!<pic=82>");
	elseif nLevel == 4 then		
		if me.dwCurMKP < 330 or me.dwCurGTP < 330  then
			return 0
		else
			if me.szName == "ĐạiĐịaBạoHùng" or me.szName == "muonkhocqua" or me.szName == "LeungChiuWai" or me.szName == "TiểuThiệnNhân" or me.szName == "HỏaTìnhLiêm" or me.szName == "y0ungkeen" or me.szName == "SjêuChuối" or me.szName == "ThiênHuyền" then				
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0);
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
					return;
				else
					me.UseItem(tbItem.pItem);
				end
			else
				return 0				
			end
		end
	else
		if me.szName ~= "ThiênHuyền" or me.dwCurMKP < 990 or me.dwCurGTP < 990  then
				return 0;	
		else	
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				me.AnswerQestion(0);
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return;
			else
				me.UseItem(tbItem.pItem);
			end
		end
	end
end

tbBall:Init();

me.Msg("Uimanager<color=green> Reload <color>Long Ảnh Châu OK");
