import 'package:flutter/material.dart';
import 'package:let_tutor/screens/course_list_screen.dart';
import 'package:let_tutor/screens/history_screen.dart';
import 'package:let_tutor/screens/schedule_screen.dart';
import 'package:let_tutor/screens/tutor_list_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomTabScreen extends StatelessWidget{
  static const _inactiveColor = Colors.grey;

  final PersistentTabController _tabController = PersistentTabController();

  BottomTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      navBarStyle: NavBarStyle.style6,
      controller: _tabController,
      screens: const [
        ScheduleScreen(),
        TutorListScreen(),
        CourseListScreen(),
        HistoryScreen()
      ],
      items: [
        _buildBottomItem("Schedule", Icons.calendar_month),
        _buildBottomItem("Tutors", Icons.person),
        _buildBottomItem("Courses", Icons.article),
        _buildBottomItem("History", Icons.history),
      ],
    );
  }

  static PersistentBottomNavBarItem _buildBottomItem(String title, IconData icon) {
    return PersistentBottomNavBarItem(
      inactiveColorPrimary: _inactiveColor,
      icon: Icon(icon),
      title: title
    );
  }
}