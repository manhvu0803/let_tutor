import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/rounded_box.dart';
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
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Languages", style: _boldTitleStyle),
                        RoundedBox.text("English"),
                        const Text("Specialties", style: _boldTitleStyle),
                        const Text("Suggested courses", style: _boldTitleStyle),
                        const Text("Interests", style: _boldTitleStyle),
                        const Text("Experience", style: _boldTitleStyle),
                      ]
                  ),
                  const Timetable(),
                  const Column(),
                ]
              ),
            )
          ],
        )
      ),
    );
  }
}