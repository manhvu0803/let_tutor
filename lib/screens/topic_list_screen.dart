import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/course.dart';
import 'package:let_tutor/data_model/topic.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/course_scroll_view.dart';
import 'package:let_tutor/widgets/title_text.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TopicListScreen extends StatelessWidget {
  final String courseName;
  final String courseDescription;
  final Image? courseImage;
  final List<Topic> topics;

  const TopicListScreen({
    super.key,
    this.topics = const [],
    this.courseName = "",
    this.courseDescription = "",
    this.courseImage
  });

  TopicListScreen.fromCourse(Course course, {super.key}) :
    topics = course.topics,
    courseName = course.name,
    courseDescription = course.description,
    courseImage = Image.network(course.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: 0,
      child: CourseScrollView(
        courseName: courseName,
        courseDescription: courseDescription,
        courseImage: courseImage,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 8),
            child: TitleText("Topics"),
          ),
          ...topics.toNewList((topic) => _TopicButton.fromTopic(topic)),
        ]
      )
    );
  }
}

class _TopicButton extends StatelessWidget {
  final String topicName;
  final int topicOrder;
  final String topicUrl;

  _TopicButton.fromTopic(Topic topic) :
    topicName = topic.name,
    topicOrder = topic.orderCourse,
    topicUrl = topic.nameFile;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: TopicFileScreen(fileUrl: topicUrl),
        pageTransitionAnimation: PageTransitionAnimation.scale,
        withNavBar: false
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TitleText("${topicOrder + 1}. $topicName", fontSize: 20, fontWeight: FontWeight.w400)
      )
    );
  }
}