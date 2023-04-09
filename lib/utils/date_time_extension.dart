import 'package:flutter/material.dart';

final weekdayString = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

final monthString = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  String get dateString => "${weekdayString[weekday]}, $day-${monthString[month]}-$year";

  String get dateStringGmt => "${weekdayString[weekday]} $day ${monthString[month]} $year";

  String get hourString => "$hour:${minute.toString().padLeft(2, '0')}";
}