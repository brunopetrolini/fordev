import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: snapshot.data == true ? presenter.signUp : null,
          child: const Text('REGISTRAR'),
        );
      },
    );
  }
}
