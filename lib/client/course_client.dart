import 'package:let_tutor/client/client.dart';
import 'package:let_tutor/data_model/category.dart';
import 'package:let_tutor/data_model/course.dart';
import 'package:let_tutor/utils/utils.dart';

List<Category> _categories = [];

List<Category> get categories => _categories;

Future<Course> getCourse(String id) async {
  var json = await Client.jsonFromAuthGet(url("course/$id"));
  return Course.fromJson(json["data"]);
}

Future<List<Course>> searchCourse({
  int page = 1,
  int perPageCount = 5,
  List<int>? level,
  bool isAscending = true,
  List<String>? categoryIds,
  String searchTerm = ""
}) async {
  var queries = {
    "page": "$page",
    "size": "$perPageCount",
    if (level != null && level.isNotEmpty) "level[]": List.generate(level.length, (i) => level[i].toString()),
    "orderBy[]": isAscending ? "ASC" : "DESC",
    if (categoryIds != null && categoryIds.isNotEmpty) "categoryId[]": categoryIds,
    "searchTerm": searchTerm
  };

  var json = await Client.jsonFromAuthGet(url("course", queries: queries));
  return (json["data"]["rows"] as List).toNewList((json) => Course.fromJson(json));
}

Future<List<Category>> getCategories() async {
  var json = await Client.jsonFromAuthGet(url("content-category"));
  _categories = (json["rows"] as List).toNewList((json) => Category.fromJson(json));
  return _categories;
}
