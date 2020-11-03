import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfimation;

  List get props => [name, email, password, passwordConfimation];

  AddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfimation,
  });
}
