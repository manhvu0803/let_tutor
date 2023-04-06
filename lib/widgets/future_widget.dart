import 'package:flutter/material.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> Function() fetchData;
  final Widget Function(BuildContext, T) buildWidget;
  final Function()? onDone;

  const FutureWidget({super.key, required this.fetchData, required this.buildWidget, this.onDone});

  @override
  State<StatefulWidget> createState() => _FutureState<T>();
}

class _FutureState<T> extends State<FutureWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.fetchData(),
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