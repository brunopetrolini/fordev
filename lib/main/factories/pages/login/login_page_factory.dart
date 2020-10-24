import 'package:flutter/material.dart';
import 'package:for_dev/data/usecases/remote_authentication.dart';
import 'package:for_dev/infra/http/http_adapter.dart';
import 'package:for_dev/presentation/presenters/presenters.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';
import 'package:for_dev/validation/validators/validation_composite.dart';
import 'package:for_dev/validation/validators/validators.dart';
import 'package:http/http.dart';

import '../../../../ui/pages/pages.dart';

Widget makeLoginPage() {
  final url = 'http://fordevs.herokuapp.com/api/login';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteAuthentication = RemoteAuthentication(
    httpClient: httpAdapter,
    url: url,
  );
  final validationComposite = ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
  final streamLoginPresenter = StreamLoginPresenter(
    authentication: remoteAuthentication,
    validation: validationComposite,
  );

  return LoginPage(streamLoginPresenter);
}
