import 'package:flutter/material.dart';
import 'package:let_tutor/client.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/course_scroll_view.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:let_tutor/widgets/title_text.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => Client.getCourse(courseId),
      buildWidget: (context, course) => Screen(
        padding: 0,
        child: CourseScrollView(
          courseName: course.name,
          courseDescription: course.description,
          courseImage: Image.network(course.imageUrl),
          children: [
            // Overview
            const TitleText("Overview"),
            const TitleText("Why take this course", fontSize: 20),
            Text(course.reason),
            const TitleText("What will you learn", fontSize: 20),
            Text(course.purpose),
            // Level
            const TitleText("Level"),
            const TitleText("Intermediate", fontSize: 20, fontWeight: FontWeight.w500),
            // Course length
            const TitleText("Course length"),
            TitleText("${course.topics.length} topic(s)", fontSize: 20, fontWeight: FontWeight.w500),
            // Button
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 40, right: 40, bottom: 8),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopicListScreen.fromCourse(course))
                  ),
                  child: const Text("Discover", style: TextStyle(fontSize: 20))
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}