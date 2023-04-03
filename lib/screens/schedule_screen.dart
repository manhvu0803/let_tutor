import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../client.dart';
import '../widgets/schedule_card.dart';
import 'meeting_screen.dart';
import 'screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late Future<List<Schedule>> _future;

  @override
  void initState() {
    super.initState();
    _future = Client.getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: buildOnFuture
    );
  }

  Widget buildOnFuture(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print("Stack trace: ${snapshot.stackTrace}");
      return Screen(child: Center(child: Text("Error: ${snapshot.error}")));
    }

    if (!snapshot.hasData) {
      return const Screen(child: CircularProgressIndicator());
    }

    var scheduleCards = <Widget>[];

    for (var schedule in snapshot.data as List<Schedule>) {
      scheduleCards.add(ScheduleCard(
        date: schedule.startTime,
        username: schedule.tutor.name,
        countryName: schedule.tutor.country,
        children: const [_ScheduleEndCard()],
      ));
    }

    return Screen(child: ListView(children: scheduleCards));
  }
}

class _ScheduleEndCard extends StatelessWidget {
  const _ScheduleEndCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const MeetingScreen(),
                      pageTransitionAnimation: PageTransitionAnimation.scale,
                      withNavBar: false
                    ),
                    child: const Text("Go to meeting")
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () => print("Cancel lesson"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Cancel lesson"),
                  ),
                ),
              )
            ],
          ),
          const ExpansionTile(
            title: Text("Request for lesson"),
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}