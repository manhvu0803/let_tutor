import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/try_async_button.dart';

List<String> cancelReasons = [
  "Reschedule at another time",
  "Busy at that time",
  "Asked by tutor",
  "Other"
];

class CancelView extends StatefulWidget {
  final DateTime startTime;
  final String scheduleId;
  final Function()? onDone;

  const CancelView({super.key, this.onDone, required this.startTime, required this.scheduleId});

  @override
  State<StatefulWidget> createState() => _CancelViewState();
}

class _CancelViewState extends State<CancelView> {
  int reasonId = 1;
  String note = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24.0),
            child: Column(
              children: [
                const Text("Cancel session", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "${widget.startTime.hourString}, ${widget.startTime.dateString}",
                    style: const TextStyle(fontSize: 18)
                  ),
                )
              ]
            )
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text("What was the reason you cancel this?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DropdownButton(
              value: reasonId,
              items: List.generate(
                cancelReasons.length,
                (index) => DropdownMenuItem(
                  value: index + 1,
                  child: Text(cancelReasons[index], style: const TextStyle(fontSize: 20))
                )
              ),
              onChanged: (value) => setState(() => reasonId = value ?? 4)
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Additional notes"
            ),
            onChanged: (value) => note = value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TryAsyncButton(
              postData: () => cancel(widget.scheduleId, cancelReasonId: reasonId, note: note),
              onDone: widget.onDone,
            )
          )
        ]
      )
    );
  }
}