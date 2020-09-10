-- local tbAns_Qes = Ui:GetClass("Ans_Qes");
Ui.UI_ANSWER_QUESTION				= "UI_ANSWER_QUESTION";
local tbAns_Qes			= Ui.tbWnd[Ui.UI_ANSWER_QUESTION] or {};
tbAns_Qes.UIGROUP			= Ui.UI_ANSWER_QUESTION;
Ui.tbWnd[Ui.UI_ANSWER_QUESTION]	= tbAns_Qes
local self			= tbAns_Qes

local CJPath = "\\interface\\";
if UiVersion == 2 then
	CJPath = "\\interface2\\";
end

Ui:RegisterNewUiWindow("UI_ANSWER_QUESTION", "Ans_Ques", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

tbAns_Qes.HoiThoaiCuoiCung = {}
local tbHoiThoai = {
--[[{"Tạp hóa Nham Bắc gì cũng có! Khách quan muốn mua gì?","<color=yellow>[Bạc khóa]<color> Tạp hóa",1},
{"Làm thế nào để đưa trang bị vào thanh tán gẫu?","Ctrl + nhấp chuột trái vào trang bị",1},
{"Phím tắt để thay đổi trang bị là gì?","Ctrl+W",1},
{"Nếu muốn thực hiện các thao tác như: tán gẫu, giao dịch, kiểm tra trang bị với những người chơi khác… thì phải làm gì? ","Ctrl + nhấp chuột phải vào người chơi",0},
{"Phím tắt để mở, đóng bản đồ nhỏ là gì?","Phím Tab",1},
{"Sau khi đưa chuột vào Bản đồ nhỏ, làm cách nào để kéo rê bản đồ?","Nhấp giữ chuột phải và kéo",1},
{"Làm cách nào tự tìm đường trong Bản đồ nhỏ?","Nhấp chuột trái vào điểm đến trên Bản đồ nhỏ",1},
{"Loại quái nào sau đây không làm rơi Lửa trại?","Quái thường",1},
{"Hiệu quả của Lửa trại là gì?","Người chơi trong phạm vi Lửa trại mỗi 5 giây được nhận kinh nghiệm",1},
{"Sau khi đốt lên, Lửa trại sẽ duy trì được bao lâu?","15 phút",1},
{"Uống rượu trong lúc đốt lửa có ích lợi gì?","Nhận được nhiều kinh nghiệm hơn",1},
{"Tổ đội 6 người cùng nhau đốt lửa uống rượu, trường hợp nào sau đây được nhiều kinh nghiệm hơn?","5 người uống Tây Bắc Vọng, 1 người uống Nữ Nhi Hồng",0},
{"Hiệu quả thọ thương là gì?","Không thể thi triển kỹ năng và di chuyển, nhưng có thể uống thuốc",1},
{"Hiệu quả suy nhược là gì?","Giảm lực tấn công",1},
{"Hiệu quả làm chậm là gì?","Làm chậm tốc độ di chuyển và thi triển kỹ năng",1},
{"Hiệu quả bỏng là gì?","Khi bị tấn công thọ thương càng nặng",1},
{"Hiệu quả choáng là gì?","Không thể thi triển kỹ năng và di chuyển, không thể uống thuốc",1},
{"Vật phẩm nào sau đây không được đặt trong thanh trang bị phụ?","Bí kíp",1},
{"Mất bao lâu cho 1 lần thay đổi trang bị?","3 giây",1},
{"Khi đặt vũ khí có trang bị khóa vào thanh trang bị, vũ khí này có bị khóa không?","Phải",1},
{"Những nhân tố nào sau đây không liên quan đến xác suất chính xác?","Sức tấn công của mình",1},
{"Độ chính xác tối đa và tối thiểu là bao nhiêu?","95%, 5%",1},
{"Đòn tấn công chí mạng gấp mấy lần tấn công thường?","1.8 lần",1},
-------------het cau hoi 20----------	
{"Phía trước là Mê Cung Đan Hà, tương truyền rằng phải mở cơ quan theo thứ tự","",1},
{"Xác nhận vào Quán Trọ Long Môn??","Phải, ta muốn vào.",1},
{"Lương Tiếu Tiếu: Lâu lắm rồi ta chưa thấy một tên trộm nào dám mò vào đây,","Được thôi! Đưa ta đi nào!",1},
{"Bạn muốn vào địa đạo này ư?","Phải",1},
{"Tên nhiệm vụ:","Hoàn thành nhiệm vụ, đến nhận thưởng",1},
{" Hiệp khách chân chính trên giang hồ chính là kẻ hào hiệp nhiệt tình giúp đỡ người khác,","Nhận nhiệm vụ hiệp khách",0},
{" Hiệp khách chân chính trên giang hồ chính là kẻ hào hiệp nhiệt tình giúp đỡ người khác,","<color=yellow>Nhận phần thưởng ",1},
{"Nhiệm vụ hiệp khách hôm nay","Đồng ý nhận",1},
{"Nhiệm vụ hiệp khách ngày mai","Kết thúc đối thoại",1},
{"Tên nhiệm vụ:","Hoàn thành nhiệm vụ, đến nhận thưởng",1},
{"Bổ Đầu Hình Bộ: Đội trưởng của bạn","Phải",1},
------------------------------------------------------------
{"<color=yellow>Có Lâu Lan Lệnh sẽ nhận được phần thưởng gấp đôi","Đồng ý",1},
{"Hoàng Thường: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Không muốn làm",1},
{"Yến Tiểu Lâu: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Lâu Lan",1},
{"Từ Tường Nga: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Hành Trình",1},
{"Từ Tường Nga: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Túi Quân Hưởng",1},
{"Lư Tất Khắc: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Chuẩn Bị Chiến Sự",1},
{"Lư Tất Khắc: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Bị Chiến Nhật Thương",1},
{"Người có thể đảm nhận việc lớn","Kết thúc đối thoại",1},
{"Thần Tiêu: Xin chào","Kết thúc đối thoại",1},
{"Thần Tiêu: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Chính tuyến",1},
{"Thần Tiêu: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Hằng ngày",1},
{"Mộ: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Chính tuyến",1},
{"Mộ: Đến thật đúng lúc, ta có nhiệm vụ cho ngươi.","Hằng ngày",1},
{"Phụng mệnh Hoàng đế Đại Lý","Kết thúc đối thoại",1},
{"Ta có thể đưa ngươi đến Phục Ngưu Sơn Quân Doanh","Trở lại",1},
{"Thuyền sửa xong rồi, có thể đi thuyền tiến về Loạn Thạch Than.","Ngồi thuyền tiến về Loạn Thạch Than",1},
{"Đội trưởng Bổn quan có thể đưa các ngươi đi khiêu chiến các khu Tàng Bảo Đồ.","",1},
--------------------------------------------Đối thoại với Lão Bao------------------------
-- {"Hôm nay ngươi liên tục hoàn thành","Ta đang rảnh đây",1},
-------------------------------Môn phái--------------------------------------------------
{"Hiện không có thi đấu môn phái","Ta muốn rời khỏi trận đấu",1},
{"Bạn muốn rời đấu trường môn phái?","Đồng ý",1},
{"Hiện số người báo danh là","Ta muốn rời khỏi trận đấu",1},
{"Thi đấu môn phái đang tiến hành không thể đổi điểm","Kết thúc đối thoại",1},
{"Hiện ngươi không có điểm để đổ","Kết thúc đối thoại",1},
{"Thi đấu môn phái mở báo danh lúc","Chọn",1},
{"Có muốn vào","Vâng",1},
-------------------------------Tu Châu--------------------------------------------------
{"Bạn đã tăng <color=yellow>(","Kết thúc đối thoại",1},
--{"Ghi điểm về thành ở đây?","Phải",1},
{"Dạo này có rất nhiều người muốn đến Tiêu Dao Cốc, ngươi cũng vậy sao?","Đưa ta đến cổng Tiêu Dao Cốc 3",1},
{"Muốn đi đâu thì đi","Báo danh Biện Kinh",1},
{'Đặt vào 10 "Đạo cụ" lấy từ Thợ Đẽo Đá sẽ làm hư, lúc đó thợ cả sẽ ra.',"Cho đạo cụ vào",1},
{"Tính năng tạm chưa mở","Kết thúc đối thoại",1},]]
-------------------------------Even--------------------------------------------------
-- {"Đây là Túi Phúc thứ","Mở tiếp Túi Phúc",1},
--{"Ủy thác rời mạng","",1},
--{"Xin đóng bảo vệ tài khoản sẽ có hiệu lực sau","Kết thúc đối thoại",1},
--{"Trương Trảm Kinh: Đến thật đúng lúc, ta có hoạt động cho ngươi","Ta muốn hỏi chuyện khác",1},
--{"Giếng nước: Đến thật đúng lúc, ta có hoạt động cho ngươi","Lễ hội Đền Hùng",1},
--{"Lễ hội Đền Hùng","Giếng nước nhận Bình nước",1}
{"Nội dung cập nhật lần này","Bỏ qua thông báo online",1},
{"Sẽ nhận được phần thưởng","Xác nhận lãnh",1},
{"Chiến hữu của bạn vẫn đang chiến đấu, nếu họ có thể vượt qua tầng này, ngươi vẫn còn cơ hội cùng họ tiếp tục chiến đấu, hãy ở đây nghỉ ngơi và đón chờ tin vui","Ta biết rồi",1},
{"Có thể chọn nhận Lung Linh Bảo Hạp","Lung Linh Bảo Hạp - Ngân",1},
{"Người Mông Cổ thích kết bạn với người dũng cảm","[Quân doanh]Ngạc Luân Hà Nguyên (Ngày)",1},
{"Lập chiến đội thành công!","Kết thúc đối thoại",1},
{"Số lần mở Túi phúc trong ngày đã hết","Đồng ý",1},
--{"Các bí cảnh đang dần lộ diện, còn bọn Đoạt Bảo Tặc thì ngày càng ngang ngược, chúng ta ai ai cũng đều lo lắng...","Ta muốn rời khỏi đây",1},
{"Có Lâu Lan Lệnh sẽ nhận được phần thưởng gấp đôi","Đồng ý",1},
{"Trước đời nhà Tần, bách gia tranh minh, trong đó có Âm Dương gia am tường thuật ngũ hành bát quái","[Thế giới]Địa cung thần bí",1},
{"Cảnh xưa thoáng hiện nôn nao dạ, người ấy đâu đây thấp thỏm lòng","[Thế giới]Thần Trùng Tích Xưa",1},
{"Đã đạt thành tựu này","Đổi",1},
{"Quan Liên Đấu: Đội của ngươi xếp hạng","Nhận phần thưởng",1},
{"Quan Liên Đấu: Vòng Võ Lâm Liên Đấu này chiến đội của bạn hạng","Ta xác định nhận thưởng",1},
{"Nhận thưởng thành công và rời khỏi chiến đội","Kết thúc đối thoại",1},
{"Ta có thể đưa ngươi rời khỏi Đảo Anh Hùng","Rời khỏi Đại Hội Võ Lâm-Đảo Anh Hùng",1},
{"Trước đời nhà Tần, bách gia tranh minh","[Thế giới]Địa cung thần bí",1},
{"Thời gian bắt đầu:","Đóa Hồng TÌnh Yêu",1},
{"Bạn muốn rời phó bản","Đồng ý rời khỏi",1},
{"Bang hội của ngươi đã nhận được tư cách","Kết thúc đối thoại",1},
{"Lần này đã nộp","Kết thúc đối thoại",1},
{"    Đem 5 loại thảo dược ","Đặt thảo dược vào",1}
}

function tbAns_Qes:ModifyUi()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	tbAns_Qes.Say_bak	= tbAns_Qes.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbAns_Qes.Say_bak(uiSayPanel, tbParam);
		local function fnOnSay()
			tbAns_Qes:OnSay(tbParam);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	tbAns_Qes.EnterGame_bak	= tbAns_Qes.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbAns_Qes.EnterGame_bak(Ui);
		-- tbAns_Qes:Reload();
	end
end


tbAns_Qes.state = 0
local nAnsQes = 0

function UiManager:State()
	tbAns_Qes.state = 1 - tbAns_Qes.state;
	if tbAns_Qes.state == 1 then
		nAnsQes = 1;
		me.Msg("<bclr=yellow><color=black>Mở trả lời !!!")
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=yellow><color=black>Mở tự trả lời<color>");
		-- me.Msg("<color=yellow>Mở <color> Tự trả lời.")
	else
		nAnsQes = 0;
		me.Msg("<bclr=0,0,200><color=White>Tắt tự động !!!")
		--UiManager:OpenWindow("UI_INFOBOARD", "<bclr=0,0,200><color=White>Tắt tự trả lời<color>");
		-- me.Msg("<color=lightgreen>Tắt <color> Tự trả lời.")
	end
end
function UiManager:GetStatetAns_Ques()
	if nAnsQes == 1 then
		return 1;
	else
		return 0;
	end
end

function tbAns_Qes:OnSay(tbParam)	
	-- tbAns_Qes.HoiThoaiCuoiCung = tbParam;	
	-- me.Msg("<color=pink>Go Go Go !!!");
	if tbAns_Qes.state == 0 then		
		return
	end
	
	-- local szData = KIo.ReadTxtFile("\\interface2\\Data\\Param.txt");
	-- local szStr = ""
	-- szStr = szStr..tbParam[1]
	-- for i = 1,table.getn(tbParam[2]) do
		-- szStr = szStr.."\n"..tbParam[2][i]
	-- end		
	-- if not szData then
		-- szData = "thông tin Param \n"
	-- end
	-- KIo.WriteFile("\\interface2\\Data\\Param.txt",szData.."\n"..tbParam[1])
	------------------------------------------------------------------------------------
	for i = 1, table.getn(tbHoiThoai) do					
		if string.find(tbParam[1],tbHoiThoai[i][1]) and tbHoiThoai[i][3] ~= 2 then
			me.Msg("<color=White>HỎI : <color>"..tbParam[1])						
			if tbHoiThoai[i][3] == 1 then				
				for k = 1, table.getn(tbParam[2]) do
					if string.find(tbParam[2][k],tbHoiThoai[i][2]) then
						i=k						
						local function AnswerQestion()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
								me.Msg(tostring("<bclr=0,0,200><color=White>CHỌN : <bclr><color>"..tbParam[2][i]));
								me.AnswerQestion(i-1);
								Ui(Ui.UI_SAYPANEL):OnButtonClick("BtnClose")
								if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then		
									Ui(Ui.UI_GUTAWARD):OnButtonClick("zBtnAccept")
									me.Msg("...")
								end
								self.CloseWindows()
							end								
							return 0;
						end					
						Ui.tbLogic.tbTimer:Register(0.5 * Env.GAME_FPS, AnswerQestion);
						return 0;
					end
				end				
			elseif tbHoiThoai[i][3] == 0 then
				for k = 1, table.getn(tbParam[2]) do
					if string.find(tbParam[2][k],tbHoiThoai[i][2]) then
						i=k						
						local function AnswerQestion()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
								me.Msg(tostring("<bclr=0,0,200><color=White>CHỌN : <bclr><color>"..tbParam[2][i]));
								me.AnswerQestion(i-1);
								self.CloseWindows()
							end			
							return 0;
						end					
						Ui.tbLogic.tbTimer:Register(0.5 * Env.GAME_FPS, AnswerQestion);
						return 0;
					end
				end
			end
		elseif string.find(tbParam[1],tbHoiThoai[i][1]) and tbHoiThoai[i][3] == 2 then
			me.Msg("<color=White>HỎI : <color>"..tbParam[1])
			for k = 1, table.getn(tbParam[2]) do
				if me.nLevel < 60 then
					if string.find(tbParam[2][k],tbHoiThoai[i][2]) then
						i=k						
						local function AnswerQestion()
							if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
								me.Msg(tostring("<bclr=0,0,200><color=White>CHỌN : <bclr><color>"..tbParam[2][i]));
								me.AnswerQestion(i-1);
								self.CloseWindows()
							end			
							return 0;
						end					
						Ui.tbLogic.tbTimer:Register(0.5 * Env.GAME_FPS, AnswerQestion);
						return 0;						
					end
				end
			end
		end
	end	
end

function tbAns_Qes.CloseWindows()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
end

function tbAns_Qes.Start()	
	if tbAns_Qes.state == 0 then
		UiManager:State();
	end
end
--------------------------------------------------------------------------

function tbAns_Qes:Init()
	self:ModifyUi();
	UiManager:State()
end

tbAns_Qes:Init();

function tbAns_Qes:Reload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
		me.Msg("<bclr=255,100,0><color=white>ANSWER MY QUESTION <bclr><color><bclr=pink><color=white> ".. GetLocalDate("%d-%m-%Y %H:%M:%S") .." <bclr><color> RELOAD <bclr=255,100,0><color=white> OK !");
	end
	fnDoScript(CJPath.."ScriptLoader\\AnsQes.lua");
end
me.Msg("<bclr=255,100,0><color=white>ANSWER MY QUESTION <bclr><color><bclr=pink><color=white> ".. GetLocalDate("%d-%m-%Y %H:%M:%S") .." <bclr><color> NẠP <bclr=255,100,0><color=white> XONG !");