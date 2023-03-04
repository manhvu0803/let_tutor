import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  final double fontSize;

  final FontWeight fontWeight;

  const TitleText(this.text, {super.key, this.fontSize = 30, this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight)),
    );
  }
}