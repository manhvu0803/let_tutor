import 'package:flutter/material.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> Function() fetchData;
  final Widget Function(BuildContext, T) buildWidget;

  const FutureWidget({super.key, required this.fetchData, required this.buildWidget});

  @override
  State<StatefulWidget> createState() => _FutureState<T>();
}

class _FutureState<T> extends State<FutureWidget<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.fetchData();
  }

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
      return Center(child: Text("Error: ${snapshot.error}"));
    }

    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    return widget.buildWidget(context, snapshot.data as T);
  }
}