import 'package:flutter/material.dart';
import 'package:let_tutor/client.dart';
import 'package:let_tutor/data_model/schedule.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';

class Timetable extends StatelessWidget {
  static final _timeTextCells = _generateTimeText();

  static List<DataCell> _generateTimeText() {
    return List.generate(48, (index) {
      var hour = index ~/ 2;
      var min = (index % 2 == 0) ? 0 : 30;
      return DataCell(Text("$hour:${min.toString().padLeft(2, '0')} - $hour:${(min == 30) ? 55 : 25}"));
    });
  }

  static List<DataRow> _buildRows(List<Schedule> data, {int? startWeekday}) {
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
        Widget child;

        if (schedule.isBooked) {
          child = const Align(
            alignment: Alignment.center,
            child: Text("Booked", style: TextStyle(color: Colors.green))
          );
        }
        else {
          child = ElevatedButton(
            onPressed: () => print("Book ${schedule.id}"),
            child: const Text("Book", style: TextStyle(color: Colors.white))
          );
        }

        row.cells[scheduleWeekday] = DataCell(child);
        scheduleIndex++;
      }

      rows.add(row);
    }

    return rows;
  }

  final String tutorId;

  const Timetable({super.key, this.tutorId = ""});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureWidget(
          fetchData: () => Client.getTutorScheduleNow(tutorId),
          buildWidget: _buildTable,
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<Schedule> data) {
    data.sort((a, b) {
      var result = a.startTime.hour - b.startTime.hour;

      if (result != 0) {
        return result;
      }

      result = a.startTime.minute - b.startTime.minute;

      if (result != 0) {
        return result;
      }

      return a.startTime.compareTo(b.startTime);
    });

    var weekday = DateTime.now().weekday;

    return DataTable(
      columns: [
        const DataColumn(label: Text("Time")),
        ...List.generate(7, (index) => DataColumn(label: Text(weekdayString[(weekday + index) % 7])))
      ],
      rows: _buildRows(data, startWeekday: weekday)
    );
  }
}