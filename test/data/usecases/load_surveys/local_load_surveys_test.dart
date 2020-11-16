import 'package:faker/faker.dart';
import 'package:for_dev/data/models/local_survey_model.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LoalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LoalLoadSurveys({@required this.fetchCacheStorage});

  Future<List<SurveyEntity>> load() async {
    final data = await fetchCacheStorage.fetch('surveys');
    return data
        .map<SurveyEntity>((json) => LocalSurveyModel.fromJson(json).toEntity())
        .toList();
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

void main() {
  LoalLoadSurveys sut;
  FetchCacheStorage fetchCacheStorage;
  List<Map> data;

  List<Map> mockValidData() => [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': '2020-07-20T00:00:00Z',
          'didAnswer': 'false',
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(10),
          'date': '2019-03-10T00:00:00Z',
          'didAnswer': 'true',
        }
      ];

  void mockFetch(List<Map> list) {
    data = mockValidData();
    when(fetchCacheStorage.fetch(any)).thenAnswer((_) async => list);
  }

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LoalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
    mockFetch(mockValidData());
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });

  test('Should return a list of surveys on success', () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveyEntity(
        id: data[0]['id'],
        question: data[0]['question'],
        date: DateTime.utc(2020, 7, 20),
        didAnswer: false,
      ),
      SurveyEntity(
        id: data[1]['id'],
        question: data[1]['question'],
        date: DateTime.utc(2019, 3, 10),
        didAnswer: true,
      ),
    ]);
  });
}
