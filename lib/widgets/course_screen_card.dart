import 'package:flutter/material.dart';

import '../screens/course_detail_screen.dart';
import 'course_card.dart';

class CourseScreenCard extends CourseCard{
  const CourseScreenCard({
    super.key,
    super.image,
    super.name = "",
    super.description = "",
    super.level = "Beginner",
    super.lessonCount = 0,
    super.width,
    super.heigth
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => const CourseDetailSreen(
          courseName: "Life in the Internet Age",
          courseDescription: "Let's discuss how technology is changing the way we live",
        )
      )),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: super.build(context),
      ),
    );
  }
}