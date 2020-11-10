import 'package:meta/meta.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final HttpClient<List<Map>> httpClient;
  final String url;

  RemoteLoadSurveys({@required this.httpClient, @required this.url});

  Future<List<SurveyEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response
          .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
