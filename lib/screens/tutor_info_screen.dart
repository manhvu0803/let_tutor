import 'package:flutter/material.dart';

import '../widgets/rounded_box.dart';
import '../widgets/timetable.dart';
import '../widgets/title_text.dart';
import '../widgets/tutor_card.dart';
import 'course_detail_screen.dart';
import 'screen.dart';

class TutorInfoScreen extends StatelessWidget {
  static const _tabLabelStyle = TextStyle(fontSize: 15);

  const TutorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Screen(
        child: Column(
          children: [
            const TutorCard(name: "name", country: "Viet Nam" ),
            const ColoredBox(
              color: Color.fromARGB(223, 59, 174, 255),
              child: TabBar(
                labelPadding: EdgeInsets.all(6),
                labelStyle: _tabLabelStyle,
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
                          RoundedBox.text("English"),
                          const TitleText("Specialties"),
                          Wrap(
                            children: [
                              RoundedBox.text("English for business"),
                              RoundedBox.text("English for conversation"),
                              RoundedBox.text("IELTS"),
                            ]
                          ),
                          const TitleText("Suggested courses"),
                          TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseDetailSreen())),
                            child: const Text("Life in the internet age", style: TextStyle(fontSize: 18))
                          ),
                          const TitleText("Interests"),
                          const Text("I loved the weather, the scenery and the laid-back lifestyle of the locals."),
                          const TitleText("Experience"),
                          const Text("I have more than 10 years of teaching english experience")
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
}