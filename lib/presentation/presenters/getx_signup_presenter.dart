import 'package:meta/meta.dart';
import 'package:get/get.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/pages/pages.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter {
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
  var _mainError = RxString();
  var _navigateTo = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  Stream<String> get nameErrorStream => _nameError.stream.distinct();
  Stream<String> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<String> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream.distinct();
  Stream<String> get mainErrorStream => _mainError.stream.distinct();
  Stream<String> get navigateToStream => _navigateTo.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();
  Stream<bool> get isLoadingStream => _isLoading.stream.distinct();

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
    _isLoading.value = true;
    try {
      _mainError.value = null;
      final account = await addAccount.add(AddAccountParams(
        name: _name,
        email: _email,
        password: _password,
        passwordConfimation: _passwordConfirmation,
      ));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  void goToLogin() {
    _navigateTo.value = '/login';
  }
}
