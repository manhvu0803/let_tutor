import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../data_model/user.dart';
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          title: Text("Loading..."),
          content: Center(
            heightFactor: 0.5,
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator()
            ),
          ),
        );
      }
    );

    var response = await http.post(
      url("auth/login"),
      body: {
        "email": _username,
        "password": _password
      }
    );

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
    final json = jsonDecode(response.body);

    if (200 <= response.statusCode && response.statusCode < 300) {
      try {
        Provider.of<UserModel>(context, listen: false).user = User.fromJson(json["user"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomTabScreen()));
      }
      catch (error, stack) {
        _showErrorDialog(context, error.toString());
        print("Stack trace: $stack");
      }
    }
    else {
      _showErrorDialog(context, json["message"].toString());
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "OK"),
              child: const Text("OK"))
          ],
        );
      }
    );
  }
}