import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/data/usecases/usecases.dart';

class RemoteLoadSurveyResultWithLocalFallback {
  final RemoteLoadSurveyResult remoteLoadSurveyResult;

  RemoteLoadSurveyResultWithLocalFallback(
      {@required this.remoteLoadSurveyResult});

  Future<void> loadBySurvey({String surveyId}) async {
    await remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId);
  }
}

class RemoteLoadSurveyResultSpy extends Mock implements RemoteLoadSurveyResult {
}

void main() {
  test('Should call remote loadBySurvey', () async {
    final surveyId = faker.guid.guid();
    final remoteLoadSurveyResult = RemoteLoadSurveyResultSpy();
    final sut = RemoteLoadSurveyResultWithLocalFallback(
        remoteLoadSurveyResult: remoteLoadSurveyResult);

    await sut.loadBySurvey(surveyId: surveyId);

    verify(remoteLoadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
  });
}
