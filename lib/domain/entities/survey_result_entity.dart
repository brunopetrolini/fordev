import 'package:meta/meta.dart';

import 'entities.dart';

class SurveyResultEntity {
  final String surveyId;
  final String question;
  final String didAnswer;
  final List<SurveyAnswerEntity> answers;

  SurveyResultEntity({
    @required this.surveyId,
    @required this.question,
    @required this.didAnswer,
    @required this.answers,
  });
}
