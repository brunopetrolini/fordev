import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/pages/pages.dart';

class GetxSurveyResultPresenter extends GetxController
    implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel>();
  final _navigateTo = RxString();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;
  Stream<String> get navigateToStream => _navigateTo.stream;

  GetxSurveyResultPresenter({@required this.loadSurveyResult, this.surveyId});

  Future<void> loadData() async {
    try {
      _isLoading.value = true;

      final surveyResult =
          await loadSurveyResult.loadBySurvey(surveyId: surveyId);

      _surveyResult.value = SurveyResultViewModel(
        surveyId: surveyResult.surveyId,
        question: surveyResult.question,
        answers: surveyResult.answers
            .map((answer) => SurveyAnswerViewModel(
                  image: answer.image,
                  answer: answer.answer,
                  isCurrentAnswer: answer.isCurrentAnswer,
                  percent: '${answer.percent}%',
                ))
            .toList(),
      );
    } on DomainError {
      _surveyResult.subject
          .addError('Algo errado aconteceu. Tente novamente em breve');
    } finally {
      _isLoading.value = false;
    }
  }
}
