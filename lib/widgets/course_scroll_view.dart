import 'package:flutter/material.dart';

class CourseScrollView extends StatelessWidget {
  final String? courseName;
  final String? courseDescription;
  final List<Widget> children;

  const CourseScrollView({
    super.key,
    required this.courseName,
    required this.courseDescription,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(courseName ?? ""),
                Text(courseDescription ?? "", style: const TextStyle(fontSize: 14))
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          sliver: SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        )
      ],
    );
  }
}