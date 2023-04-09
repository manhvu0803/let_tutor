import 'package:flutter/material.dart';
import 'package:let_tutor/data_model/tutor.dart';
import 'package:let_tutor/data_model/user.dart';
import 'package:let_tutor/screens/tutor_info_screen.dart';
import 'package:let_tutor/widgets/country_label.dart';
import 'package:let_tutor/widgets/rating_label.dart';

class UserInfoBox extends StatelessWidget {
  final ImageProvider? avatar;
  final Widget? lastChild;
  final String name;
  final String countryName;
  final ImageProvider? countryFlag;
  final String userId;
  final bool isTappable;

  const UserInfoBox({
    super.key,
    this.name = "",
    this.avatar,
    this.lastChild,
    this.countryName = "",
    this.countryFlag,
    this.isTappable = true,
    required this.userId
  });

  UserInfoBox.fromUser(User user, {super.key, this.lastChild, this.isTappable = true}) :
    avatar = Image.network(user.avatarUrl).image,
    userId = user.id,
    name = user.name,
    countryName = user.country,
    countryFlag = null;

  UserInfoBox.fromTutor(Tutor tutor, {key, isTappable = true}) : this.fromUser(
    tutor,
    key: key,
    lastChild: RatingLabel(rating: tutor.rating),
    isTappable: isTappable
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isTappable ? () => _toUserInfo(context) : null,
      child: Row(
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
      ),
    );
  }

  void _toUserInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TutorInfoScreen(tutorId: userId)
    ));
  }
}