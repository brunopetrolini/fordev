import 'package:flutter/material.dart';

import '../survey_result.dart';

import 'components.dart';

class SurveyAnswer extends StatelessWidget {
  final SurveyAnswerViewModel answer;
  const SurveyAnswer(this.answer, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildItems() {
      final List<Widget> children = [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              answer.answer,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Text(
          answer.percent,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        answer.isCurrentAnswer ? ActiveIcon() : DisableIcon(),
      ];

      if (answer.image != null) {
        children.insert(0, Image.network(answer.image, width: 40));
      }

      return children;
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildItems()),
        ),
        Divider(height: 1),
      ],
    );
  }
}
