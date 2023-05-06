import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:let_tutor/data_model/setting_model.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/data_model/user_model.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client/client.dart';

void main() async {
  await dotenv.load();
  var user = await _tryLoginWithSavedInfo();
  runApp(LetTutorApp(user: user));
}

Future<User?> _tryLoginWithSavedInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.getString("username");
  final password = prefs.getString("password");

  if (username != null && username.isNotEmpty && password != null && password.isNotEmpty) {
    var user = await Client.login(username, password);
    return user;
  }

  return null;
}

class LetTutorApp extends StatelessWidget {
  final User? user;

  const LetTutorApp({super.key, this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel(user)),
        ChangeNotifierProvider(create: (context) => SettingModel()),
      ],
      child: Consumer<SettingModel>(
        builder: (context, model, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: getTheme(context, model.isDarkMode),
          home: (user != null) ? const BottomTabScreen() : const LoginScreen(),
        ),
      ),
    );
  }

  ThemeData getTheme(BuildContext context, bool isDarkMode) {
    print("get them dark $isDarkMode");

    if (isDarkMode) {
      return ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1,
          bodyColor: Colors.white,
        )
      );
    }

    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: Theme.of(context).textTheme.apply(
        fontSizeFactor: 1.1
      )
    );
  }
}