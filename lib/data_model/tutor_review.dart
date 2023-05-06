class TutorReview {
  ReviewPoint behaviour;
  ReviewPoint listening;
  ReviewPoint vocabulary;
  ReviewPoint speaking;
  String overallComment;
  String lessonStatus;

  TutorReview({
    this.behaviour = const ReviewPoint("", 0),
    this.listening = const ReviewPoint("", 0),
    this.vocabulary = const ReviewPoint("", 0),
    this.speaking = const ReviewPoint("", 0),
    this.overallComment = "",
    this.lessonStatus = "",
  });

  TutorReview.fromJson(Map<String, dynamic> json) :
    behaviour = ReviewPoint(json["behaviorComment"], json["behaviorRating"]),
    listening = ReviewPoint(json["listeningComment"], json["listeningRating"]),
    vocabulary = ReviewPoint(json["vocabularyComment"], json["vocabularyRating"]),
    speaking = ReviewPoint(json["speakingComment"], json["speakingRating"]),
    overallComment = json["overallComment"] ?? "",
    lessonStatus = (json["lessonStatus"] != null) ? json["lessonStatus"]["status"] ?? "" : "";
}

class ReviewPoint {
  final String comment;
  final int rating;

  const ReviewPoint([this.comment = "", this.rating = 0]);
}