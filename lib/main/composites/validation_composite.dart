import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../../validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String validate({@required String field, @required Map input}) {
    String error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);
      if (error?.isNotEmpty == true) return error;
    }
    return error;
  }
}
