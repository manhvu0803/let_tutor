import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/course.dart';

import '../client.dart';
import '../data_model/tutor.dart';
import '../utils.dart';
import '../widgets/future_widget.dart';
import '../widgets/tutor_card.dart';
import 'screen.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({super.key});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      child: ListView.builder(
        itemBuilder: (context, page) => _InfiniteScrollView(page: page)
      ),
    );
  }
}

class _InfiniteScrollView extends StatelessWidget {
  final int page;

  const _InfiniteScrollView({this.page = 1});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => Client.searchTutor(page: page),
      buildWidget: (context, tutors) => ListView(
        children: buildList(tutors, (tutor) => TutorCard.fromTutor(tutor, tagFontSize: 14))
      )
    );
  }
}