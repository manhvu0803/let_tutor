import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:let_tutor/widgets/review_scroll_view.dart';
import 'package:let_tutor/widgets/rounded_box.dart';
import 'package:let_tutor/widgets/timetable.dart';
import 'package:let_tutor/widgets/title_text.dart';
import 'package:let_tutor/widgets/tutor_card.dart';

class TutorInfoScreen extends StatelessWidget {
  static const _tabLabelStyle = TextStyle(fontSize: 15);

  final String tutorId;

  const TutorInfoScreen({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => client.getTutor(tutorId),
      buildWidget: (context, tutor) => DefaultTabController(
        length: 2,
        child: Screen(
          child: Column(
            children: [
              TutorCard.fromTutor(
                tutor,
                isTappable: false,
                middle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _IconTextButton(
                      icon: Icons.star_outline,
                      text: "Review",
                      color: Colors.blue,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: SizedBox(
                            height: 600,
                            child: ReviewScrollView(tutorId: tutorId),
                          )
                        )
                      )
                    ),
                    const _IconTextButton(
                      icon: Icons.message_outlined,
                      text: "Message",
                      color: Colors.blue,
                    ),
                    const _IconTextButton(
                      icon: Icons.report_outlined,
                      text: "Report",
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Languages
                            const TitleText("Languages"),
                            Wrap(
                              children: buildList(tutor.languages, (language) => RoundedBox.text(language))
                            ),
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
                    Timetable(tutorId: tutorId)
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

class _IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Function()? onTap;

  const _IconTextButton({required this.icon, required this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            Text(text, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w500))
          ],
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
        MaterialPageRoute(builder: (context) => CourseDetailScreen(courseId: courseId))
      ),
      child: Text(courseName, style: const TextStyle(fontSize: 18))
    );
  }
}