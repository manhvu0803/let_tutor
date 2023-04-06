import 'package:flutter/material.dart';

class CourseScrollView extends StatelessWidget {
  final String? courseName;
  final String? courseDescription;
  final List<Widget> children;
  final Image? courseImage;

  const CourseScrollView({
    super.key,
    required this.courseName,
    required this.courseDescription,
    this.courseImage,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 450,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Align(
              alignment: Alignment.topCenter,
              child: courseImage
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SliverBarText(courseName ?? ""),
                _SliverBarText(courseDescription ?? "", style: const TextStyle(fontSize: 14, color: Colors.black))
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

class _SliverBarText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _SliverBarText(this.text, {this.style = const TextStyle(color: Colors.black)});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Text(text, style: style),
    );
  }
}