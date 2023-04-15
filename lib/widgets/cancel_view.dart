import 'package:flutter/material.dart';
import 'package:let_tutor/utils/utils.dart';

List<String> cancelReasons = [
  "Reschedule at another time",
  "Busy at that time",
  "Asked by tutor",
  "Other"
];

class CancelView extends StatefulWidget {
  final DateTime startTime;
  final Function(int reasonId, String note)? onSubmitted;

  const CancelView({super.key, this.onSubmitted, required this.startTime});

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
                const Text("Cancel", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
          DropdownButton(
            items: List.generate(
              cancelReasons.length,
              (index) => DropdownMenuItem(
                value: index + 1,
                child: Text(cancelReasons[index])
              )
            ),
            onChanged: (value) => setState(() => reasonId = value ?? 4)
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
        ]
      )
    );
  }
}