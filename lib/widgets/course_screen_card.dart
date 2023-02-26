import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/course_card.dart';

import '../screens/course_detail_screen.dart';

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
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseDetailSreen())),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: super.build(context),
      ),
    );
  }
}