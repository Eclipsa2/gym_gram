class Post {
  final String postId;
  final String workoutId;
  final String uid;
  final String description;
  final String photoUrl;
  final DateTime date;

  const Post({
    required this.postId,
    required this.workoutId,
    required this.uid,
    required this.description,
    required this.photoUrl,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "workoutId": workoutId,
        "description": description,
        "uid": uid,
        "photoUrl": photoUrl,
        "date": date,
      };
}
