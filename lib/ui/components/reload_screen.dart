import 'package:flutter/material.dart';

class ReloadScreen extends StatelessWidget {
  final String error;
  final Future<void> Function() reload;

  ReloadScreen({Key key, @required this.error, @required this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: reload,
            child: Text('Recarregar'),
          ),
        ],
      ),
    );
  }
}
