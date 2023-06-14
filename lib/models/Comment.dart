class Comment{
  final String commentId;
  final String postId;
  final String uid;
  final String comment;
  final DateTime date;

  const Comment({
    required this.commentId,
    required this.postId,
    required this.uid,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "postId": postId,
        "uid": uid,
        "comment": comment,
        "date": date
  };
}