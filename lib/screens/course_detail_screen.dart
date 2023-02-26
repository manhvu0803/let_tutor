import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';

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
              const [
                Text("Overview")
              ]
            ),
          )
        ],
      ),
    );
  }
}