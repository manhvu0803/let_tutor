import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../client.dart';
import '../data_model/user_model.dart';
import '../utils.dart';
import 'bottom_tab_screen.dart';
import 'screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Say hello to your English tutors",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)
          ),
          const Text(
            "Become fluent faster through 1 on 1 video lessons tailored to your goals",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "example@email.con",
              prefixIcon: Icon(Icons.email)
            ),
            onChanged: (value) => _username = value,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock)
            ),
            onChanged: (value) => _password = value,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const Text("Forgot password?", style: TextStyle(color: Colors.blue)),
          ElevatedButton(
            onPressed: () => _tryLogin(context),
            child: const Text("LOGIN")
          ),
          const Text("Or login with", textAlign: TextAlign.center),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook, size: 48),
              Icon(Icons.g_translate, size: 48)
            ]
          ),
          const Text("Create an account", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  void _tryLogin(BuildContext context) async {
    showLoadingDialog(context);

    try {
      Provider.of<UserModel>(context, listen: false).user = await Client.login(_username, _password);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomTabScreen()));
    }
    catch (error, stack) {
      Navigator.of(context).pop();
      showErrorDialog(context, error);
      print("Stack trace: $stack");
    }
  }
}