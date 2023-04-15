import 'package:flutter/material.dart';
import 'package:let_tutor/client/client.dart' as client;
import 'package:let_tutor/widgets/infinite_scroll_view.dart';
import 'package:let_tutor/widgets/rating_label.dart';
import 'package:let_tutor/widgets/user_info_box.dart';

class ReviewScrollView extends StatelessWidget {
  final String tutorId;

  const ReviewScrollView({super.key, required this.tutorId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InfiniteScrollView(
        flexibleSpace: const Center(
          child: Text("Reviews", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
        ),
        expandedHeight: 60,
        collapseHeight: 60,
        fetchData: (page) => client.getReviews(tutorId: tutorId, page: page + 1, perPageCount: 10),
        buildItem: (item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInfoBox(
                userId: "",
                isTappable: false,
                name: item.studentName,
                lastChild: RatingLabel(rating: item.rating.toDouble()),
                avatar: Image.network(item.studentAvatarUrl).image,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 12.0),
                child: Text(item.content),
              )
            ],
          ),
        )
      ),
    );
  }
}
