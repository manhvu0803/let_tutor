import 'package:flutter/material.dart';

class CredentialView extends StatelessWidget {
  final Function(String)? onUsernameChanged;
  final Function(String)? onPasswordChanged;

  const CredentialView({super.key, this.onUsernameChanged, this.onPasswordChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onChanged: onUsernameChanged,
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.lock)
          ),
          onChanged: onPasswordChanged,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
      ]
    );
  }
}