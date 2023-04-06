import 'package:flutter/material.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> Function() fetchData;
  final Widget Function(BuildContext, T) buildWidget;
  final Function()? onDone;
  final bool forceReload;

  const FutureWidget({super.key, required this.fetchData, required this.buildWidget, this.onDone, this.forceReload = false});

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
    if (widget.forceReload) {
      _future = widget.fetchData();
    }

    return FutureBuilder(
      future: _future,
      builder: _buildOnSnapshot
    );
  }

  Widget _buildOnSnapshot(BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        widget.onDone?.call();
        return widget.buildWidget(context, snapshot.data as T);
      }
      else {
        debugPrint("Stack trace: ${snapshot.stackTrace}");
        return Center(child: Text("Error: ${snapshot.error}"));
      }
    }

    return const Center(child: CircularProgressIndicator());
  }
}