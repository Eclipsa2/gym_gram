import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/cards/CommentCard.dart';
import 'package:gym_gram/resources/firestore_methods.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  final String uid;
  const CommentsScreen({required this.postId, required this.uid, super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  var comments;
  var user;
  var commentsIds;
  var post;
  bool loading = true;
  late String currentUserPhoto;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    var currentUserSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();
    currentUserPhoto = currentUserSnap['photoUrl'];
    user = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();
    post = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .get();
    var commentsIds = post['comms'];

    if (commentsIds.isNotEmpty) {
      QuerySnapshot commentsSnap = await FirebaseFirestore.instance
          .collection('comments')
          .where('commentId', whereIn: commentsIds)
          .orderBy('date', descending: false)
          .get();
      comments = commentsSnap.docs;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Comments'),
            ),
            body: loading
                ? const LinearProgressIndicator(
                    color: Colors.orange,
                  )
                : Stack(children: [
                    comments == null || comments.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              var comment = comments[index].data();
                              if (comment['uid'] == currentUserId ||
                                  post['uid'] == currentUserId) {
                                return 
                                GestureDetector(
                                  onLongPress: () {
                                    FirestoreMethods().deleteComment(comment['commentId'], widget.postId);
                                    setState(() {
                                      fetchData();
                                    });
                                  },
                                  child: CommentCard(
                                      comment: comment, editable: true),
                                );
                              } else {
                                return CommentCard(
                                    comment: comment, editable: false);
                              }
                            }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height:
                            50, // Set the desired height of the floating container
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(currentUserPhoto),
                                  ),
                                )),
                            Flexible(
                              flex: 6,
                              child: Container(
                                child: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Comment',
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () async {
                                    await FirestoreMethods().comment(
                                        widget.postId,
                                        currentUserId,
                                        commentController.text);
                                    setState(() {
                                      commentController.clear();
                                      fetchData();
                                    });
                                  },
                                  child: Icon(
                                    Icons.insert_comment_outlined,
                                    size: 30,
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ])),
      ],
    );
  }
}
