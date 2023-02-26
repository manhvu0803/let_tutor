import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/rating_label.dart';
import 'package:let_tutor/screens/tutor_info_screen.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

class TutorCard extends StatelessWidget {
  final String name;

  final ImageProvider? avatar;

  final String country;

  final ImageProvider? countryFlag;

  final String introduction;

  final int rating;

  final List<String>? tags;

  const TutorCard({
    super.key,
    this.name = "",
    this.avatar,
    this.country = "",
    this.countryFlag,
    this.introduction = "",
    this.rating = 0,
    this.tags
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TutorInfoScreen())),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoBox(
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(introduction, textAlign: TextAlign.justify),
            )
          ],
        ),
      ),
    );
  }
}