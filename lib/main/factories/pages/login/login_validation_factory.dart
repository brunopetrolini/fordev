import '../../../../validation/protocols/protocols.dart';

import '../../../../presentation/protocols/validation.dart';

import '../../../composites/composites.dart';
import '../../../builders/builders.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().min(6).build(),
  ];
}
