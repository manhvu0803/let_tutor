import 'package:flutter/material.dart';
import 'package:let_tutor/screen.dart';
import 'package:let_tutor/tutor_list_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          const TextField(
            decoration: InputDecoration(
              labelText: "Username",
              hintText: "example@email.con",
              prefixIcon: Icon(Icons.people)
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const Text("Forgot password?", style: TextStyle(color: Colors.blue)),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TutorListScreen())),
            child: const Text("LOGIN")
          ),
          const Text("Or login with", textAlign: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.facebook, size: 48), 
              Icon(Icons.g_translate, size: 48)
            ]
          ),
          const Text(
            "Create an account", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}