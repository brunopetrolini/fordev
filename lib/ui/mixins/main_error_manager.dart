import 'package:flutter/material.dart';

import '../components/components.dart';

mixin MainErrorManager {
  void handleError(BuildContext context, Stream<String> stream) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error);
      }
    });
  }
}
