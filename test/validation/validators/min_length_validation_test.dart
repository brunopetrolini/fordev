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
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 6);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo inválido');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Campo inválido');
  });
}
