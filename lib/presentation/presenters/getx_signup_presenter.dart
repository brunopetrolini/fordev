import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;

  String _email;
  String _password;

  var _emailError = RxString();
  var _isFormValid = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({@required this.validation});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: _email);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = false;
  }
}
