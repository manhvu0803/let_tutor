import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';
import 'package:let_tutor/widgets/schedule_card.dart';
import 'package:let_tutor/widgets/schedule_end_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _refreshCount = 0;

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Your upcoming class(es)", style: TextStyle(fontSize: 24)),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future(() => setState(() => _refreshCount++)),
              child: FutureWidget(
                key: ValueKey(_refreshCount),
                fetchData: () => client.getSchedule(),
                buildWidget: (context, scheduleList) => ListView(
                  children: buildList(
                    scheduleList,
                    (schedule) => ScheduleCard.fromSchedule(
                      schedule,
                      children: [ScheduleEndCard(schedule: schedule)]
                    )
                  )
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
