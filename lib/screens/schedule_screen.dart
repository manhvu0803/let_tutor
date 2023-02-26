import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/icon_label.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: [
          Card(
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: const [
                      Text("Wed, 15-Mar-2023"),
                      Text("2 lessons"),
                    ]
                  ),
                ),
                const Flexible(
                  child: UserInfoBox(
                    name: "Somone", 
                    lastChild: IconLable(icon: Icons.message, text: "Message")
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}