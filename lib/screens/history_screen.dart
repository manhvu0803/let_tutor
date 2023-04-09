import 'package:flutter/material.dart';
import 'package:let_tutor/client.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:let_tutor/widgets/schedule_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => Client.getHistory(),
      buildWidget: (context, scheduleList) => Screen(
        child: ListView(
          children: buildList(
            scheduleList,
            (schedule) => ScheduleCard.fromSchedule(
              schedule,
              subtitleText: "${schedule.startTime.hourString}-${schedule.endTime.hourString}",
              children: [_HistoryEndCard.fromSchedule(schedule)]
            )
          )
        )
      )
    );
  }
}

class _HistoryEndCard extends StatelessWidget {
  final String studentRequest;
  final String tutorReview;

  _HistoryEndCard.fromSchedule(Schedule schedule) :
    studentRequest = schedule.studentRequest,
    tutorReview = schedule.tutorReview;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => debugPrint("Rate lesson"),
                  child: const Text("Rate lesson")
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => debugPrint("Report"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Report"),
                ),
              ),
            )
          ],
        ),
        _ExpansionTextTile(
          title: "Request for lesson",
          content: studentRequest,
          altTitle: "No request from student"
        ),
        _ExpansionTextTile(
          title: "Review from tutor",
          content: tutorReview,
          altTitle: "No review from tutor"
        )
      ],
    );
  }
}

class _ExpansionTextTile extends StatelessWidget {
  final String title;
  final String content;
  final String altTitle;

  const _ExpansionTextTile({this.title = "", this.content = "", this.altTitle = ""});

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 15),
            child: Text(altTitle, style: const TextStyle(fontSize: 17))
          ),
        );
    }

    return ExpansionTile(
      title: Text(title),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(content)
          ),
        )
      ],
    );
  }
}