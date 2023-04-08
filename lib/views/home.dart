import 'package:exemplo/routes/app_routes.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 205, 183),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(110),
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(children: <Widget>[
                  Image.network(
                    'https://cdn.pixabay.com/photo/2019/03/08/15/55/map-4042585_960_720.png',
                    height: 250,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Seja Bem-vindo(a)!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.ENDERECO_LIST);
                        },
                        child: Text('Entrar')),
                  )
                ])),
          ),
        ]),
      ),
    );
  }
}
