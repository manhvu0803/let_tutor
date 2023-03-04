import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/schedule_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: ListView(
        children: [
          ScheduleCard(
            username: "Same",
            countryName: "Viet Nam",
            date: DateTime(2023, 3, 30, 14),
            subtitleText: "2 lessons",
            children: [
              Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () => print("Rate lesson"),
                              child: const Text("Rate lesson")
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () => print("Report"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text("Report"),
                            ),
                          ),
                        )
                      ],
                    ),
                    const ExpansionTile(
                      title: Text("Request for lesson"),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Expanded(child: Text("The lesson was good"))
                          ),
                        )
                      ],
                    ),
                    const ExpansionTile(
                      title: Text("Review from tutor"),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: Expanded(
                              child: Text("Everything is good")
                            )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}