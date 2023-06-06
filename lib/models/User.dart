class User {
  final String email;
  final String username;
  final String uid;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };
}
