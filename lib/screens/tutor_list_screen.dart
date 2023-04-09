import 'package:flutter/material.dart';
import 'package:let_tutor/client.dart';
import 'package:let_tutor/data_model/category.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/infinite_scroll_view.dart';
import 'package:let_tutor/widgets/tutor_card.dart';
import 'package:let_tutor/widgets/search_bar.dart' as my;

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({super.key});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  String _nameFilter = "";
  String _specialtyFilter = categorieStrings.first;
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
                child: my.SearchBar(
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
                      child: Text((_dateFilter != null) ? _dateFilter!.dateString : "Date")
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _pickTime(context, (time) => _fromTimeFilter = time),
                    child: Text((_fromTimeFilter != null) ? _fromTimeFilter!.hourString : "From")
                  ),
                  OutlinedButton(
                    onPressed: () => _pickTime(context, (time) => _toTimeFilter = time),
                    child: Text((_toTimeFilter != null) ? _toTimeFilter!.hourString : "To")
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton(
                      value: _specialtyFilter,
                      items: buildList(
                        categorieStrings,
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