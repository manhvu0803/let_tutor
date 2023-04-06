import 'package:flutter/material.dart';

import '../client.dart';
import '../widgets/future_column.dart';
import '../widgets/search_bar.dart' as let_tutor;
import '../widgets/course_screen_card.dart';
import 'screen.dart';

const _levels = ["Any level", "Beginner", "Advance", "Intermediate"];
const _categories = ["Any category", "Business", "Kid", "TOEICS", "IELTS"];
const _sortOrder = ["Level ascending", "Level descending"];

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CourseListScreenState();
  }
}

class _CourseListScreenState extends State<CourseListScreen> {
  int _currentPage = 1;
  bool _isLoading = false;
  late final ScrollController _scrollController;
  String _chosenLevel = _levels.first;
  String _chosenCategory = _categories.first;
  String _chosenSortOrder = _sortOrder.first;

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
      child: Column(
        children: [
          let_tutor.SearchBar(onSubmitted: (str) => debugPrint("search $str")),
          Row(
            children: [
              Flexible(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _chosenLevel,
                  onChanged: (value) => setState(() => _chosenLevel = value!),
                  items: _menuItemFrom(_levels)
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _chosenCategory,
                    onChanged: (value) => setState(() => _chosenCategory = value!),
                    items: _menuItemFrom(_categories)
                  ),
                ),
              ),
              Flexible(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _chosenSortOrder,
                  onChanged: (value) => setState(() => _chosenSortOrder = value!),
                  items: _menuItemFrom(_sortOrder)
                ),
              )
            ],
          ),
          Flexible(
            child: ListView.builder(
              addAutomaticKeepAlives: false,
              controller: _scrollController,
              itemCount: _currentPage,
              itemBuilder: (context, page) => FutureColumn(
                forceReload: _currentPage == 1,
                fetchData: () => Client.searchCourse(page: page + 1),
                onDone: () => _isLoading = false,
                buildItem: (course) => Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: CourseScreenCard.fromCourse(course),
                )
              ),
            ),
          ),
        ]
      ),
    );
  }
}

List<DropdownMenuItem<T>> _menuItemFrom<T>(List<T> list) {
  List<DropdownMenuItem<T>> menuItems = [];

  for (var item in list) {
    menuItems.add(
      DropdownMenuItem(
        value: item,
        child: Text(item.toString()),
      )
    );
  }

  return menuItems;
}