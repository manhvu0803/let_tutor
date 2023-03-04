import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/user_info_box.dart';
import 'package:let_tutor/utils.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime date;

  final String subtitleText;

  final String username;

  final String countryName;

  final List<Widget> children;

  const ScheduleCard({
    super.key,
    this.username = "",
    this.countryName = "",
    required this.date,
    this.subtitleText = "",
    this.children = const <Widget>[]
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(toDateString(date)),
                Text(subtitleText)
              ]
            ),
          ),
          Expanded(
            child: UserInfoBox(
              name: username,
              countryName: countryName
            ),
          )
        ],
      ),
      children: children,
    );
  }
}