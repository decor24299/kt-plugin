local tbAutoAsist	= Map.tbAutoAsist or {};
Map.tbAutoAsist		= tbAutoAsist;
local self = tbAutoAsist
self.nAsistState = 0;		
local tbNoticed ={}
local nBF = 0


local szCmd = [=[
	Map.tbAutoAsist:Asistswitch();
]=];
UiShortcutAlias:AddAlias("GM_C3", szCmd);	--Alt + 3

function tbAutoAsist:Asistswitch()
	if self.nAsistState == 0 then 
		self.nAsistState = 1;
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Bật - Tự buff skill hỗ trợ");
		Ui(Ui.UI_TASKTIPS):Begin("<color=White>Tự buff skill hỗ trợ:<bclr><color=green> Begin");
	else
		self.nAsistState = 0;
		Ui(Ui.UI_TASKTIPS):Begin("<color=White>Tự buff skill hỗ trợ:<bclr><color=red> Stop");
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=white>Tắt - Tự buff skill hỗ trợ");
	end
end


function AutoAi:fnOnMoveState()
	if (Map.tbAutoAsist.nAsistState == 0) then
		return;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;
	end
	local nMyMapId, nMyPosX, nMyPosY	= me.GetWorldPos();
	if nMyMapId < 0 or nMyPosX < 0 then
		return;
	end
	if (me.nFaction == 8 and me.CanCastSkill(850) == 1) or (me.nFaction == 4 and me.CanCastSkill(78) == 1) then
		if (me.nTemplateMapId ==557 and nMyPosY < 3780) or UiManager.bstart == 1 then
			return;
		end
	end

	local nSkillId = self:GetRunSkillId();

	nBF = nBF + 1
	if nBF > 10 then
		nBF = 0
		tbNoticed ={}
	end

	if (nSkillId > 0) then
		if nSkillId == 873 then
			nSkillId = 836
		end
		AutoAi:Pause();	--
		AutoAi.AssistSelf(nSkillId)
		Timer:Register(Env.GAME_FPS * 1.5, AutoAi.DelayResumeAi, AutoAi); 
	end

end

function AutoAi:GetRunSkillId()
	local tbAssistSkill	= {3480, 3481, 3482, 3483, 3484, 3478, 3477, 3475, 3476, 3479, 1209, 839, 167, 497, 115, 132, 177, 230, 180, 838, 697, 26, 46, 55, 161, 783, 191, 835, 219, 850, 840, 836, 78, 854, 2808, 812, 110, 861};
	for _, nSkillId in ipairs(tbAssistSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			if nSkillId == 836 then
				nSkillId = 873
			end
			local ncctime
			if nSkillId == 850 then
				ncctime = Env.GAME_FPS * 60
			elseif nSkillId == 161 or nSkillId == 783 then
				ncctime = Env.GAME_FPS * 40
			else
				ncctime = 45
			end

			if tbNoticed[nSkillId] then
				return 0
			end
			tbNoticed[nSkillId] = 1

			local _, _, nRestTime = me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < ncctime) then			
				return nSkillId;
			end
		end
	end
	return 0;
end

UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_POSITION, AutoAi.fnOnMoveState,AutoAi);