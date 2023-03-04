import 'package:let_tutor/widgets/search_bar.dart' as let_tutor;
import 'package:flutter/material.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/widgets/course_screen_card.dart';

const _levels = ["Any level", "Beginner", "Advance", "Intermediate"];
const _categories = ["Any category", "Business", "Kid", "TOEICS", "IELTS"];
const _sortOrder = ["Level ascending", "Level descending"];

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CourseScreenState();
  }
}

class _CourseScreenState extends State<CourseScreen> {
  String _chosenLevel = _levels.first;
  String _chosenCategory = _categories.first;
  String _chosenSortOrder = _sortOrder.first;

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        children: [
          let_tutor.SearchBar(onSubmitted: (str) => print("search $str")),
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
            child: ListView(
              children: const [
                Text("English for traveling", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Wrap(
                  children: [
                    CourseScreenCard(
                      name: "Life in the Internet Age",
                      description: "Let's discuss how technology is changing the way we live",
                      level: "Intermediate",
                      lessonCount: 9,
                    ),
                    CourseScreenCard(
                      name: "Caring for Our Planet",
                      description: "Let's discuss our relationship as humans with our planet, Earth",
                      lessonCount: 1,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("English For Beginners", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ),
                Wrap(
                  children: [
                    CourseScreenCard(
                      name: "Basic Conversation Topics",
                      description: "Gain confidence speaking about familiar topics",
                      lessonCount: 9,
                    ),
                    CourseScreenCard(
                      name: "Caring for Our Planet",
                      description: "Let's discuss our relationship as humans with our planet, Earth",
                      lessonCount: 1,
                    )
                  ],
                )

              ]
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