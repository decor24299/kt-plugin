-----------------------------------------------------------
-- 文件名   :   callback.lua
-- 作  者   ：  小虾米
-- 创建时间 ：	2010-02-03
-- 功能描述 ：	答无限福袋用
-----------------------------------------------------------
local szTempQuestion = "";
local tbTempAnswers = {};

function UiCallback:OnQuestionAndAnswer(szQuestion, tbAnswers)
	UiManager:OpenWindow(Ui.UI_SAYPANEL, {szQuestion, tbAnswers});
	szTempQuestion = szQuestion;
	tbTempAnswers = tbAnswers;
end

-- Chức năng: truy cập vào các bảng câu hỏi đối thoại hiện tại và lựa chọn câu trả lời thông tin
function UiCallback:GetQuestionAndAnswer()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
		szTempQuestion = "";
		tbTempAnswers = {};
	end
	return szTempQuestion, tbTempAnswers;
end