import 'package:flutter/material.dart';
import 'package:let_tutor/utils.dart';

import '../client.dart';
import '../data_model/course.dart';
import '../data_model/category.dart';
import '../widgets/dropdown_fliter.dart';
import '../widgets/infinite_scroll_view.dart';
import '../widgets/search_bar.dart' as let_tutor;
import '../widgets/course_screen_card.dart';
import 'screen.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CourseListScreenState();
  }
}

class _CourseListScreenState extends State<CourseListScreen> {
  int? _chosenLevel;
  String? _chosenCategory;
  String _searchTerm = "";
  bool _isSortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Screen(
      key: ValueKey([_chosenLevel, _chosenCategory, _isSortAscending]),
      child: InfiniteScrollView(
        expandedHeight: 250,
        fetchData: (page) => Client.searchCourse(
          page: page + 1,
          level: (_chosenLevel != null) ? [_chosenLevel!] : null,
          isAscending: _isSortAscending,
          categoryIds: (_chosenCategory != null) ? [_chosenCategory!] : null,
          searchTerm: _searchTerm
        ),
        buildItem: (course) => Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: CourseScreenCard.fromCourse(course),
        ),
        flexibleSpace: SingleChildScrollView(
          child: Column(
          children: [
            let_tutor.SearchBar(
              currentText: _searchTerm,
              onSubmitted: (str) => setState(() => _searchTerm = str)
            ),
            Wrap(
              children: [
                DropdownFilter(
                  name: "Level",
                  value: _chosenLevel,
                  options: DropdownFilter.toIndexMap(Course.levelStrings),
                  onChanged: (value) => setState(() => _chosenLevel = value),
                ),
                DropdownFilter.iterable(
                  name: "Category",
                  value: _chosenCategory,
                  options: categories,
                  onChanged: (value) => setState(() => _chosenCategory = value,)
                ),
                DropdownFilter(
                  name: "Sort level",
                  value: _isSortAscending,
                  allowNullOption: false,
                  options: const {true: "Ascending", false: "Descending"},
                  onChanged: (value) => setState(() => _isSortAscending = value ?? true),
                ),
              ],
            )
          ]
              ),
        )
      )
    );
  }
}