import 'package:flutter/material.dart';

export "date_time_extension.dart";
export "list_extension.dart";
export "iterable_extension.dart";
export "time_of_day_extension.dart";

String timeOfDayToString(TimeOfDay time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
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

void showErrorDialog(BuildContext context, Object error) {
  showAlertDialog(context, title: "Error", message: "$error");
}

Future<void> showAlertDialog(BuildContext context, {required String title, required String message}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
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