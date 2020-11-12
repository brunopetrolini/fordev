import 'package:for_dev/data/usecases/load_surveys/load_surveys.dart';
import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/main/factories/http/api_url_factory.dart';
import 'package:for_dev/main/factories/http/http_client_factory.dart';

LoadSurveys makeRemoteLoadSurveys() {
  return RemoteLoadSurveys(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('surveys'),
  );
}
