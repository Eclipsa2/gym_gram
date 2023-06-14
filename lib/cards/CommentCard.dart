import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/firestore_methods.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final comment;
  final bool editable;
  const CommentCard({required this.comment, required this.editable, super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool loading = true;
  late String photoUrl;
  late String username;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.comment['uid'])
        .get();
    photoUrl = userSnap['photoUrl'];
    username = userSnap['username'];
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          //        height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: loading == true
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(photoUrl))),
                      ),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  username,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              Container(
                                child: Text(
                                  widget.comment['comment'],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Text(
                            DateFormat('yMd')
                                .format(widget.comment['date'].toDate()),
                            style: TextStyle(fontSize: 10,color: Colors.grey[700]),
                          ),
                        ),
                      )
                    ]),
        ),
    );
  }
}
