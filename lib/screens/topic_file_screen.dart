import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:let_tutor/screens/screen.dart';

import '../utils.dart';
import '../widgets/future_state.dart';

class TopicFileScreen extends StatefulWidget {
  final String fileUrl;

  const TopicFileScreen({super.key, required this.fileUrl});

  @override
  State<TopicFileScreen> createState() => _TopicFileScreenState();
}

class _TopicFileScreenState extends FutureState<TopicFileScreen, File> {
  @override
  Future<File> fetchData() => DefaultCacheManager().getSingleFile(widget.fileUrl);

  @override
  Widget buildOnFuture(BuildContext context, File file) {
    return Screen(
      padding: 0,
      child: PDFView(
        filePath: file.path,
        onError: (error) => showErrorDialog(context, error),
        onPageError: (page, error) => showErrorDialog(context, error),
      ),
    );
  }
}