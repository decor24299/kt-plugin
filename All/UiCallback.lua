
local szTempQuestion = "";
local tbTempAnswers = {};

function UiCallback:OnQuestionAndAnswer(szQuestion, tbAnswers)
	UiManager:OpenWindow(Ui.UI_SAYPANEL, {szQuestion, tbAnswers});
	szTempQuestion = szQuestion;
	tbTempAnswers = tbAnswers;
end

function UiCallback:GetQuestionAndAnswer()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 0 then
		szTempQuestion = "";
		tbTempAnswers = {};
	end
	return szTempQuestion, tbTempAnswers;
end