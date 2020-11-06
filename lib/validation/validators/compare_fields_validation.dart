import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/validation/protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  final String field;
  final String fieldToCompare;

  List get props => [field, fieldToCompare];

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
