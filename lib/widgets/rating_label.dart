import 'package:flutter/material.dart';

class RatingLabel extends StatelessWidget {
  final int rating;
  
  const RatingLabel({super.key, this.rating = 0});

  @override
  Widget build(BuildContext context) {
    if (rating < 1) {
      return const Text("No review yet", style: TextStyle(fontStyle: FontStyle.italic));
    }

    return Text(rating.toString());
  }
}