import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev/main/composites/composites.dart';

import 'package:for_dev/data/usecases/usecases.dart';

import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/entities/entities.dart';

class RemoteLoadSurveyResultSpy extends Mock implements RemoteLoadSurveyResult {
}

class LocalLoadSurveyResultSpy extends Mock implements LocalLoadSurveyResult {}

void main() {
  RemoteLoadSurveyResultWithLocalFallback sut;
  RemoteLoadSurveyResult remote;
  LocalLoadSurveyResult local;
  String surveyId;
  SurveyResultEntity remoteResult;
  SurveyResultEntity localResult;

  PostExpectation mockRemoteLoadCall() =>
      when(remote.loadBySurvey(surveyId: anyNamed('surveyId')));

  SurveyResultEntity mockSurveyResult() => SurveyResultEntity(
          surveyId: faker.guid.guid(),
          question: faker.lorem.sentence(),
          answers: [
            SurveyAnswerEntity(
              answer: faker.lorem.sentence(),
              percent: faker.randomGenerator.integer(100),
              isCurrentAnswer: faker.randomGenerator.boolean(),
            )
          ]);

  void mockRemoteLoad() {
    remoteResult = mockSurveyResult();
    mockRemoteLoadCall().thenAnswer((_) async => remoteResult);
  }

  void mockRemoteLoadError(DomainError error) =>
      mockRemoteLoadCall().thenThrow(error);

  PostExpectation mockLocalLoadCall() =>
      when(local.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockLocalLoad() {
    localResult = mockSurveyResult();
    mockLocalLoadCall().thenAnswer((_) async => localResult);
  }

  void mockLocalLoadError() =>
      mockLocalLoadCall().thenThrow(DomainError.unexpected);

  setUp(() {
    surveyId = faker.guid.guid();
    remote = RemoteLoadSurveyResultSpy();
    local = LocalLoadSurveyResultSpy();
    sut = RemoteLoadSurveyResultWithLocalFallback(remote: remote, local: local);
    mockRemoteLoad();
    mockLocalLoad();
  });

  test('Should call remote loadBySurvey', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(remote.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Shoul call local save with remote data', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(local.save(remoteResult)).called(1);
  });

  test('Should return remote data', () async {
    final response = await sut.loadBySurvey(surveyId: surveyId);

    expect(response, remoteResult);
  });

  test('Should rethrow if remote LoadBySurvey throws AccessDeniedError',
      () async {
    mockRemoteLoadError(DomainError.accessDenied);

    final future = sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local loadBySurvey on remote error', () async {
    mockRemoteLoadError(DomainError.unexpected);

    await sut.loadBySurvey(surveyId: surveyId);

    verify(local.validate(surveyId)).called(1);
    verify(local.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should return local data', () async {
    mockRemoteLoadError(DomainError.unexpected);

    final response = await sut.loadBySurvey(surveyId: surveyId);

    expect(response, localResult);
  });

  test('Should throw UnexpectedError if local load fails', () async {
    mockRemoteLoadError(DomainError.unexpected);
    mockLocalLoadError();

    final future = sut.loadBySurvey(surveyId: surveyId);

    expect(future, throwsA(DomainError.unexpected));
  });
}
