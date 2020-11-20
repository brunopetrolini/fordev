import 'package:meta/meta.dart';

import '../../http/http.dart';

class RemoteLoadSurveyResult {
  final HttpClient httpClient;
  final String url;

  RemoteLoadSurveyResult({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> loadBySurvey() async {
    await httpClient.request(url: url, method: 'get');
  }
}
