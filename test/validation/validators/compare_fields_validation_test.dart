import 'package:test/test.dart';

import 'package:for_dev/validation/validators/validators.dart';

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate('wrong_value'), 'Os valores devem ser iguais');
  });

  test('Should return error if values are equal', () {
    expect(sut.validate('any_value'), null);
  });
}
