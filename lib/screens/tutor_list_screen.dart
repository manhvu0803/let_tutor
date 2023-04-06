import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/tutor.dart';
import '../utils.dart';
import '../widgets/future_state.dart';
import '../widgets/tutor_card.dart';
import 'screen.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({super.key});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends FutureState<TutorListScreen, List<Tutor>> {
  @override
  Future<List<Tutor>> fetchData() => Client.searchTutor();

  @override
  Widget buildOnFuture(BuildContext context, List<Tutor> tutors) {
    return Screen(
      child: ListView(
        children: buildList(tutors, (tutor) => TutorCard.fromTutor(tutor, tagFontSize: 14))
      ),
    );
  }
}