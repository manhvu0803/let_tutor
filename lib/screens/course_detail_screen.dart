import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/course.dart';
import '../widgets/course_scroll_view.dart';
import '../widgets/future_state.dart';
import '../widgets/title_text.dart';
import 'screen.dart';
import 'topic_list_screen.dart';

class CourseDetailSreen extends StatefulWidget {
  final String courseId;

  const CourseDetailSreen({super.key, required this.courseId});

  @override
  State<CourseDetailSreen> createState() => _CourseDetailSreenState();
}

class _CourseDetailSreenState extends FutureState<CourseDetailSreen, Course> {
  @override
  Widget buildOnFuture(BuildContext context, Course course) {
    return Screen(
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
    );
  }

  @override
  fetchData() => Client.getCourse(widget.courseId);
}
