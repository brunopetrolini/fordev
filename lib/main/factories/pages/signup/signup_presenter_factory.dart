import '../../../../presentation/presenters/presenters.dart';

import '../../../../ui/pages/pages.dart';

import '../../../factories/factories.dart';

SignUpPresenter makeGetxSignUpPresenter() {
  return GetxSignUpPresenter(
    addAccount: makeAddAccount(),
    validation: makeSignUpValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
