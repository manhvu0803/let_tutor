import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../client.dart';
import '../utils.dart';
import '../widgets/future_widget.dart';
import '../widgets/schedule_card.dart';
import 'meeting_screen.dart';
import 'screen.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => Client.getSchedule(),
      buildWidget: (context, scheduleList) => Screen(child:
        ListView(
          children: buildList(
            scheduleList,
            (schedule) => ScheduleCard.fromSchedule(schedule, children: const [_ScheduleEndCard()])
          )
        )
      )
    );
  }
}

class _ScheduleEndCard extends StatelessWidget {
  const _ScheduleEndCard();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  onPressed: () => debugPrint("Cancel lesson"),
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
    );
  }
}