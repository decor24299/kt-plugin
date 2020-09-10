local self = tbGetIdItem;
local tbGetIdItem    = Map.tbGetIdItem or {};
Map.tbGetIdItem        = tbGetIdItem;
local nCount = 0

tbGetIdItem.state = 0
local sTimer = 0

local szCmd = [=[
    Map.tbGetIdItem:State();
]=];
UiShortcutAlias:AddAlias("GM_C4", szCmd);

function tbGetIdItem:State()	
	if tbGetIdItem.state == 0 then	
		sTimer = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 3,18,self.GetIdItem,self);
		me.Msg("<color=lightgreen>Xem<color> <color=yellow> Id - Item trong Hành Trang <color> Bắt đầu");
		tbGetIdItem.state = 1
	else	
		tbGetIdItem.state = 0
		Ui.tbLogic.tbTimer:Close(sTimer);
		me.Msg("<color=lightgreen>Xem<color> <color=white> Id - Item trong Hành Trang <color> Kết thúc");
		sTimer = 0				
	end	
end
-- local strValue = string.format("<color=yellow>ID:%d-%d-%d-%d<color>", it.nGenre,it.nDetail,it.nParticular,it.nLevel);
function tbGetIdItem:GetIdItem()
	if (tbGetIdItem.state == 0) then
		return
	end
	-- g,d,p,l
	for k = 17,18 do
		if k then
			for i = 1,21366 do
				if i then
					for j = 1,10 do	
						if j then
							local count = me.GetItemCountInBags(k,1,i,j)		
							if count > 0 then
								local tbFind = me.FindItemInBags(k,1,i,j);
								for _, tbItem in pairs(tbFind) do						
									me.Msg("<color=yellow>Có <color>"..count.."<color=yellow> - <color>"..KItem.GetNameById(18,1,i,j).."<color=yellow> - <color><color=white> ( "..k..",1,"..i..","..j.." )");			
								end
							end
							j = j + 1
						end		
					end		
					i = i + 1
				end
			-- k = k + 1
			end	
		end
	end
	return tbGetIdItem:State()	 
end
