import '../../../data/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

AddAccount makeAddAccount() {
  return RemoteAddAccount(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('signup'),
  );
}
