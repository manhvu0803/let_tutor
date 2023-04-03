import 'package:flutter/material.dart';

import '../data_model/tutor.dart';
import '../screens/tutor_info_screen.dart';
import 'rating_label.dart';
import 'rounded_box.dart';
import 'user_info_box.dart';

class TutorCard extends StatelessWidget {
  final String name;
  final ImageProvider? avatar;
  final String country;
  final ImageProvider? countryFlag;
  final String bio;
  final double rating;
  final List<String>? tags;
  final bool isTappableAndTagged;
  final String tutorId;

  const TutorCard({
    super.key,
    this.name = "",
    this.avatar,
    this.country = "",
    this.countryFlag,
    this.bio = "",
    this.rating = 0,
    this.tags,
    this.isTappableAndTagged = true,
    required this.tutorId
  });

  TutorCard.fromTutor(Tutor tutor, {super.key, this.isTappableAndTagged = true}) :
    name = tutor.name,
    avatar = Image.network(tutor.avatarUrl).image,
    country = tutor.country,
    countryFlag = null,
    bio = tutor.bio,
    rating = tutor.rating,
    tags = tutor.specialties,
    tutorId = tutor.id;

  void _toTutorInfo(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TutorInfoScreen(tutorId: tutorId)));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Card(
      child: InkWell(
        onTap: isTappableAndTagged ? () => _toTutorInfo(context) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tutor info
            Row(
              children: [
                Expanded(
                  child: UserInfoBox(
                    userId: tutorId,
                    name: name,
                    avatar: avatar,
                    countryName: country,
                    countryFlag: countryFlag,
                    lastChild: RatingLabel(rating: rating)
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite),
                )
              ]
            ),
            // Tags
            if (tags != null && isTappableAndTagged) Wrap(children: _buildTags(tags!)),
            // Description
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(bio, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify),
            )
          ],
        ),
      ),
    );
  }

  static List<Widget> _buildTags(List<String> tags) {
    var widgets = <Widget>[];

    for (var tag in tags) {
      widgets.add(RoundedBox.text(tag));
    }

    return widgets;
  }
}