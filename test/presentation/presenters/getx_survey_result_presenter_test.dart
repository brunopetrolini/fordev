import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

import 'package:for_dev/ui/pages/pages.dart';

class GetxSurveyResultPresenter extends GetxController
    implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;

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

class LoadSurveyResultSpy extends Mock implements LoadSurveyResult {}

void main() {
  GetxSurveyResultPresenter sut;
  LoadSurveyResult loadSurveyResult;
  SurveyResultEntity surveyResult;
  String surveyId;

  SurveyResultEntity mockValidData() => SurveyResultEntity(
          surveyId: faker.guid.guid(),
          question: faker.lorem.sentence(),
          answers: [
            SurveyAnswerEntity(
                image: faker.internet.httpUrl(),
                answer: faker.lorem.sentence(),
                percent: faker.randomGenerator.integer(100),
                isCurrentAnswer: faker.randomGenerator.boolean()),
            SurveyAnswerEntity(
                answer: faker.lorem.sentence(),
                percent: faker.randomGenerator.integer(100),
                isCurrentAnswer: faker.randomGenerator.boolean()),
          ]);

  PostExpectation mockLoadSurveyResultCall() =>
      when(loadSurveyResult.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockLoadSurveyResult(SurveyResultEntity data) {
    surveyResult = data;
    mockLoadSurveyResultCall().thenAnswer((_) async => surveyResult);
  }

  void mockLoadSurveyResultError() =>
      mockLoadSurveyResultCall().thenThrow(DomainError.unexpected);

  setUp(() {
    surveyId = faker.guid.guid();
    loadSurveyResult = LoadSurveyResultSpy();
    sut = GetxSurveyResultPresenter(
      loadSurveyResult: loadSurveyResult,
      surveyId: surveyId,
    );
    mockLoadSurveyResult(mockValidData());
  });

  test('Should call LoadSurveyResult on loadData', () async {
    await sut.loadData();

    verify(loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.surveyResultStream.listen(expectAsync1((result) => expect(
          result,
          SurveyResultViewModel(
            surveyId: surveyResult.surveyId,
            question: surveyResult.question,
            answers: [
              SurveyAnswerViewModel(
                image: surveyResult.answers[0].image,
                answer: surveyResult.answers[0].answer,
                isCurrentAnswer: surveyResult.answers[0].isCurrentAnswer,
                percent: '${surveyResult.answers[0].percent}%',
              ),
              SurveyAnswerViewModel(
                answer: surveyResult.answers[1].answer,
                isCurrentAnswer: surveyResult.answers[1].isCurrentAnswer,
                percent: '${surveyResult.answers[1].percent}%',
              ),
            ],
          ),
        )));

    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadSurveyResultError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveyResultStream.listen(
      null,
      onError: expectAsync1(
        (error) =>
            expect(error, 'Algo errado aconteceu. Tente novamente em breve'),
      ),
    );

    await sut.loadData();
  });
}
