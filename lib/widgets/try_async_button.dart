import 'package:flutter/material.dart';
import 'package:let_tutor/utils/utils.dart';

class TryAsyncButton<T> extends StatefulWidget {
  final Function()? onSubmitted;
  final Future<T> Function() postData;
  final Function()? onDone;
  final Function()? onError;
  final String text;
  const TryAsyncButton({super.key, this.onSubmitted, required this.postData, this.onDone, this.onError, this.text = "Submit"});

  @override
  State<StatefulWidget> createState() => _TryAsyncButtonState();
}

class _TryAsyncButtonState<T> extends State<TryAsyncButton<T>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          widget.onSubmitted?.call();
          _tryPostData(context);
        },
        child: Text(widget.text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  void _tryPostData(BuildContext context) async {
    showLoadingDialog(context);

    try {
      var message = await widget.postData();

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
      Navigator.pop(context);
      showAlertDialog(context, title: "Success", message: message.toString());
      widget.onDone?.call();
    }
    catch (error, stack) {
      debugPrint(stack.toString());

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
      showErrorDialog(context, error);
      widget.onError?.call();
    }
  }
}