import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/pages/pages.dart';

import '../protocols/protocols.dart';
import '../mixins/mixins.dart';

class GetxSignUpPresenter extends GetxController
    with LoadingManager, NavigationManager, MainErrorManager, FormManager
    implements SignUpPresenter {
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

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get nameErrorStream => _nameError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  GetxSignUpPresenter({
    @required this.validation,
    @required this.addAccount,
    @required this.saveCurrentAccount,
  });

  Map _fromForm() => {
        'name': _name,
        'email': _email,
        'password': _password,
        'passwordConfirmation': _passwordConfirmation
      };

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', input: _fromForm());
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = validation.validate(field: 'name', input: _fromForm());
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', input: _fromForm());
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value =
        validation.validate(field: 'passwordConfirmation', input: _fromForm());
    _validateForm();
  }

  void _validateForm() {
    isFormValid = _nameError.value == null &&
        _emailError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future<void> signUp() async {
    isLoading = true;
    try {
      mainError = null;
      final account = await addAccount.add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfimation: _passwordConfirmation,
      ));
      await saveCurrentAccount.save(account);
      navigateTo = '/surveys';
    } on DomainError catch (error) {
      mainError = error.description;
      isLoading = false;
    }
  }

  void goToLogin() {
    navigateTo = '/login';
  }
}
