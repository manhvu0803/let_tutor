final weekdayString = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

final monthString = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

String toDateString(DateTime time) {
  return "${weekdayString[time.weekday]}, ${time.day}-${monthString[time.month]}-${time.year}";
}

String toHourString(DateTime time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
}