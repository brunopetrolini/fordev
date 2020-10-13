import 'package:flutter/material.dart';

import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 240,
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 4,
                    color: Colors.black,
                  ),
                ],
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
              ),
              child: const Image(
                image: AssetImage('lib/ui/assets/logo.png'),
              ),
            ),
            Text(
              'LOGIN',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    StreamBuilder<String>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              icon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              errorText: snapshot.data?.isEmpty == true
                                  ? null
                                  : snapshot.data,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: presenter.validateEmail,
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: StreamBuilder<String>(
                          stream: presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Senha',
                                icon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              obscureText: true,
                              onChanged: presenter.validatePassword,
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                        stream: presenter.isFormValidStream,
                        builder: (context, snapshot) {
                          return RaisedButton(
                            onPressed: snapshot.data == true ? () {} : null,
                            child: const Text('ENTRAR'),
                          );
                        }),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text('Criar Conta'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
