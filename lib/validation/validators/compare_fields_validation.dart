import 'package:meta/meta.dart';

import 'package:for_dev/validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String valueToCompare;

  CompareFieldsValidation({
    @required this.field,
    @required this.valueToCompare,
  });

  @override
  String validate(String value) {
    return value == valueToCompare ? null : 'Os valores devem ser iguais';
  }
}
