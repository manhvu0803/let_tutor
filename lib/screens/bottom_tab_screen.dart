import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/setting_model.dart';
import 'package:let_tutor/screens/course_list_screen.dart';
import 'package:let_tutor/screens/history_screen.dart';
import 'package:let_tutor/screens/schedule_screen.dart';
import 'package:let_tutor/screens/tutor_list_screen.dart';
import 'package:let_tutor/screens/user_info_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class BottomTabScreen extends StatefulWidget{
  static const inactiveColor = Colors.grey;

  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  final PersistentTabController _tabController = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingModel>(
      builder: (context, model, child) => PersistentTabView(
        context,
        backgroundColor: model.isDarkMode ? Colors.black : CupertinoColors.white,
        navBarStyle: NavBarStyle.style6,
        controller: _tabController,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
            onPressed: () => PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const ChatScreen()
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder()
            ),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.chat, size: 25),
            )
          ),
        ),
        onItemSelected: (value) => Navigator.of(context).popUntil((route) => route.isFirst),
        screens: const [
          ScheduleScreen(),
          TutorListScreen(),
          CourseListScreen(),
          HistoryScreen(),
          UserInfoScreen()
        ],
        items: [
          _buildBottomItem("Schedule", Icons.calendar_month),
          _buildBottomItem("Tutors", Icons.people_alt),
          _buildBottomItem("Courses", Icons.article),
          _buildBottomItem("History", Icons.history),
          _buildBottomItem("User", Icons.account_circle)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

PersistentBottomNavBarItem _buildBottomItem(String title, IconData icon) {
  return PersistentBottomNavBarItem(
    inactiveColorPrimary: BottomTabScreen.inactiveColor,
    icon: Icon(icon),
    title: title
  );
}