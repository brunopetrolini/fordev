import 'package:for_dev/main/factories/cache/cache.dart';

import '../../../domain/usecases/usecases.dart';

import '../../../data/usecases/usecases.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
    fetchSecureCacheStorage: makeSecureStorageAdapter(),
  );
}
