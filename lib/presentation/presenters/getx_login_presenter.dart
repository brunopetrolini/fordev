import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccout;

  String _email;
  String _password;

  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;
  var _navigateTo = RxString();

  Stream<String> get emailErrorStream => _emailError.stream.distinct();
  Stream<String> get passwordErrorStream => _passwordError.stream.distinct();
  Stream<String> get mainErrorStream => _mainError.stream.distinct();
  Stream<bool> get isFormValidStream => _isFormValid.stream.distinct();
  Stream<bool> get isLoadingStream => _isLoading.stream.distinct();
  Stream<String> get navigateToStream => _navigateTo.stream;

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
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  Future<void> auth() async {
    _isLoading.value = true;

    try {
      _mainError.value = null;
      final account = await authentication
          .auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccout.save(account);
      _navigateTo.value = '/surveys';
    } on DomainError catch (error) {
      _mainError.value = error.description;
      _isLoading.value = false;
    }
  }

  void goToSignUp() {
    _navigateTo.value = '/signup';
  }
}
