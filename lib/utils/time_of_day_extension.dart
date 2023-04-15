import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay advance({int hour = 0, int minute = 0}) {
    var extraHours = (this.minute + minute) ~/ 60;
    return TimeOfDay(
      hour: (this.hour + hour + extraHours) % 24,
      minute: (this.minute + minute) % 60
    );
  }
}