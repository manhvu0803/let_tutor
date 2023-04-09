import 'package:flutter/material.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';

class FutureColumn<T> extends StatelessWidget {
  final Function()? onDone;
  final Future<List<T>> Function() fetchData;
  final Widget Function(T) buildItem;
  final bool forceReload;

  const FutureColumn({super.key, this.onDone, required this.fetchData, required this.buildItem, this.forceReload = false});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      forceReload: forceReload,
      fetchData: fetchData,
      onDone: onDone,
      buildWidget: (context, data) => Column(
        children: buildList(data, buildItem)
      )
    );
  }
}