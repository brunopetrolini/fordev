import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

import '../mixins/mixins.dart';

class GetxLoginPresenter extends GetxController
    with LoadingManager, NavigationManager, MainErrorManager, FormManager
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccout;

  String _email;
  String _password;

  var _emailError = RxString();
  var _passwordError = RxString();

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccout,
  });

  Map _fromForm() => {'email': _email, 'password': _password};

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', input: _fromForm());
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', input: _fromForm());
    _validateForm();
  }

  void _validateForm() {
    isFormValid = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  Future<void> auth() async {
    isLoading = true;

    try {
      mainError = null;
      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccout.save(account);
      navigateTo = '/surveys';
    } on DomainError catch (error) {
      mainError = error.description;
      isLoading = false;
    }
  }

  void goToSignUp() {
    navigateTo = '/signup';
  }
}
