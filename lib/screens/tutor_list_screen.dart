import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/category.dart';
import '../utils.dart';
import '../widgets/infinite_scroll_view.dart';
import '../widgets/tutor_card.dart';
import 'screen.dart';
import '../widgets/search_bar.dart' as let;

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({super.key});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  String _nameFilter = "";
  String _specialtyFilter = categories.first;
  DateTime? _fromTimeFilter;
  DateTime? _toTimeFilter;
  DateTime? _dateFilter;

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: InfiniteScrollView(
        key: ValueKey([_nameFilter, _specialtyFilter, _fromTimeFilter, _toTimeFilter, _dateFilter]),
        buildItem: (tutor) => TutorCard.fromTutor(tutor),
        fetchData: (page) => Client.searchTutor(
          page: page + 1,
          perPageCount: 5,
          specialty: _specialtyFilter,
          date: _dateFilter,
          fromTime: _fromTimeFilter,
          toTime: _toTimeFilter,
          searchTerm: _nameFilter
        ),
        flexibleSpace: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: let.SearchBar(
                  currentText: _nameFilter,
                  onSubmitted: (name) => setState(() => _nameFilter = name)
                )
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: OutlinedButton(
                      onPressed: () => _pickDate(context),
                      child: Text((_dateFilter != null) ? toDateString(_dateFilter!) : "Date")
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _pickTime(context, (time) => _fromTimeFilter = time),
                    child: Text((_fromTimeFilter != null) ? toHourString(_fromTimeFilter!) : "From")
                  ),
                  OutlinedButton(
                    onPressed: () => _pickTime(context, (time) => _toTimeFilter = time),
                    child: Text((_toTimeFilter != null) ? toHourString(_toTimeFilter!) : "To")
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton(
                      value: _specialtyFilter,
                      items: buildList(
                        categories,
                        (specialty) => DropdownMenuItem(
                          value: specialty,
                          child: Text(specialty),
                        )
                      ),
                      onChanged: (specialty) => setState(() => _specialtyFilter = specialty ?? "")
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void _pickTime(BuildContext context, Function(DateTime) setter) async {
    var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      var dateTime = _dateFilter ?? DateTime.now();
      setState(() => setter(dateTime.applied(time)));
    }
  }

  void _pickDate(BuildContext context) async {
    var now = DateTime.now();

    var date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1)
    );

    if (date != null) {
      setState(() => _dateFilter = date);
    }
  }
}