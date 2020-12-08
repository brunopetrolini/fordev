import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import 'package:for_dev/ui/pages/pages.dart';

class SurveyResultPresenterSpy extends Mock implements SurveyResultPresenter {}

void main() {
  SurveyResultPresenterSpy presenter;
  StreamController<bool> isLoadingController;
  StreamController<dynamic> surveysResultController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    surveysResultController = StreamController<dynamic>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.surveysResultStream)
        .thenAnswer((_) => surveysResultController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    surveysResultController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SurveyResultPresenterSpy();

    initStreams();
    mockStreams();

    final surveysPage = GetMaterialApp(
      initialRoute: '/surveys_result/any_survey_id',
      getPages: [
        GetPage(
          name: '/surveys_result/:survey_id',
          page: () => SurveyResultPage(presenter),
        ),
      ],
    );
    await provideMockedNetworkImages(() async {
      await tester.pumpWidget(surveysPage);
    });
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadSurveyResult on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(null);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error id surveysStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveysResultController
        .addError('Algo errado aconteceu. Tente novamente em breve.');
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
  });
}
