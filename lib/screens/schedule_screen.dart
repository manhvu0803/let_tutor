import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/schedule_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: [
          ScheduleCard(
            username: "Same",
            countryName: "Viet Nam",
            from: DateTime(2023, 3, 30, 14),
            to: DateTime(2023, 3, 30, 14, 30),
            subtitleText: "2 lessons",
          )
        ],
      ),
    );
  }
}