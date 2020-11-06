import 'package:test/test.dart';
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
    return 'Os valores devem ser iguais';
  }
}

void main() {
  CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate('wrong_value'), 'Os valores devem ser iguais');
  });
}
