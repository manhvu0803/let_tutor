import 'package:flutter/material.dart';

class Timetable extends StatelessWidget {
  static final _timeTextCells = _generateTimeText();

  static List<DataCell> _generateTimeText() { 
    List<DataCell> rows = [];

    for (int i = 0; i < 1440; i += 30) {
      var hour = i ~/ 60;
      var min = i % 60;
      rows.add(DataCell(Text("$hour:${min.toString().padLeft(2, '0')} - $hour:${(min == 30) ? 25 : 55}")));
    }

    return rows;
  }

  const Timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Time")),
            DataColumn(label: Text("Mon")),
            DataColumn(label: Text("Tue")),
            DataColumn(label: Text("Wed")),
            DataColumn(label: Text("Thu")),
            DataColumn(label: Text("Fri")),
            DataColumn(label: Text("Sat")),
            DataColumn(label: Text("Sun")),
          ], 
          rows: rows()
        ),
      ),
    );
  }

  List<DataRow> rows() {
    List<DataRow> rows = [];

    for (var cell in _timeTextCells) {
      var row = DataRow(cells: List.filled(8, DataCell(Container())));
      row.cells[0] = cell;
      rows.add(row);
    }

    return rows;
  }
}