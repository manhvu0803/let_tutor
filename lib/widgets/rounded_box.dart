import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final Widget? child;

  final double outerPadding;

  const RoundedBox({super.key, this.child, this.outerPadding = 4});

  RoundedBox.text(String text, {key, double fontSize = 16}) : this(
    child: Text(text,
    style: TextStyle(color: const Color(0xFF0071F0), fontSize: fontSize)),
    key: key
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(outerPadding),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFDDEAFF),
          border: Border.all(color: const Color(0xFFDDEAFF), width: 2),
          borderRadius: BorderRadius.circular(24)
        ),
        child: child,
      ),
    );
  }
}