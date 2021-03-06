import 'package:flutter/material.dart';

import '../survey_result.dart';

import 'components.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;

  SurveyResult(this.viewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.answers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(viewModel.question);
        }
        return SurveyAnswer(viewModel.answers[index - 1]);
      },
    );
  }
}
