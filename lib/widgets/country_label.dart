import 'package:flutter/material.dart';

class CountryLabel extends StatelessWidget {
  final ImageProvider? flag;
  final String countryName;

  const CountryLabel({super.key, this.flag, this.countryName = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (flag != null) Image(image: flag!),
        Text(countryName)
      ],
    );
  }
}
