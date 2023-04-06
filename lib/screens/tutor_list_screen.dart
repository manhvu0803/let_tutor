import 'package:flutter/material.dart';

import '../client.dart';
import '../data_model/tutor.dart';
import '../utils.dart';
import '../widgets/future_widget.dart';
import '../widgets/tutor_card.dart';
import 'screen.dart';
import '../widgets/search_bar.dart' as let;

class TutorListScreen extends StatefulWidget {
  static final specilaties = {
    "all",
    "english-for-kids",
    "business-english",
    "conversational-english",
    "starters",
    "movers",
    "flyers",
    "ket",
    "ielts",
    "toefl",
    "toeic",
  };

  const TutorListScreen({super.key});

  @override
  State<TutorListScreen> createState() => _TutorListScreenState();
}

class _TutorListScreenState extends State<TutorListScreen> {
  int _currentPage = 1;
  bool _isLoading = false;
  String nameFilter = "";
  String specialtyFilter = TutorListScreen.specilaties.first;
  DateTime? fromTimeFilter;
  DateTime? toTimeFilter;
  DateTime? dateFilter;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 500 && !_isLoading) {
      setState(() {
        _isLoading = true;
        _currentPage += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            collapsedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(top: 4, bottom: 8),
              centerTitle: true,
              title: Column(
                children: [
                  Expanded(
                    child: let.SearchBar(onSubmitted: (name) => setState(() => nameFilter = name))
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: OutlinedButton(
                          onPressed: () => _pickDate(context),
                          child: Text((dateFilter != null) ? toDateString(dateFilter!) : "Date")
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => _pickTime(context, (time) => fromTimeFilter = time),
                        child: Text((fromTimeFilter != null) ? toHourString(fromTimeFilter!) : "From")
                      ),
                      OutlinedButton(
                        onPressed: () => _pickTime(context, (time) => toTimeFilter = time),
                        child: Text((toTimeFilter != null) ? toHourString(toTimeFilter!) : "To")
                      ),
                      DropdownButton(
                        value: specialtyFilter,
                        items: buildList(
                          TutorListScreen.specilaties.toList(),
                          (specialty) => DropdownMenuItem(
                            value: specialty,
                            child: Text(specialty),
                          )
                        ),
                        onChanged: (specialty) => setState(() {
                          specialtyFilter = specialty ?? "";
                          _currentPage = 1;
                        })
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
          SliverList.builder(
            itemCount: _currentPage,
            addAutomaticKeepAlives: false,
            itemBuilder: (context, page) => _TutorColumn(
              fetchData: () => Client.searchTutor(
                page: page,
                perPageCount: 5,
                specialty: specialtyFilter,
                date: dateFilter,
                fromTime: fromTimeFilter,
                toTime: toTimeFilter
              ),
              onDone: () => _isLoading = false
            )
          ),
        ],
      ),
    );
  }

  void _pickTime(BuildContext context, Function(DateTime) setter) async {
    var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      var dateTime = dateFilter ?? DateTime.now();
      setState(() {
        setter(dateTime.applied(time));
        _currentPage = 1;
      });
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
      setState(() {
        dateFilter = date;
        _currentPage = 1;
      });
    }
  }
}

class _TutorColumn extends StatelessWidget {
  final Function()? onDone;
  final Future<List<Tutor>> Function() fetchData;

  const _TutorColumn({this.onDone, required this.fetchData});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: fetchData,
      onDone: onDone,
      buildWidget: (context, tutors) => Column(
        children: buildList(tutors, (tutor) => TutorCard.fromTutor(tutor, tagFontSize: 14))
      )
    );
  }
}