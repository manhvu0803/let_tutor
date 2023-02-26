import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget? child;

  const Screen({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: child
        ),
      ),
    );
  }
}