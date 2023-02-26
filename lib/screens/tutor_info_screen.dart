import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/timetable.dart';
import 'package:let_tutor/widgets/tutor_card.dart';

class TutorInfoScreen extends StatelessWidget {
  const TutorInfoScreen({super.key});

  static const _boldTitleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const _tabLabelStyle = TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Screen(
        child: Column(
          children: [
            const TutorCard(name: "name"),
            const ColoredBox(
              color: Color.fromARGB(223, 59, 174, 255),
              child: TabBar(
                labelPadding: EdgeInsets.all(6),
                labelStyle: _tabLabelStyle,
                indicator: BoxDecoration(color: Colors.blueAccent),
                tabs: [
                  Text("Info"),
                  Text("Schedule"),
                  Text("History")
                ]
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DefaultTextStyle.merge(
                    style: _boldTitleStyle,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text("Languages"),
                        Text("Specialties"),
                        Text("Suggested courses"),
                        Text("Interests"),
                        Text("Experience"),
                      ]
                    ),
                  ),
                  const Timetable(),
                  Column(),
                ]
              ),
            )
          ],
        )
      ),
    );
  }
}