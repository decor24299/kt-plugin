
local SysMsg_Bak = SysMsg;
function SysMsg(szMsg)
	if (
			string.find(szMsg,"điểm kinh nghiệm")
		or	string.find(szMsg,"Không phải thông báo trang chủ, xin chú ý bảo vệ tài sản.")
		) 
	then
		return;
	else
		SysMsg_Bak(szMsg);
	end
end