import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/setting_view.dart';
import 'package:let_tutor/widgets/user_info_view.dart';

const _tabLabelStyle = TextStyle(fontSize: 15);

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ColoredBox(
                color: Color.fromARGB(223, 59, 174, 255),
                child: TabBar(
                  labelPadding: EdgeInsets.all(6),
                  labelStyle: _tabLabelStyle,
                  indicator: BoxDecoration(color: Colors.blueAccent),
                  tabs: [
                    Text("Profile"),
                    Text("Settings")
                  ]
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserInfoView(),
                  SettingView()
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}