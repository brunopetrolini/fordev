import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../surveys.dart';

import 'survey_item.dart';

class SurveyItems extends StatelessWidget {
  final List<SurveyViewModel> viewModel;

  const SurveyItems(this.viewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          aspectRatio: 1,
        ),
        items: viewModel.map((viewModel) => SurveyItem(viewModel)).toList(),
      ),
    );
  }
}
