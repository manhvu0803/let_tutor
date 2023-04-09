import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:let_tutor/screens/screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/future_widget.dart';

class TopicFileScreen extends StatelessWidget {
  final String fileUrl;

  const TopicFileScreen({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return FutureWidget(
      fetchData: () => DefaultCacheManager().getSingleFile(fileUrl),
      buildWidget: (context, file) => Screen(
        padding: 0,
        child: PDFView(
          filePath: file.path,
          onError: (error) => showErrorDialog(context, error),
          onPageError: (page, error) => showErrorDialog(context, error),
        ),
      )
    );
  }
}