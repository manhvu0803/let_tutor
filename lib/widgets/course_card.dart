import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final ImageProvider? image;

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
    this.heigth
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: (image != null) ? Image(image: image!) : null
            ),
            Text(name ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(description ?? ""),
            Text("$level • $lessonCount lesson${((lessonCount ?? 0) > 1) ? "s" : ""}")
          ],
        ),
      ),
    );
  }
}