import 'package:faker/faker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalStorageAdpater {
  final LocalStorage localStorage;

  LocalStorageAdpater({@required this.localStorage});

  Future<void> save({@required String key, @required dynamic value}) async {
    await localStorage.setItem(key, value);
  }
}

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  test('Should call localStorage with correct values', () async {
    final key = faker.randomGenerator.string(5);
    final value = faker.randomGenerator.string(50);
    final localStorage = LocalStorageSpy();
    final sut = LocalStorageAdpater(localStorage: localStorage);

    await sut.save(key: key, value: value);

    verify(localStorage.setItem(key, value));
  });
}
