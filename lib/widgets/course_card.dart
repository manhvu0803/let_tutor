import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/course.dart';

class CourseCard extends StatelessWidget {
  final Image? image;
  final String? name;
  final String? description;
  final String? level;
  final int? lessonCount;
  final double? width;
  final double? heigth;

  const CourseCard({
    super.key,
    this.image,
    this.name = "",
    this.description = "",
    this.level = "Beginner",
    this.lessonCount = 0,
    this.width,
    this.heigth,
  });

  CourseCard.fromCourse(Course course, {super.key, this.heigth, this.width}) :
    image = Image.network(course.imageUrl),
    name = course.name,
    description = course.description,
    level = course.level.toString(),
    lessonCount = course.topics.length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: (image != null) ? image : null
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(name ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Text(description ?? ""),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("$level • $lessonCount lesson(s)"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}