import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/pages.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel viewModel;

  SurveyItem(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
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
    );
  }
}
