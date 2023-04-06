import 'package:flutter/material.dart';

import '../screens/screen.dart';

abstract class FutureState<T extends StatefulWidget, U> extends State<T> {
  late Future<U> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchData();
  }

  Future<U> fetchData();

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

    return buildOnFuture(context, snapshot.data as U);
  }

  Widget buildOnFuture(BuildContext context, U data);
}