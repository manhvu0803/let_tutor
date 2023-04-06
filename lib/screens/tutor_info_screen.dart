import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/tutor.dart';
import '../utils.dart';
import '../widgets/future_widget.dart';
import '../widgets/rounded_box.dart';
import '../widgets/timetable.dart';
import '../widgets/title_text.dart';
import '../widgets/tutor_card.dart';
import 'course_detail_screen.dart';
import 'screen.dart';

class TutorInfoScreen extends StatelessWidget {
  static const _tabLabelStyle = TextStyle(fontSize: 15);

  final String tutorId;

  const TutorInfoScreen({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => Client.getTutor(tutorId),
      buildWidget: (context, tutor) => DefaultTabController(
        length: 2,
        child: Screen(
          child: Column(
            children: [
              TutorCard.fromTutor(tutor, isTappableAndTagged: false),
              const ColoredBox(
                color: Color.fromARGB(223, 59, 174, 255),
                child: TabBar(
                  labelPadding: EdgeInsets.all(6),
                  labelStyle: TutorInfoScreen._tabLabelStyle,
                  indicator: BoxDecoration(color: Colors.blueAccent),
                  tabs: [
                    Text("Info"),
                    Text("Schedule")
                  ]
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Languages
                            const TitleText("Languages"),
                            RoundedBox.text(tutor.languages),
                            // Specialties
                            const TitleText("Specialties"),
                            Wrap(
                              children: buildList(tutor.specialties, (tag) => RoundedBox.text(tag))
                            ),
                            // Suggested courses
                            const TitleText("Suggested courses"),
                            ...buildList(tutor.courses, (course) => _CourseButton(courseId: course.id, courseName: course.name)),
                            // Interests
                            const TitleText("Interests"),
                            _InfoText(tutor.interests),
                            // Experience
                            const TitleText("Experience"),
                            _InfoText(tutor.experience)
                          ]
                      ),
                    ),
                    const Timetable()
                  ]
                ),
              )
            ],
          )
        ),
      )
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;

  const _InfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 7),
      child: Text(text),
    );
  }
}

class _CourseButton extends StatelessWidget {
  final String courseId;
  final String courseName;

  const _CourseButton({required this.courseId, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseDetailSreen(courseId: courseId))
      ),
      child: Text(courseName, style: const TextStyle(fontSize: 18))
    );
  }
}