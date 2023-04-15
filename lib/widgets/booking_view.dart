import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/try_async_button.dart';

class BookingView extends StatefulWidget {
  final String scheduleId;
  final DateTime startTime;
  final int balance;
  final Function()? onDone;

  const BookingView({super.key, required this.scheduleId, required this.startTime, this.balance = 0, this.onDone});

  @override
  State<StatefulWidget> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
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
                const Text("Booking details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Start time: ${fullString(widget.startTime)}", style: const TextStyle(fontSize: 18))
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Balance: ${widget.balance} lesson(s) left", style: const TextStyle(fontSize: 18))
                ),
              ],
            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Note..."
            ),
            maxLines: 10,
            onChanged: (value) => note = value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: TryAsyncButton(
              postData: () => book(widget.scheduleId, note: note),
              onDone: widget.onDone,
            )
          )
        ],
      ),
    );
  }
}

String fullString(DateTime time) {
  return "${time.hourString} ${time.dateString}";
}