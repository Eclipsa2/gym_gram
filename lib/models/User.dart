class User {
  final String email;
  final String username;
  final String uid;
  final String photoUrl;

  const User({
    required this.email,
    required this.username,
    required this.uid,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
      };
}
