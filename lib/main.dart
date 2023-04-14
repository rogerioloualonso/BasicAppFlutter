import 'package:exemplo/provider/enderecosProvider.dart';
import 'package:exemplo/routes/app_routes.dart';
import 'package:exemplo/views/endereco_form.dart';
import 'package:exemplo/views/endereco_list.dart';
import 'package:exemplo/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => EnderecosProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Basic Flutter',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          AppRoutes.HOME: (_) => Home(),
          AppRoutes.ENDERECO_LIST: (_) => EnderecoList(),
          AppRoutes.ENDERECO_FORM: (_) => EnderecoForm(),
        },
      ),
    );
  }
}
