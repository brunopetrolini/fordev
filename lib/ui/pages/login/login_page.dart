import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';

import './components/components.dart';
import './login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1(text: 'login'),
                Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(),
                          ),
                          StreamBuilder<bool>(
                              stream: widget.presenter.isFormValidStream,
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  onPressed: snapshot.data == true
                                      ? widget.presenter.auth
                                      : null,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}