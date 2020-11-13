import '../../../data/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';

import '../../factories/http/http.dart';

LoadSurveys makeRemoteLoadSurveys() {
  return RemoteLoadSurveys(
    httpClient: makeAuthorizeHttpClientDecorator(),
    url: makeApiUrl('surveys'),
  );
}
