import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final Widget? child;

  const RoundedBox({super.key, this.child});

  RoundedBox.text(String text, {key, double fontSize = 20}) : this(
    child: Text(text,
    style: TextStyle(color: const Color(0xFF0071F0), fontSize: fontSize)),
    key: key
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFDDEAFF),
        border: Border.all(color: const Color(0xFFDDEAFF), width: 2),
        borderRadius: BorderRadius.circular(24)
      ),
      child: child,
    );
  }
}