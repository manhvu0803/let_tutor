import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/setting_model.dart';
import 'package:let_tutor/data_model/user_model.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      child: Consumer<SettingModel>(
        builder: (context, model, child) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwitchListTile(
                value: model.isDarkMode,
                onChanged: (value) => model.isDarkMode = value,
                title: const Text("Dark mode", style: TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text("Languague", style: TextStyle(fontSize: 20)),
                trailing: DropdownButton(
                  value: "VI",
                  onChanged: (value) => setState(() {}),
                  items: const [
                    DropdownMenuItem(
                      value: "VI",
                      child: Text("Vietnamese"),
                    ),
                    DropdownMenuItem(
                      value: "EN",
                      child: Text("English"),
                    )
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed:() {
                  Client.logout();
                  Navigator.popUntil(context, (route) => true);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const LoginScreen(),
                    withNavBar: false
                  );
                },
                child: const Text("Logout")
              ),
            )
          ],
        ),
      ),
    );
  }
}