----------------------------
--HPNS
----------------------------
local VuotRaoHS = Ui.VuotRaoHS or {};
Ui.VuotRaoHS = VuotRaoHS;

local szCmd = [=[
	Ui.VuotRaoHS:JumpSwitch();
]=];
-- UiShortcutAlias:AddAlias("GM_S1", szCmd);

function VuotRaoHS:JumpSwitch()
	if (me.GetMapTemplateId()  < 65500) then
		me.Msg("<bclr=blue><color=white>Vượt rào Hậu Sơn Phục Ngưu！")
		me.Msg("<bclr=blue><color=white>Chức năng này chỉ hoạt động trong Hậu Sơn Phục Ngưu！")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Chức năng này chỉ hoạt động trong Hậu Sơn Phục Ngưu！<color>");
		return;
	end
	if (self.Houshan_TimerId and self.Houshan_TimerId > 0) then
		me.Msg("<bclr=blue><color=white>Ngừng tự động vượt rào ở Hậu Sơn Phục Ngưu！")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Ngừng tự động vượt rào ở Hậu Sơn Phục Ngưu！<color>");
		Timer:Close(self.Houshan_TimerId);
		self.Houshan_TimerId = 0;
		return;
	end
	local nUiMode = GetUiMode();
	local px = 0
	local py = 0
		if nUiMode == "b" then
			px = 112;			
			py = 84;			
		elseif nUiMode == "c" then
			px = 240;			
			py = 100;			
		end
	local nRunNum = 1;
	local tbRunPos = {
		[1] = {PosX = 54379, PosY = 111156, PType = 1, DisX = 0, DisY = 0,},
		[2] = {PosX = 54696, PosY = 110835, PType = 2, DisX = 733 + px, DisY = 146 + py,},
		[3] = {PosX = 54657, PosY = 110380, PType = 2, DisX = 363 + px, DisY = 98 + py,},
		[4] = {PosX = 54348, PosY = 110414, PType = 2, DisX = 77 + px, DisY = 288 + py,},
		[5] = {PosX = 53967, PosY = 110268, PType = 2, DisX = 13 + px, DisY = 254 + py,},
		[6] = {PosX = 53874, PosY = 109803, PType = 2, DisX = 304 + px, DisY = 62 + py,},
		[7] = {PosX = 53763, PosY = 109408, PType = 2, DisX = 304 + px, DisY = 60 + py,},
		[8] = {PosX = 53866, PosY = 108896, PType = 2, DisX = 509 + px, DisY = 60 + py,},
		[9] = {PosX = 53582, PosY = 108598, PType = 2, DisX = 144 + px, DisY = 130 + py,},
		[10] = {PosX = 53536, PosY = 108096, PType = 2, DisX = 320 + px, DisY = 74 + py,},
		[11] = {PosX = 53610, PosY = 107539, PType = 2, DisX = 463 + px, DisY = 39 + py,},
		[12] = {PosX = 53972, PosY = 107030, PType = 2, DisX = 767 + px, DisY = 73 + py,},
		[13] = {PosX = 54880, PosY = 104704, PType = 1, DisX =0, DisY = 0,},
	};

	local function fnAutoQingGong()
		local x,y,world = me.GetNpc().GetMpsPos();
		local nMyPosX   = math.floor(x/32);
		local nMyPosY   = math.floor(y/32);
		local nNextPosX = math.floor(tbRunPos[nRunNum].PosX/32);
		local nNextPosY = math.floor(tbRunPos[nRunNum].PosY/32);
		local nNextType = tbRunPos[nRunNum].PType;
		local nDisX 	= tbRunPos[nRunNum].DisX;
		local nDisY 	= tbRunPos[nRunNum].DisY;
		local nEndPosX  = math.floor(tbRunPos[13].PosX/32);
		local nEndPosY  = math.floor(tbRunPos[13].PosY/32);
		if (nMyPosX == nEndPosX and nMyPosY == nEndPosY) then
			if (nRunNum >= 13) then
				me.Msg("<bclr=red><color=white>Vượt rào Hậu Sơn hoàn thành !");
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=white>Vượt rào Hậu Sơn hoàn thành !<color>");
				Timer:Close(self.Houshan_TimerId);
				self.Houshan_TimerId = 0;
				return;
			end
		else
			me.Msg(nNextType.." "..nMyPosX.." "..nMyPosY.." "..nNextPosX.." "..nNextPosY)
			if (nNextType == 1) then
				if (me.GetNpc().nIsRideHorse ~= 1) then
					Switch("horse");
				end
	        		if (nMyPosX == nNextPosX and nMyPosY == nNextPosY) then
					me.Msg("1"..nNextPosX.." "..nNextPosY)
		        		nRunNum = nRunNum + 1;
				else
					me.AddSkillEffect(Player.HEAD_STATE_AUTOPATH);
					me.AutoPath(nNextPosX, nNextPosY);
				end
			elseif (nNextType == 2) then      
				if (me.GetNpc().nIsRideHorse == 1) then
					Switch("horse");
				end
				if ((math.abs(nMyPosX - nNextPosX) > 3) or (math.abs(nMyPosY - nNextPosY) > 3)) then
					nRunNum = nRunNum - 1;
					nRunNum = nRunNum + 1;
					UseSkill(10, nDisX, nDisY);
					nRunNum = nRunNum - 1;
					nRunNum = nRunNum + 1;
					return;
				else
					nRunNum = nRunNum - 1;
					nRunNum = nRunNum + 2;
				end
			end
		end
	end

	me.Msg("<bclr=red><color=yellow>Bắt đầu vượt rào Hậu Sơn...<color>")
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=yellow>Bắt đầu vượt rào Hậu Sơn...<color>");
	self.Houshan_TimerId = Timer:Register(Env.GAME_FPS * 2, fnAutoQingGong, self);
end