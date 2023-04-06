import 'package:flutter/material.dart';

import '../data_model/course.dart';
import '../screens/course_detail_screen.dart';
import 'course_card.dart';

class CourseScreenCard extends CourseCard{
  final String courseId;

  const CourseScreenCard({
    super.key,
    super.image,
    super.name = "",
    super.description = "",
    super.level = "Beginner",
    super.lessonCount = 0,
    super.width,
    super.heigth,
    required this.courseId
  });

  CourseScreenCard.fromCourse(Course course, {super.key, super.width, super.heigth}) :
    courseId = course.id,
    super.fromCourse(course);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => CourseDetailScreen(courseId: courseId)
      )),
      child: super.build(context),
    );
  }
}