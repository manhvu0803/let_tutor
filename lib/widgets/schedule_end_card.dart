import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/screens/meeting_screen.dart';
import 'package:let_tutor/widgets/cancel_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ScheduleEndCard extends StatefulWidget {
  final Schedule schedule;

  const ScheduleEndCard({super.key, required this.schedule});

  @override
  State<ScheduleEndCard> createState() => _ScheduleEndCardState();
}

class _ScheduleEndCardState extends State<ScheduleEndCard> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.schedule.studentRequest;
  }

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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: CancelView(
                        startTime: widget.schedule.startTime,
                        onSubmitted: _tryCancel,
                      ),
                    )
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Cancel lesson"),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            const Text("Request for lesson"),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              )
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Submit")
            )
          ],
        )
      ],
    );
  }

  void _tryCancel(reasonId, note) async {
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}