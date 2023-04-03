import 'package:flutter/material.dart';

class RatingLabel extends StatelessWidget {
  final double rating;

  const RatingLabel({super.key, this.rating = 0});

  @override
  Widget build(BuildContext context) {
    if (rating < 1) {
      return const Text("No review yet", style: TextStyle(fontStyle: FontStyle.italic));
    }

    var starCount = rating.round();
    var icons = <Widget>[];

    for (int i = 0; i < starCount; ++i) {
      icons.add(const Icon(Icons.star, color: Colors.yellow, size: 18));
    }

    return Row(
      children: icons
    );
  }
}