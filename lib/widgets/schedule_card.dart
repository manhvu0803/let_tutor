import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

import 'icon_label.dart';

class ScheduleCard extends StatelessWidget {
  static final weekdayString = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  static final monthString = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  final DateTime from;

  final DateTime to;

  final String subtitleText;

  final String username;

  final String countryName;

  const ScheduleCard({
    super.key,
    this.username = "",
    required this.from,
    required this.to,
    this.subtitleText = "",
    this.countryName = ""
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(toDateString(from)),
                Text(subtitleText),
              ]
            ),
          ),
          Expanded(
            child: UserInfoBox(
              name: username,
              countryName: countryName
            ),
          ),
          Expanded(
            child: Text("${toHourString(from)} - ${toHourString(to)}", textAlign: TextAlign.center)
          )
        ],
      )
    );
  }

  static String toDateString(DateTime time) {
    return "${weekdayString[time.weekday]}, ${time.day}-${monthString[time.month]}-${time.year}";
  }

  static String toHourString(DateTime time) {
    return "${time.hour}:${pad1Left(time.minute)}";
  }

  static String pad1Left(Object object) {
    return object.toString().padLeft(2, '0');
  }
}