import 'package:flutter/material.dart';

class IconLable extends StatelessWidget {
  final IconData icon;

  final String text;

  final TextStyle? style;

  final TextStyle? textStyle;

  const IconLable({super.key, required this.icon, required this.text, this.style, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          WidgetSpan(child: Icon(icon)),
          TextSpan(text: text, style: textStyle)
        ]
      )
    );
  }
}