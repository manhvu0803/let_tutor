import 'package:flutter/material.dart';

import '../data_model/tutor.dart';
import '../screens/tutor_info_screen.dart';
import '../utils.dart';
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
  final double tagFontSize;
  final bool isFavorite;

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
    this.tagFontSize = 16,
    this.isFavorite = false,
    required this.tutorId
  });

  TutorCard.fromTutor(Tutor tutor, {super.key, this.isTappableAndTagged = true, this.tagFontSize = 16}) :
    name = tutor.name,
    avatar = Image.network(tutor.avatarUrl).image,
    country = tutor.country,
    countryFlag = null,
    bio = tutor.bio,
    rating = tutor.rating,
    tags = tutor.specialties,
    tutorId = tutor.id,
    isFavorite = tutor.isFavorite;

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
                    lastChild: RatingLabel(rating: rating),
                    isTappable: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                )
              ]
            ),
            // Tags
            if (tags != null && tags!.isNotEmpty && isTappableAndTagged)
              Wrap(
                children: buildList(tags!, (tag) => RoundedBox.text(tag, fontSize: tagFontSize))
              ),
            // Description
            _ExpandableText(text: bio)
          ],
        ),
      ),
    );
  }
}

class _ExpandableText extends StatefulWidget {
  final String text;
  final bool isTappable;
  final int unexpanededLineCount;

  const _ExpandableText({required this.text, this.isTappable = true, this.unexpanededLineCount = 3});

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isTappable ? () => setState(() => _isExpanded = !_isExpanded) : null,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.unexpanededLineCount,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
          textAlign: TextAlign.justify
        ),
      ),
    );
  }
}