import 'package:flutter/material.dart';
import 'package:let_tutor/screens/course_screen.dart';
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
        CourseScreen()
      ],
      items: [
        PersistentBottomNavBarItem(
          inactiveColorPrimary: _inactiveColor,
          icon: const Icon(Icons.calendar_month),
          title: "Schedule"
        ),
        PersistentBottomNavBarItem(
          inactiveColorPrimary: _inactiveColor,
          icon: const Icon(Icons.person),
          title: "Tutors"
        ),
        PersistentBottomNavBarItem(
          inactiveColorPrimary: _inactiveColor,
          icon: const Icon(Icons.article),
          title: "Courses"
        )
      ],
    );
  }
}