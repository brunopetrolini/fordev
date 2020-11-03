import 'package:flutter/material.dart';

class PasswordConfirmationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Confirmar Senha',
        icon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      obscureText: true,
    );
  }
}