import 'package:for_dev/domain/entities/entities.dart';

abstract class LoadSurveyResult {
  Future<SurveyResultEntity> loadBySurvey({String surveyId});
}
