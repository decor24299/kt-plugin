-----------------------------------------------------
--文件名		：	playerstate.lua
--创建者		：	耍耍	
--创建时间	：	2011-10-29
------------------------------------------------------

-- PlayerState 面板添加按键
local tbPlayerState = Ui(Ui.UI_PLAYERSTATE);
local BTN_INTERACT		= "BtnInteract";
local IMG_SCHOOLCOURSES		= "ImgSchoolCourses";
local self = tbPlayerState
local tbMenuItem = { "   Rời Đội", "   Buff Tự Động", "   Xả Rác", "   Tự Đánh", "   Sửa Đồ", "   Nhặt Vật Phẩm", "   Nhận Năng Động", "   Mở Mail",  "   Báo Boss", "   Xem Rương"};

function tbPlayerState:OnMenuItemSelected(szWnd, nItemId, nListIndex)
	 if szWnd == IMG_SCHOOLCOURSES or szWnd == BTN_INTERACT then
		if nItemId==1 then
			me.TeamLeave();			--ròi đội
		elseif nItemId==2 then
        		Map.tbAutoAsist:Asistswitch();		--buff hỗ trợ
		elseif nItemId==3 then
        		AutoAi:SwitchAutoThrowAway3();		--xả rác
		elseif nItemId==4 then
        		UiManager:SwitchWindow(Ui.UI_AUTOFIGHT);	--tụ đánh
		elseif nItemId==5 then
        		Map.Toolngt:RepairAll();		--sửa đồ
		elseif nItemId==6 then
        		Map.tbAutoEgg:FastPick()		--nhặt vật phẩm
		elseif nItemId==7 then
        		Map.tbNangDong:State();		--nhận năng động
		elseif nItemId==8 then
        		Ui.tbWnd[Ui.UI_TOOLS2]:SwitchDelMails()					--mở mail
		elseif nItemId==9 then
        		Map.uiDetector:Switch()				--báo boss
		elseif nItemId==10 then
        		UiManager:OpenWindow(Ui.UI_REPOSITORY)		--xem rương khố
		end
	end
end

function tbPlayerState:ShowMenuItem(szWnd, nParam)
	if me.nTeamId > 0 then
		DisplayPopupMenu(self.UIGROUP, szWnd, 10, nParam,
						tbMenuItem[1], 1,
						tbMenuItem[2], 2,
						tbMenuItem[3], 3,
						tbMenuItem[4], 4,
						tbMenuItem[5], 5,
						tbMenuItem[6], 6,
						tbMenuItem[7], 7,
						tbMenuItem[8], 8,
						tbMenuItem[9], 9,
						tbMenuItem[10], 10

					);
	else
		DisplayPopupMenu(self.UIGROUP, szWnd, 9, nParam,
						tbMenuItem[2], 2,
						tbMenuItem[3], 3,
						tbMenuItem[4], 4,
						tbMenuItem[5], 5,
						tbMenuItem[6], 6,
						tbMenuItem[7], 7,
						tbMenuItem[8], 8,
						tbMenuItem[9], 9,
						tbMenuItem[10], 10
					);
	end	
end