import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LoalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LoalLoadSurveys({@required this.fetchCacheStorage});

  Future<void> load() async {
    await fetchCacheStorage.fetch('surveys');
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

void main() {
  LoalLoadSurveys sut;
  FetchCacheStorage fetchCacheStorage;

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LoalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });
}
