import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;

  String _email;
  String _name;
  String _password;

  var _emailError = RxString();
  var _nameError = RxString();
  var _passwordError = RxString();
  var _isFormValid = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  Stream<String> get nameErrorStream => _nameError.stream.distinct();
  Stream<String> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({@required this.validation});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: _email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = validation.validate(field: 'name', value: _name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: _password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = false;
  }
}
