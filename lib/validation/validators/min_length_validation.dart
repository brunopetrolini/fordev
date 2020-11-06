import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;

  List get props => [field, size];

  MinLengthValidation({@required this.field, @required this.size});

  String validate(String value) {
    return value != null && value.length >= size
        ? null
        : 'Mínimo de 6 caracteres';
  }
}
