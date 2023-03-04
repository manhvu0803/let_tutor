import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;

  final String text;

  final TextStyle? style;

  final TextStyle? textStyle;

  const IconLabel({super.key, required this.icon, required this.text, this.style, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          WidgetSpan(child: Icon(icon), alignment: PlaceholderAlignment.middle),
          TextSpan(text: text, style: textStyle)
        ]
      ),
    );
  }
}