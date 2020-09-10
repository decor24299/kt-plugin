---- lay toa do NPC ----
local self = tbGetIdNpc;
local tbGetIdNpc    = Map.tbGetIdNpc or {};
Map.tbGetIdNpc        = tbGetIdNpc;

local szCmd = [=[
    Map.tbGetIdNpc:GetIdNpc();
]=];
UiShortcutAlias:AddAlias("GM_C1", szCmd);

function tbGetIdNpc:GetIdNpc()
    local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
    me.Msg("Get ID Map<enter><color=green>Mã bản đồ: <color=orange>"..nMyMapId.."<color><enter>Mã tọa độ: <color=orange>"..nMyPosX.." / "..nMyPosY.."<color><enter>Mã màn hình: <color=orange>"..(nMyPosX*32).." / "..(nMyPosY*32));
	local _, x, y	= me.GetWorldPos();
	local nMapId = me.nTemplateMapId
	local szPosTexta	= "";
	local szPosText	= "";
	szPosText	= string.format("<link=pos:%s(%d.%d),%d,%d,%d>",
	GetMapNameFormId(nMapId), x / 8, y / 16, nMapId, x, y);
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 10);
	local nMinLenSquare	= math.huge;
	local pNearNpc		= nil;
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind ~= 1) then
				local _, nNpcX, nNpcY	= pNpc.GetWorldPos();
				local nThisLenSquare	= (nNpcX - x) ^ 2 + (nNpcY - y) ^ 2;
				if (nThisLenSquare < nMinLenSquare) then
					nMinLenSquare	= nThisLenSquare;
					pNearNpc		= pNpc;
				end
			end
		end
	if (not pNearNpc) then
		me.Msg("Get ID NPC<enter><color=green>Không tìm thấy Npc đứng gần");
		return;
	end
	szPosText = string.format("<color=green>Mã NPC: <color=orange>%d - %s", pNearNpc.nTemplateId, pNearNpc.szName);
	me.Msg("Get ID NPC<enter>"..szPosText);
end