import 'package:flutter/material.dart';

final weekdayString = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

final monthString = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

String toDateString(DateTime time) {
  return "${weekdayString[time.weekday]}, ${time.day}-${monthString[time.month]}-${time.year}";
}

String toHourString(DateTime time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
}

List<U> buildList<T, U>(List<T> list, U Function(T) builder) {
  final widgets = <U>[];

  for (final item in list) {
    widgets.add(builder(item));
  }

  return widgets;
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        title: Text("Loading..."),
        content: Center(
          heightFactor: 0.5,
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator()
          ),
        ),
      );
    }
  );
}

void showErrorDialog(BuildContext context, Object? error) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, "OK"),
            child: const Text("OK")
          )
        ],
      );
    }
  );
}