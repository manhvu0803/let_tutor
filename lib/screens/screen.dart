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
  final bool useAppBar;
  final String appBarTitle;
  final List<Widget>? appBarActions;

  const Screen({super.key, this.child, this.padding = 10, this.useAppBar = false, this.appBarTitle = "", this.appBarActions});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBar;

    if (useAppBar) {
      appBar = AppBar(
        title: Text(appBarTitle),
        actions: appBarActions,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: child
        ),
      ),
    );
  }
}