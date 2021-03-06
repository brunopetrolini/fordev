import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../mixins/mixins.dart';

import 'components/components.dart';
import 'surveys_presenter.dart';
import 'survey_viewmodel.dart';

class SurveysPage extends StatelessWidget
    with LoadingManager, NavigationManager, SessionManager {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquetes'),
      ),
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        handleSession(presenter.isSessionExpiredStream);
        handleNavigation(presenter.navigateToStream);
        presenter.loadData();

        return StreamBuilder<List<SurveyViewModel>>(
          stream: presenter.surveysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ReloadScreen(
                error: snapshot.error,
                reload: presenter.loadData,
              );
            }

            if (snapshot.hasData) {
              return Provider(
                create: (_) => presenter,
                child: SurveyItems(snapshot.data),
              );
            }

            return Container();
          },
        );
      }),
    );
  }
}
