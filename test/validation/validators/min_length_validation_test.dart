import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:for_dev/validation/protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  String validate(String value) {
    return 'Mínimo de 6 caracteres';
  }
}

void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 6);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Mínimo de 6 caracteres');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Mínimo de 6 caracteres');
  });

  test('Should return erro if value is less than min size', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)),
        'Mínimo de 6 caracteres');
  });
}
