import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/future_column.dart';

class InfiniteScrollView<T> extends StatefulWidget {
  final double? collapseHeight;
  final double expandedHeight;
  final bool forceReload;
  final Future<List<T>> Function(int page) fetchData;
  final Widget Function(T data) buildItem;
  final Widget? flexibleSpace;

  const InfiniteScrollView({
    super.key,
    required this.fetchData,
    required this.buildItem,
    this.flexibleSpace,
    this.collapseHeight,
    this.expandedHeight = 150,
    this.forceReload = false
  });

  @override
  State<StatefulWidget> createState() => _InfiniteScrollViewState<T>();
}

class _InfiniteScrollViewState<T> extends State<InfiniteScrollView<T>> {
  late final ScrollController _scrollController;
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 50 && !_isLoading) {
      _isLoading = true;
      setState(() => _currentPage += 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          collapsedHeight: widget.collapseHeight,
          expandedHeight: widget.expandedHeight,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: widget.flexibleSpace
        ),
        SliverList.builder(
          itemCount: _currentPage,
          addAutomaticKeepAlives: false,
          itemBuilder: (context, page) => FutureColumn<T>(
            forceReload: widget.forceReload,
            fetchData: () => widget.fetchData(page),
            buildItem: widget.buildItem,
            onDone: _onLoadDone
          )
        )
      ]
    );
  }

  _onLoadDone(itemCount) {
    _isLoading = false;

    if (itemCount <= 0) {
      _currentPage -= 1;
    }
  }
}