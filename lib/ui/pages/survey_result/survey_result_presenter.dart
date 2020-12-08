abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<dynamic> get surveysResultStream;

  Future<void> loadData();
}
