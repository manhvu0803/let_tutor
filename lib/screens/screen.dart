import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget? child;
  final double padding;

  const Screen({super.key, this.child, this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: child
        ),
      ),
    );
  }
}