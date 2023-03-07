import 'package:flutter/material.dart';

import '../screens/tutor_info_screen.dart';
import 'rating_label.dart';
import 'rounded_box.dart';
import 'user_info_box.dart';

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
            // Tutor info
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
            // Tags
            if (tags != null) Wrap(children: _buildTags(tags!)),
            // Description
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(introduction, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify),
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