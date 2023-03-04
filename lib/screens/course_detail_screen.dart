import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/title_text.dart';

class CourseDetailSreen extends StatelessWidget {
  final String? courseName;

  final String? courseDescription;

  const CourseDetailSreen({super.key, this.courseName, this.courseDescription});

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                children: [
                  Text(courseName ?? ""),
                  Text(courseDescription ?? "")
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const TitleText("Overview"),
                const TitleText("Why take this course", fontSize: 20),
                const Text("Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor"),
                const TitleText("What will you learn", fontSize: 20),
                const Text("You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends"),
                const TitleText("Level"),
                const TitleText("Intermediate", fontSize: 20, fontWeight: FontWeight.w500),
                const TitleText("Course length"),
                const TitleText("9 topics", fontSize: 20, fontWeight: FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 20, right: 20, bottom: 8),
                  child: SizedBox(
                    width: 1,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => print("Discorver"),
                      child: const Text("Discover")
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}