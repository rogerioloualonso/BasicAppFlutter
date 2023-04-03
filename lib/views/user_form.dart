import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulário de Usuários'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]),
    );
  }
}
