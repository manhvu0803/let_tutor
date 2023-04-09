import 'package:flutter/material.dart';
import 'package:let_tutor/client.dart';
import 'package:let_tutor/data_model/category.dart';
import 'package:let_tutor/data_model/course.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/list_extension.dart';
import 'package:let_tutor/widgets/course_screen_card.dart';
import 'package:let_tutor/widgets/dropdown_fliter.dart';
import 'package:let_tutor/widgets/infinite_scroll_view.dart';
import 'package:let_tutor/widgets/search_bar.dart' as my;

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
              my.SearchBar(
                currentText: _searchTerm,
                onSubmitted: (str) => setState(() => _searchTerm = str)
              ),
              Wrap(
                children: [
                  DropdownFilter(
                    name: "Level",
                    value: _chosenLevel,
                    options: Course.levelStrings.toIndexMap((item) => item),
                    onChanged: (value) => setState(() => _chosenLevel = value),
                  ),
                  DropdownFilter.iterable(
                    name: "Category",
                    value: _chosenCategory,
                    options: categorieStrings,
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