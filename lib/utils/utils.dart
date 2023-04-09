import 'package:flutter/material.dart';

export "date_time_extension.dart";
export "list_extension.dart";
export "iterable_extension.dart";

String timeOfDayToString(TimeOfDay time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
}

List<U> buildList<T, U>(Iterable<T> list, U Function(T) builder) {
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