import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/credential_view.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _username = "";
  String _password = "";
  String _rePassword = "";

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CredentialView(
            onPasswordChanged: (value) => setState(() => _password = value),
            onUsernameChanged: (value) => setState(() => _username = value),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Re-enter password",
              prefixIcon: Icon(Icons.lock)
            ),
            onChanged: (value) => setState(() => _rePassword = value),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          ElevatedButton(
            onPressed: () => _trySignup(context),
            child: const Text("SIGN UP")
          ),
          const Text("Or sign up with", textAlign: TextAlign.center),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook, size: 48),
              Icon(Icons.g_translate, size: 48)
            ]
          ),
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            child: const Text("Already have an account?", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center)
          ),
        ],
      ),
    );
  }

  void _trySignup(BuildContext context) async {
    if (_password != _rePassword) {
      showErrorDialog(context, "Password doesn't match!");
      return;
    }

    showLoadingDialog(context);

    try {
      await Client.signup(_username, _password);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
      await showAlertDialog(context, title: "Sign up successful!", message: "Please check your email to verify the account");

      if (!mounted) {
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    catch (error, stack) {
      Navigator.of(context).pop();
      showErrorDialog(context, error);
      debugPrint("Stack trace: $stack");
    }
  }
}