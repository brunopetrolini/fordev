import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../components/components.dart';

=======
>>>>>>> 10ff675c320a8a862486b0f1a50879056a8d3c99
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
<<<<<<< HEAD
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LoginHeader(),
          Text(
            'LOGIN',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      icon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: const Text('ENTRAR'),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    label: const Text('Criar Conta'),
                  )
                ],
              ),
=======
        children: [
          Container(
            child: Image(image: AssetImage('lib/ui/assets/logo.png')),
          ),
          Text('Login'.toUpperCase()),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Entrar'.toUpperCase(),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                  label: Text('Criar Conta'),
                )
              ],
>>>>>>> 10ff675c320a8a862486b0f1a50879056a8d3c99
            ),
          ),
        ],
      ),
    );
  }
}
