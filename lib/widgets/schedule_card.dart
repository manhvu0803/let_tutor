import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/utils/date_time_extension.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime date;
  final String subtitleText;
  final String username;
  final String countryName;
  final List<Widget> children;
  final String? avatarUrl;
  final String tutorId;

  const ScheduleCard({
    super.key,
    this.username = "",
    this.countryName = "",
    required this.date,
    this.subtitleText = "",
    this.children = const [],
    this.avatarUrl,
    required this.tutorId,
  });

  ScheduleCard.fromSchedule(Schedule schedule, {super.key, this.children = const [], this.subtitleText = ""}) :
    date = schedule.startTime,
    tutorId = schedule.tutor?.id ?? "",
    username = schedule.tutor?.name ?? "",
    countryName = schedule.tutor?.country ?? "",
    avatarUrl = schedule.tutor?.avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text(date.dateString, style: const TextStyle(fontSize: 15)),
                  if (subtitleText.isNotEmpty) Text(subtitleText, style: const TextStyle(fontSize: 14))
                ]
              ),
            ),
            Expanded(
              flex: 6,
              child: UserInfoBox(
                userId: tutorId,
                name: username,
                avatar: (avatarUrl != null) ? Image.network(avatarUrl!).image : null,
                countryName: countryName,
              ),
            )
          ],
        ),
        children: children,
      ),
    );
  }
}