import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_gram/resources/storage_methods.dart';

import '../models/Post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Upload a post
  Future<String> uploadPost(
      Uint8List file, String uid, String workoutId) async {
    String res = "error";
    try {
      String postId = uid + DateTime.now().toString();
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      Post post = Post(
          uid: uid,
          description: '',
          postId: postId,
          date: DateTime.now(),
          photoUrl: photoUrl,
          workoutId: workoutId);
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
