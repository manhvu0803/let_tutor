import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/tutor.dart';
import '../widgets/future_state.dart';
import '../widgets/rounded_box.dart';
import '../widgets/timetable.dart';
import '../widgets/title_text.dart';
import '../widgets/tutor_card.dart';
import 'course_detail_screen.dart';
import 'screen.dart';

class TutorInfoScreen extends StatefulWidget {
  static const _tabLabelStyle = TextStyle(fontSize: 15);

  final String tutorId;

  const TutorInfoScreen({super.key, required this.tutorId});

  @override
  State<TutorInfoScreen> createState() => _TutorInfoScreenState();
}

class _TutorInfoScreenState extends FutureState<TutorInfoScreen> {
  @override
  Widget buildOnFuture(BuildContext context, Object data) {
    final tutor = data as Tutor;

    return DefaultTabController(
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
                          const TitleText("Languages"),
                          RoundedBox.text(tutor.languages),
                          const TitleText("Specialties"),
                          Wrap(
                            children: _buildTags(tutor.specialties)
                          ),
                          const TitleText("Suggested courses"),

                          const TitleText("Interests"),
                          _InfoText(tutor.interests),
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
    );
  }

  List<Widget> _buildTags(List<String> tags) {
    final widgets = <Widget>[];

    for (final tag in tags) {
      widgets.add(RoundedBox.text(tag));
    }

    return widgets;
  }

  @override
  Future fetchData() => Client.getTutor(widget.tutorId);
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
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseDetailSreen())),
      child: Text(courseName, style: const TextStyle(fontSize: 18))
    );
  }
}