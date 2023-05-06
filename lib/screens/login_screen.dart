import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/user_model.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/screens/signup_screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/credential_view.dart';
import 'package:provider/provider.dart';

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
      child: ListView(
        children: [
          const SizedBox(height: 200),
          CredentialView(
            onPasswordChanged: (value) => setState(() => _password = value),
            onUsernameChanged: (value) => setState(() => _username = value),
          ),
          const Text("Forgot password?", style: TextStyle(color: Colors.blue)),
          ElevatedButton(
            onPressed: () => _tryLogin(_username, _password),
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
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
            child: const Text("Create an account", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center)
          ),
        ],
      ),
    );
  }

  void _tryLogin(String username, String password, {bool isAuto = false}) async {
    showLoadingDialog(context);

    try {
      var userModel = Provider.of<UserModel>(context, listen: false);
      userModel.user = await Client.login(username, password);

      if (!mounted) {
        return;
      }

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomTabScreen()));
    }
    catch (error, stack) {
      Navigator.of(context, rootNavigator: true).pop();

      if (isAuto) {
        debugPrint(error.toString());
      }
      else {
        showErrorDialog(context, error);
      }

      debugPrint("Stack trace: $stack");
    }
  }
}