import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/data_model/tutor.dart';
import 'package:let_tutor/screens/tutor_info_screen.dart';
import 'package:let_tutor/utils/utils.dart';
import 'package:let_tutor/widgets/rating_label.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

class TutorCard extends StatefulWidget {
  final String name;
  final ImageProvider? avatar;
  final String country;
  final ImageProvider? countryFlag;
  final String bio;
  final double rating;
  final List<String>? tags;
  final bool isTappable;
  final String tutorId;
  final bool isFavorite;
  final Widget? middle;

  const TutorCard({
    super.key,
    this.name = "",
    this.avatar,
    this.country = "",
    this.countryFlag,
    this.bio = "",
    this.rating = 0,
    this.tags,
    this.isTappable = true,
    this.isFavorite = false,
    required this.tutorId,
    this.middle
  });

  TutorCard.fromTutor(Tutor tutor, {super.key, this.middle, this.isTappable = true}) :
    name = tutor.name,
    avatar = Image.network(tutor.avatarUrl).image,
    country = tutor.country,
    countryFlag = null,
    bio = tutor.bio,
    rating = tutor.rating,
    tags = tutor.specialties,
    tutorId = tutor.id,
    isFavorite = tutor.isFavorite;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toTutorInfo(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TutorInfoScreen(tutorId: widget.tutorId)));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Card(
      elevation: 2.5,
      child: InkWell(
        onTap: widget.isTappable ? () => _toTutorInfo(context) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tutor info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: UserInfoBox(
                      userId: widget.tutorId,
                      name: widget.name,
                      avatar: widget.avatar,
                      countryName: widget.country,
                      countryFlag: widget.countryFlag,
                      lastChild: RatingLabel(rating: widget.rating),
                      isTappable: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => _onTap(context),
                      child: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                    ),
                  )
                ]
              ),
            ),
            // Tags or buttons
            if (widget.middle != null) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: widget.middle!,
            ),
            // Description
            _ExpandableText(text: widget.bio)
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) async {
    try {
      await client.switchTutorFavorite(widget.tutorId);
      setState(() => _isFavorite = !_isFavorite);
    }
    catch (error, stack) {
      debugPrint("Stack trace: $stack");

      if (!mounted) {
        return;
      }

      showErrorDialog(context, error);
    }
  }
}

class _ExpandableText extends StatefulWidget {
  final String text;
  final bool isTappable;
  final int unexpanededLineCount;

  const _ExpandableText({required this.text, this.isTappable = true, this.unexpanededLineCount = 2});

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