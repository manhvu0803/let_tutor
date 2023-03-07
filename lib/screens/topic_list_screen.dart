import 'package:flutter/material.dart';

import '../widgets/course_scroll_view.dart';
import '../widgets/title_text.dart';
import 'screen.dart';

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: 0,
      child: CourseScrollView(
        courseName: "Life in the Internet Age",
        courseDescription: "Let's discuss how technology is changing the way we live",
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 8),
            child: TitleText("Topics"),
          ),
          TextButton(
            onPressed: () { },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: TitleText("1. The internet", fontSize: 20, fontWeight: FontWeight.w400)
            )
          ),
          TextButton(
            onPressed: () { },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: TitleText("2. Artificial Intelligence (AI)", fontSize: 20, fontWeight: FontWeight.w400),
            )
          )
        ]
      )
    );
  }
}