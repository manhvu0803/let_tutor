import 'package:flutter/material.dart';

import '../widgets/tutor_card.dart';
import 'screen.dart';

class TutorListScreen extends StatelessWidget {
  const TutorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: ListView(
        children: const [
          TutorCard(
            name: "Somone",
            country: "Viet Nam",
            tags: ["English", "IELTS"],
            introduction: "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends"),
          TutorCard(name: "Somone", country: "Viet Nam", introduction: "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends"),
          TutorCard(name: "Somone", country: "Viet Nam", introduction: "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends")
        ]
      ),
    );
  }
}