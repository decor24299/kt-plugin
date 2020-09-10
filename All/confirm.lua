---- tư dong y to doi hoac gd ---
Ui.tbLogic.tbConfirm = {};
local tbConfirm = Ui.tbLogic.tbConfirm;
local tbMsgInfo = Ui.tbLogic.tbMsgInfo;
local tbTempData = Ui.tbLogic.tbTempData;

tbConfirm.MAKE_KEY =
{
	[UiNotify.CONFIRMATION_TEAM_RECEIVE_INVITE]		= { "%s,%d", 1, 2 },
	[UiNotify.CONFIRMATION_TEAM_APPLY_ADD]			= { "%s,%d", 1, 2 },
	[UiNotify.CONFIRMATION_TRADE_RECEIVE_REQUEST]	= { "%s", 1 },			
	[UiNotify.CONFIRMATION_TRADE_SEND_REQUEST]		= { "%s", 1 },		
	[UiNotify.CONFIRMATION_KIN_INVITE_ADD]			= { "%d,%d", 1, 2 },	
	[UiNotify.CONFIRMATION_KIN_INTRODUCE]			= { "%d,%d", 1, 2 },
	[UiNotify.CONFIRMATION_KIN_CONVECTION]			= { "%s", 1 },			
	[UiNotify.CONFIRMATION_TONG_APPLY_JOIN]			= { "%d,%d", 1, 2 },	
	[UiNotify.CONFIRMATION_TONG_INVITE_ADD]			= { "%d,%s,%s", 1, 2,3 },	
	[UiNotify.CONFIRMATION_RELATION_TMPFRIEND]		= { "%s", 1 },			
	[UiNotify.CONFIRMATION_RELATION_BLACKLIST]		= { "" },
	[UiNotify.CONFIRMATION_RELATION_BINDFRIEND]		= { "%s", 1 },			
	[UiNotify.CONFIRMATION_TEACHER_APPLY_TEACHER]	= { "%s", 1 },			
	[UiNotify.CONFIRMATION_TEACHER_APPLY_STUDENT]	= { "%s", 1 },			
	[UiNotify.CONFIRMATION_TEACHER_CONVECTION]		= { "%s", 1 },			
	[UiNotify.CONFIRMATION_COUPLE_CONVECTION]		= { "%s, %s", 1, 2 },		
	[UiNotify.CONFIRMATION_PK_EXERCISE_INVITE]		= { "%s,%d", 1, 2 },	
};

tbConfirm.PROCESS =			
{
	[UiNotify.CONFIRMATION_TEAM_RECEIVE_INVITE]		= "OnTeamReceiveInvite",
	[UiNotify.CONFIRMATION_TEAM_APPLY_ADD]			= "OnTeamApplyAdd",
	[UiNotify.CONFIRMATION_TRADE_RECEIVE_REQUEST]	= "OnTradeReceiveRequest",
	[UiNotify.CONFIRMATION_TRADE_SEND_REQUEST]		= "OnTradeSendRequest",
	[UiNotify.CONFIRMATION_KIN_INVITE_ADD]			= "OnKinInviteAdd",
	[UiNotify.CONFIRMATION_KIN_INTRODUCE]			= "OnKinIntroduce",
	[UiNotify.CONFIRMATION_KIN_CONVECTION]			= "OnKinConvection",
	[UiNotify.CONFIRMATION_TONG_APPLY_JOIN]			= "OnTongApplyJoin",
	[UiNotify.CONFIRMATION_TONG_INVITE_ADD]			= "OnTongInviteAdd",
	[UiNotify.CONFIRMATION_RELATION_TMPFRIEND]		= "OnRelationTmpFriend",
	[UiNotify.CONFIRMATION_RELATION_BLACKLIST]		= "OnRelationBlackList",
	[UiNotify.CONFIRMATION_RELATION_BINDFRIEND]		= "OnRelationBindFriend",
	[UiNotify.CONFIRMATION_TEACHER_APPLY_TEACHER]	= "OnTeacherApplyTeacher",
	[UiNotify.CONFIRMATION_TEACHER_APPLY_STUDENT]	= "OnTeacherApplyStudent",
	[UiNotify.CONFIRMATION_TEACHER_CONVECTION]		= "OnTeacherConvection",
	[UiNotify.CONFIRMATION_COUPLE_CONVECTION]		= "OnCoupleConvection",
	[UiNotify.CONFIRMATION_PK_EXERCISE_INVITE]		= "OnPkExerciseInvite",
};

function tbConfirm:MakeKey(nCfmId, ...)
	local tbInfo = self.MAKE_KEY[nCfmId];
	if (not tbInfo) then
		return "";
	end
	local tbParam = {};
	for i = 2, #tbInfo do
		table.insert(tbParam, arg[tbInfo[i]]);
	end
	return string.format("<<CONFIRM>>::%d$$"..(tbInfo[1] or ""), nCfmId, unpack(tbParam));
end

function tbConfirm:OnConfirm(nCfmId, ...)
	local fnProc = self[self.PROCESS[nCfmId] or ""];
	if (type(fnProc) ~= "function") then
		return;
	end
	local szKey = self:MakeKey(nCfmId, unpack(arg));
	fnProc(self, szKey, unpack(arg));
end

function tbConfirm:OnTeamReceiveInvite(szKey, szPlayer, nPlayerId)
	local tbMsg = {};
	
	if (1 == tbTempData.nDisableTeam) then
		return;
	end
	tbMsg.szMsg = szPlayer.." mời bạn vào nhóm";
	me.TeamReplyInvite(1, nPlayerId, szPlayer);
end

function tbConfirm:OnTeamApplyAdd(szKey, szPlayer, nPlayerId)
	local tbMsg = {};

	if (1 == tbTempData.nDisableTeam) then
		return;
	end	
	tbMsg.szMsg = szPlayer.." xin vào nhóm của bạn";
	me.TeamReplyApply(1, nPlayerId, szPlayer);
end


function tbConfirm:GetTradePlayerNameEx(szTradePlayer)
	local szPlayerEx 	= szTradePlayer;
	local nIsFriend		= Relation:IsFriend(szTradePlayer);
	local nIsTeammate	= Relation:IsTeammate(szTradePlayer);
	local nIsCouple		= Relation:IsCouple(szTradePlayer);
	local nIsBuddy		= Relation:IsBuddy(szTradePlayer);
	local nIsTrain		= Relation:IsTrainRelation(szTradePlayer) ;
	local szColor 		= Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_NEAR];
	local nStranger		= 0;
	
	if (1 == nIsFriend) then
		szColor = Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_FRIEND];
		szPlayerEx = string.format("[Hảo hữu] %s", szPlayerEx);
	elseif(1 == nIsCouple) then
		szColor = Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_FRIEND];
		szPlayerEx = string.format("[Hiệp lữ] %s", szPlayerEx);
	elseif(1 == nIsBuddy) then
		szColor = Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_FRIEND];
		szPlayerEx = string.format("[Mật hữu] %s", szPlayerEx);
	elseif(1 == nIsTrain) then
		szColor = Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_FRIEND];
		szPlayerEx = string.format("[Sư đồ] %s", szPlayerEx);
	elseif(1 == nIsTeammate) then
		szColor = Ui.tbLogic.tbMsgChannel.TB_TEXT_COLOR[Ui.tbLogic.tbMsgChannel.CHANNEL_TEAM];
		szPlayerEx = string.format("[Đồng đội] %s", szPlayerEx);
	else
		nStranger = 1;
	end
	szPlayerEx = string.format("<color=%s>%s<color>", szColor, szPlayerEx);
	return szPlayerEx, nStranger;
end

function tbConfirm:OnTradeReceiveRequest(szKey, szPlayer, bCancel)
	local tbMsg	= {};
	if (1 == tbTempData.nDisableStall) then
		return;
	end
	me.TradeResponse(szPlayer, 1);
end

function tbConfirm:OnTradeSendRequest(szKey, szPlayer)
	local szRequsetKey = self:MakeKey(UiNotify.CONFIRMATION_TRADE_RECEIVE_REQUEST, szPlayer);
	if tbMsgInfo:GetMsg(szRequsetKey) then
		me.TradeResponse(szPlayer, 1);
		tbMsgInfo:DelMsg(szKey);
		return
	end
	
	local szPlayerNameEx = self:GetTradePlayerNameEx(szPlayer);
	
	local tbMsg = {};
	tbMsg.szMsg = "Bạn xin giao dịch với "..szPlayerNameEx..", có thể \"Hủy\".";
	tbMsg.nOptCount = 1;
	tbMsg.tbOptTitle = { "Hủy" };
	function tbMsg:Callback(nOptIndex, szPlayer)
		if (nOptIndex == 1) then
			me.TradeRequest(szPlayer, 1);
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, szPlayer);
end

function tbConfirm:OnKinInviteAdd(szKey, nKinId, nInvitorId, szKinName, szPlayer)
	local tbMsg = {};
	tbMsg.szMsg = szKinName.."Hội trưởng gia tộc "..szPlayer.." mời bạn vào gia tộc";
	function tbMsg:Callback(nOptIndex, nKinId, nInvitorId)
		me.CallServerScript({ "KinCmd", "InviteAddReply", nKinId, nInvitorId, nOptIndex - 1 });
		if (nOptIndex == 2) then
			me.Msg("Chấp nhận!");
		elseif (nOptIndex == 1) then
			me.Msg("Từ chối!");
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, nKinId, nInvitorId);
end

function tbConfirm:OnKinIntroduce(szKey, nKinId, nInvitorId, szKinName, szPlayer)
	local tbMsg = {};
	tbMsg.szMsg = szKinName.."Thành viên gia tộc "..szPlayer.." tiến cử bạn vào gia tộc";
	function tbMsg:Callback(nOptIndex, nKinId, nInvitorId)
		me.CallServerScript({ "KinCmd", "MemberIntroduceConfirm", nKinId, nInvitorId, nOptIndex - 1 });
		if (nOptIndex == 2) then
			me.Msg("Chấp nhận!")
		elseif (nOptIndex == 1) then
			me.Msg("Từ chối!")
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, nKinId, nInvitorId);
end

function tbConfirm:OnKinConvection(szKey, szPlayer, nKind, nMapId, nPosX, nPosY, nMemberPlayerId, nFightState)
	local tbMsg = {};
	tbMsg.nOptCount	= 2;
	tbMsg.tbOptTitle = { "Hủy", "Đồng ý" };
	tbMsg.nTimeout = 60;
	if (nKind == 1) then
		tbMsg.szMsg = string.format("Thành viên gia tộc [<color=yellow>%s<color>] đang gọi bạn, muốn đến đó không?", szPlayer);
	elseif (nKind == 2) then
		tbMsg.szMsg = string.format("Thành viên bang hội [<color=yellow>%s<color>] đang gọi bạn, muốn đến đó không?", szPlayer);
	else
		tbMsg.szMsg = string.format("Hảo hữu [<color=yellow>%s<color>] đang gọi bạn, muốn đến đó không?", szPlayer);
	end
	function tbMsg:Callback(nOptIndex, nMapId, nPosX, nPosY, nMemberPlayerId, nFightState)
		me.CallServerScript({ "ZhaoHuanLingPaiCmd", nMapId, nPosX, nPosY, nMemberPlayerId, nFightState, nOptIndex });
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, nMapId, nPosX, nPosY, nMemberPlayerId, nFightState);	
end

function tbConfirm:OnTongApplyJoin(szKey, nKinId, nMemberId, szKinName, szPlayer)
	local tbMsg = {};
	tbMsg.szMsg = szKinName.."Tộc trưởng "..szPlayer.." xin vào bang";
	function tbMsg:Callback(nOptIndex, nKinId, nMemberId)
		me.CallServerScript({ "TongCmd", "JoinReply", nKinId, nMemberId, nOptIndex - 1 });
		if (nOptIndex == 2) then
			me.Msg("Chấp nhận!");
		elseif (nOptIndex == 1) then
			me.Msg("Từ chối!");
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, nKinId, nMemberId);	
end

function tbConfirm:OnTongInviteAdd(szKey, nPlayerId, szTong, szPlayer)
	local tbMsg = {};
	tbMsg.szMsg = szTong.."Bang chủ "..szPlayer.." mời gia tộc của bạn vào bang "; 
	function tbMsg:Callback(nOptIndex, nPlayerId)
		me.CallServerScript({ "TongCmd", "InviteAddReply", nPlayerId, nOptIndex - 1 });
		if (nOptIndex == 2) then
			me.Msg("Chấp nhận!");
		elseif (nOptIndex == 1) then
			me.Msg("Từ chối!");
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, nPlayerId);
end

function tbConfirm:OnRelationTmpFriend(szKey, szPlayer)
	if (1 == tbTempData.nDisableFriend) then
		return;
	end	
	
	if me.HasRelation(szPlayer, Player.emKPLAYERRELATION_TYPE_BIDFRIEND) == 1 then
		me.Msg("Bạn và "..szPlayer.." trở thành hảo hữu, có thể tổ đội đánh quái để tăng độ thân mật.");
		tbMsgInfo:DelMsg(szKey);
		return;
	end
	local tbMsg		 = {};
	tbMsg.szMsg 	 = szPlayer.." mời bạn làm hảo hữu, đồng ý?<color=yellow>" .. " Độ thân mật tăng sẽ được phần thưởng tương ứng!" ..  "<color>";
	tbMsg.nOptCount  = 2;
	tbMsg.tbOptTitle = { "Không", "Phải" };
	function tbMsg:Callback(nOptIndex, szPlayer)
		if (nOptIndex == 2) then	-- 同意加为好友
			if (me.HasRelation(szPlayer, Player.emKPLAYERRELATION_TYPE_ENEMEY) == 1) then
				me.Msg("Đối phương là kẻ thù, hãy xóa khỏi danh sách kẻ thù rồi mới thêm hảo hữu.");
				return;
			end
			local tbRelationList, tbInfo, nNum = me.Relation_GetRelationList();
			if (nNum and Relation.MAX_NUMBER_FRIEND <= nNum) then
				me.Msg("Số hảo hữu đã đạt tối đa.");
				return;
			end
			me.CallServerScript({"RelationCmd", "AddRelation_C2S", szPlayer, Player.emKPLAYERRELATION_TYPE_TMPFRIEND});
		end
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, szPlayer);
end

function tbConfirm:OnRelationBlackList(szKey, szPlayer)
end

function tbConfirm:OnRelationBindFriend(szKey, szPlayer)
end

function tbConfirm:OnTeacherApplyTeacher(szKey, szPlayer)
	local tbMsg = {};
	tbMsg.nOptCount = 1;
	tbMsg.szMsg = szPlayer.." muốn bái bạn làm sư phụ, nhấn xác nhận xem có phải đệ tử hợp lệ chưa";		
	function tbMsg:Callback(nOptIndex, szPlayer)
		UiManager:OpenWindow(Ui.UI_CHECKTEACHER, { szPlayer, 1 });
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, szPlayer);
end

function tbConfirm:OnTeacherApplyStudent(szKey, szPlayer)
	local tbMsg = {};
	tbMsg.nOptCount = 1;
	tbMsg.szMsg = szPlayer.." muốn nhận bạn làm đồ đệ, nhấn xác nhận xem có phải sư phụ hợp lệ chưa";		
	function tbMsg:Callback(nOptIndex, szPlayer)
		UiManager:OpenWindow(Ui.UI_CHECKTEACHER, { szPlayer, 0 });
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, szPlayer);
end

function tbConfirm:OnTeacherConvection(szKey, szDstPlayer, szAppPlayer)
	local tbMsg = {};
	local szName = szDstPlayer;
	if (szDstPlayer == me.szName) then
		szName = szAppPlayer;
	end
	tbMsg.szMsg = "Bạn hi vọng "..szName.." dùng sư đồ truyền tống đến với bạn?";
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Đồng ý" };
	function tbMsg:Callback(nOptIndex)
		me.CallServerScript({"ShiTuChaunSongCmd", "DstPlayerAccredit", szDstPlayer, szAppPlayer, nOptIndex - 1});
	end
	tbMsgInfo:AddMsg(szKey, tbMsg);
end

function tbConfirm:OnCoupleConvection(szKey, szDstPlayer, szAppPlayer)
	local tbMsg = {};
	local szName = szDstPlayer;
	if (szDstPlayer == me.szName) then
		szName = szAppPlayer;
	end
	tbMsg.szMsg = "Bạn hi vọng "..szName.."Thông qua truyền tống phu thê đến bên bạn?";
	tbMsg.nOptCount = 2;
	tbMsg.tbOptTitle = { "Hủy", "Đồng ý" };
	function tbMsg:Callback(nOptIndex)
		me.CallServerScript({"tbFuQiChuanSongCmd", "DstPlayerAccredit", szDstPlayer, szAppPlayer, nOptIndex - 1});
	end
	tbMsgInfo:AddMsg(szKey, tbMsg);
end

function tbConfirm:OnPkExerciseInvite(szKey, szPlayer, nPlayerId)
	local tbMsg	= {};
	tbMsg.szMsg	= szPlayer.." muốn tỷ thí với bạn";
	tbMsg.nOptCount	= 2;
	tbMsg.tbOptTitle = { "Hủy", "Nhận" };
	function tbMsg:Callback(nOptIndex, szPlayer, nPlayerId)
		me.PkExerciseResponse(nOptIndex - 1, nPlayerId);
	end
	tbMsgInfo:AddMsg(szKey, tbMsg, szPlayer, nPlayerId);
end
