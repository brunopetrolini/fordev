import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';

import 'components/components.dart';
import 'surveys_presenter.dart';
import 'survey_viewmodel.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquetes'),
      ),
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading == true) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });
        presenter.loadData();

        return StreamBuilder<List<SurveyViewModel>>(
          stream: presenter.surveysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: presenter.loadData,
                      child: Text('Recarregar'),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    aspectRatio: 1,
                  ),
                  items: snapshot.data
                      .map((viewModel) => SurveyItem(viewModel))
                      .toList(),
                ),
              );
            }

            return Container();
          },
        );
      }),
    );
  }
}
