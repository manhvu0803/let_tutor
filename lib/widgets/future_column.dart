import 'package:flutter/material.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';

class FutureColumn<T> extends StatelessWidget {
  final Function(int itemCount)? onDone;
  final Future<List<T>> Function() fetchData;
  final Widget Function(T) buildItem;
  final bool forceReload;

  const FutureColumn({super.key, this.onDone, required this.fetchData, required this.buildItem, this.forceReload = false});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      forceReload: forceReload,
      fetchData: () async {
        var data = await fetchData();
        onDone?.call(data.length);
        return data;
      },
      buildWidget: (context, data) {
        if (data.isEmpty) {
          return const Center(
            child: Text("Sorry, we can find anything with these options"),
          );
        }

        return Column(
          children: data.toNewList(buildItem)
        );
      }
    );
  }
}