import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/booking_view.dart';
import 'package:let_tutor/widgets/future_widget.dart';

class Timetable extends StatefulWidget {
  final String tutorId;

  const Timetable({super.key, this.tutorId = ""});

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  String lastBookedScheduleId = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureWidget(
          key: ValueKey(lastBookedScheduleId),
          fetchData: () => client.getTutorScheduleNow(widget.tutorId),
          buildWidget: _buildTable
        ),
      ),
    );
  }

  Widget _buildTable(context, data) {
    data.sort(_compareSchedule);
    var weekday = DateTime.now().weekday;

    return DataTable(
      columns: [
        const DataColumn(label: Text("Time")),
        ...List.generate(7, (index) => DataColumn(label: Text(weekdayString[(weekday + index) % 7])))
      ],
      rows: _buildRows(context, data, startWeekday: weekday)
    );
  }

  List<DataRow> _buildRows(BuildContext context, List<Schedule> data, {int? startWeekday}) {
    var scheduleIndex = 0;
    var weekday = startWeekday ?? DateTime.now().weekday;
    var time = const TimeOfDay(hour: 23, minute: 30);
    var rows = <DataRow>[];

    for (final cell in _timeTextCells) {
      time = time.advance(minute: 30);

      if (scheduleIndex >= data.length) {
        continue;
      }

      var currentStartTime = data[scheduleIndex].startTime;

      if (!currentStartTime.equal(time)) {
        continue;
      }

      var row = DataRow(cells: List.filled(8, DataCell(Container())));
      row.cells[0] = cell;

      while (scheduleIndex < data.length && currentStartTime.equalHourMinute(data[scheduleIndex].startTime)) {
        var schedule = data[scheduleIndex];
        var scheduleWeekday = 1 + (schedule.startTime.weekday - weekday) % 7;
        row.cells[scheduleWeekday] = DataCell(_buildCellChild(context, schedule));
        scheduleIndex++;
      }

      rows.add(row);
    }

    return rows;
  }

  Widget _buildCellChild(BuildContext context, Schedule schedule) {
    if (schedule.isBooked) {
      return const Align(
        alignment: Alignment.center,
        child: Text("Booked", style: TextStyle(color: Colors.green))
      );
    }
    else {
      return ElevatedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(
            child: SizedBox(
              height: 500,
              child: BookingView(
                scheduleId: schedule.id,
                startTime: schedule.startTime,
                balance: 1,
                onDone: () => setState(() => lastBookedScheduleId = schedule.id),
              ),
            )
          )
        ),
        child: const Text("Book", style: TextStyle(color: Colors.white))
      );
    }
  }
}

int _compareSchedule(Schedule a, Schedule b) {
  var result = a.startTime.hour - b.startTime.hour;

  if (result != 0) {
    return result;
  }

  result = a.startTime.minute - b.startTime.minute;

  if (result != 0) {
    return result;
  }

  return a.startTime.compareTo(b.startTime);
}

final _timeTextCells = List.generate(48, (index) {
  var hour = index ~/ 2;
  var min = (index % 2 == 0) ? 0 : 30;
  return DataCell(Text("$hour:${min.toString().padLeft(2, '0')} - $hour:${min + 25}"));
});