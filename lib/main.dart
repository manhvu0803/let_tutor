import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/user_model.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';

void main() {
  runApp(const LetTutorApp());
}

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1
        )
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: const LoginScreen()
      ),
    );
  }
}