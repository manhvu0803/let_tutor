import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/data_model/tutor_review.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:let_tutor/widgets/schedule_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => client.getHistory(),
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
  final TutorReview? review;

  _HistoryEndCard.fromSchedule(Schedule schedule) :
    studentRequest = schedule.studentRequest,
    review = schedule.classReview;

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
          altTitle: "No request from student",
          content: studentRequest.isNotEmpty ? Text(studentRequest) : null,
        ),
        _ExpansionTextTile(
          title: "Review from tutor",
          altTitle: "No review from tutor",
          content: (review != null) ? _ReviewColumn(review!) : null
        )
      ],
    );
  }
}

class _ExpansionTextTile extends StatelessWidget {
  final String title;
  final Widget? content;
  final String altTitle;

  const _ExpansionTextTile({this.title = "", this.content, this.altTitle = ""});

  @override
  Widget build(BuildContext context) {
    if (content == null) {
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
            child: content
          ),
        )
      ],
    );
  }
}

class _ReviewColumn extends StatelessWidget {
  final TutorReview review;

  const _ReviewColumn(this.review);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Lesson status: ${review.lessonStatus}"),
        _ReviewPointText.fromPoint(review.behaviour, title: "Behaviour"),
        _ReviewPointText.fromPoint(review.speaking, title: "Speaking"),
        _ReviewPointText.fromPoint(review.listening, title: "Listening"),
        _ReviewPointText.fromPoint(review.vocabulary, title: "Vocabulary"),
        Text("Overall: ${review.overallComment}"),
      ],
    );
  }
}

class _ReviewPointText extends StatelessWidget {
  final int rating;
  final String title;
  final String comment;

  _ReviewPointText.fromPoint(ReviewPoint reviewPoint, {required this.title}) :
    rating = reviewPoint.rating,
    comment = reviewPoint.comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title ("),
        ...List.generate(rating, (index) => const Icon(Icons.star, color: Colors.yellow)),
        Text("): $comment")
      ],
    );
  }
}