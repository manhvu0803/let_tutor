import 'package:flutter/material.dart';

class CountryLabel extends StatelessWidget {
  final ImageProvider? flag;

  final String countryName;

  const CountryLabel({super.key, this.flag, this.countryName = ""});
  
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    
    if (flag != null) {
      children.add(Image(image: flag!));
    }

    children.add(Text(countryName));
    return Row(children: children);
  }
}
