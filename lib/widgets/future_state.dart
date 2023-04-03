import 'package:flutter/material.dart';

import '../screens/screen.dart';

abstract class FutureState<T extends StatefulWidget> extends State<T> {
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchData();
  }

  Future<dynamic> fetchData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: _buildOnSnapshot
    );
  }

  Widget _buildOnSnapshot(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      debugPrint("Stack trace: ${snapshot.stackTrace}");
      return Screen(child: Center(child: Text("Error: ${snapshot.error}")));
    }

    if (!snapshot.hasData) {
      return const Screen(child: Center(child: CircularProgressIndicator()));
    }

    return buildOnFuture(context, snapshot.data!);
  }

  Widget buildOnFuture(BuildContext context, Object data);
}