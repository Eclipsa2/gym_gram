import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_gram/resources/storage_methods.dart';

import '../models/Post.dart';
import '../models/Comment.dart';

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
          workoutId: workoutId,
          likes: [],
          comms: []);
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Follow a user
  Future<void> followUser(String uid, String followedId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followedId)) {
        await _firestore.collection('users').doc(followedId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followedId])
        });
      } else {
        await _firestore.collection('users').doc(followedId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followedId])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  //Like a post
  Future<void> like(postId, uid) async
  {
    try{
      DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
      
      List likes = (snap.data()! as dynamic)['likes'];
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });       
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    }
    catch (err) {
      print(err.toString());
    }
  }

  //Comment on a post
  Future<void> comment(postId, uid, comment) async {
    try{
      String commentId = uid + DateTime.now().toString();
      Comment comm = Comment(
        commentId: commentId,
        comment: comment,
        uid: uid,
        postId: postId,
        date: DateTime.now()
      );
      _firestore.collection('comments').doc(commentId).set(
            comm.toJson(),
          );
      await _firestore.collection('posts').doc(postId).update({
          'comms': FieldValue.arrayUnion([commentId])
        });       
    }
    catch(err)
    {print(err.toString());}
  }

  //Delete a post
  Future <void> deletePost(String postId) async
  {
    try {
    // Get a reference to the document you want to delete
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId);
    DocumentSnapshot snap = await documentRef.get();
    // Delete the document
    await StorageMethods().deleteFile(snap['photoUrl']);
    await documentRef.delete();

    print('Document deleted successfully');
  } catch (err) {
    print('Error deleting document: $err');
  }
  }

  Future<void> deleteComment(String commId, String postId) async
  {
    try {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('comments')
        .doc(commId);
    await documentRef.delete();
       
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
    List comms = (snap.data()! as dynamic)['comms'];
    await _firestore.collection('posts').doc(postId).update({
      'comms': FieldValue.arrayRemove([commId])
    });    
    print('Document deleted successfully');
  } catch (err) {
    print('Error deleting document: $err');
  }
  }
}
