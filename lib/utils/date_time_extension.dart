import 'package:flutter/material.dart';

final weekdayString = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

final monthString = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  String get dateString => "${weekdayString[weekday]}, $day-${monthString[month]}-$year";

  String get dateStringGmt => "${weekdayString[weekday]} $day ${monthString[month]} $year";

  String get hourString => "$hour:${minute.toString().padLeft(2, '0')}";

  DateTime get date => DateTime(year, month, day);

  bool equalHourMinute(DateTime other) => hour == other.hour && minute == other.minute;

  bool equal(TimeOfDay time) => hour == time.hour && minute == time.minute;
}