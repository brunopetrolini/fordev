import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/validation/protocols/field_validation.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  String validate(String value) {
    return 'Campo inválido';
  }
}

void main() {
  test('Should return error if value is empty', () {
    final sut = MinLengthValidation(field: 'any_field', size: 6);

    final error = sut.validate('');

    expect(error, 'Campo inválido');
  });

  test('Should return error if value is null', () {
    final sut = MinLengthValidation(field: 'any_field', size: 6);

    final error = sut.validate(null);

    expect(error, 'Campo inválido');
  });
}
