import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _name;
  String _password;
  String _passwordConfirmation;

  var _emailError = RxString();
  var _nameError = RxString();
  var _passwordError = RxString();
  var _passwordConfirmationError = RxString();
  var _isFormValid = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  Stream<String> get nameErrorStream => _nameError.stream.distinct();
  Stream<String> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<String> get passwordConfirmationStream =>
      _passwordConfirmationError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();

  GetxSignUpPresenter({
    @required this.validation,
    @required this.addAccount,
    @required this.saveCurrentAccount,
  });

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

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = validation.validate(
        field: 'passwordConfirmation', value: _passwordConfirmation);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _nameError.value == null &&
        _emailError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future<void> signUp() async {
    try {
      final account = await addAccount.add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfimation: _passwordConfirmation,
      ));
      await saveCurrentAccount.save(account);
    } catch (error) {}
  }
}
