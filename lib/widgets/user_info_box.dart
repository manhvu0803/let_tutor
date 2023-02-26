import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/country_label.dart';

class UserInfoBox extends StatelessWidget {
  final ImageProvider? avatar;
  
  final Widget? lastChild;

  final String name;

  final String countryName;

  final ImageProvider? countryFlag;

  const UserInfoBox({super.key, this.name = "", this.avatar, this.lastChild, this.countryName = "", this.countryFlag});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(foregroundImage: avatar),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name),
              CountryLabel(countryName: countryName, flag: countryFlag),
              if (lastChild != null) lastChild!
            ],
          ),
        )
      ],
    );
  }
}