import 'package:exemplo/provider/users.dart';
import 'package:exemplo/routes/app_routes.dart';
import 'package:exemplo/views/user_form.dart';
import 'package:exemplo/views/user_list.dart';
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
          create: (ctx) => Enderecos(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => EnderecoList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}
