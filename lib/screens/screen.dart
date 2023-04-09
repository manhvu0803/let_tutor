import 'package:flutter/material.dart';

export "bottom_tab_screen.dart";
export "course_detail_screen.dart";
export "course_list_screen.dart";
export "history_screen.dart";
export "login_screen.dart";
export "meeting_screen.dart";
export "schedule_screen.dart";
export "screen.dart";
export "topic_file_screen.dart";
export "topic_list_screen.dart";
export "tutor_info_screen.dart";
export "tutor_list_screen.dart";

class Screen extends StatelessWidget {
  final Widget? child;
  final double padding;

  const Screen({super.key, this.child, this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: child
        ),
      ),
    );
  }
}