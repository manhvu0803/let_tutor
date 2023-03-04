import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/schedule_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

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
                              onPressed: () => print("Go to meeting"),
                              child: const Text("Go to meeting")
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () => print("Cancel"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text("Cancel"),
                            ),
                          ),
                        )
                      ],
                    ),
                    const ExpansionTile(
                      title: Text("Request for lesson"),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder()
                            ),
                          )
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