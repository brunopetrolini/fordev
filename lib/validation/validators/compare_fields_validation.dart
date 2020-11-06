import 'package:meta/meta.dart';

import 'package:for_dev/validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation({
    @required this.field,
    @required this.fieldToCompare,
  });

  @override
  String validate(Map input) => input[field] != null &&
          input[fieldToCompare] != null &&
          input[field] != input[fieldToCompare]
      ? 'Campo inválido'
      : null;
}
