import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Say hello to your English tutors",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)
                ),
                Text(
                  "Become fluent faster through 1 on 1 video lessons tailored to your goals",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "example@email.con",
                    prefixIcon: Icon(Icons.people)
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }}