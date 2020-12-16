import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel viewModel;

  SurveyItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SurveysPresenter>(context);

    return GestureDetector(
      onTap: () => presenter.goToSurveyResult(viewModel.id),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: viewModel.didAnswer
              ? Theme.of(context).secondaryHeaderColor
              : Theme.of(context).primaryColorDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              viewModel.question,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
