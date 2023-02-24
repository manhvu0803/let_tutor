import 'package:flutter/material.dart';

class TutorCard extends StatelessWidget {
  final String name;

  final ImageProvider? avatar;

  final String country;

  final ImageProvider? countryFlag;

  final String introduction;

  final int? rating;

  final List<String>? tags;

  const TutorCard({super.key, required this.name, this.avatar, this.country = "", this.countryFlag, this.introduction = "", this.rating, this.tags});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(foregroundImage: avatar),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(name),
                    countryRow(),
                    ratingText(),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.favorite),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(introduction, textAlign: TextAlign.justify),
          )
        ],
      ),
    );
  }

  Row countryRow() {
    var children = <Widget>[];
    
    if (countryFlag != null) {
      children.add(Image(image: countryFlag!));
    }

    children.add(Text(country));
    return Row(children: children);
  }

  Text ratingText() {
    if (rating == null) {
      return const Text("No review yet", style: TextStyle(fontStyle: FontStyle.italic));
    }

    return Text(rating.toString());
  }
}