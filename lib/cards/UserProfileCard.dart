import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/firestore_methods.dart';
import 'package:gym_gram/resources/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gym_gram/utils/utils.dart';

class UserProfileCard extends StatefulWidget {
  var userData = {};
  UserProfileCard({required this.userData});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  late String username = widget.userData['username'];
  late String url = widget.userData['photoUrl'];
  bool following = false;
  bool loading = false;
  int followersNr = 0;
  int followingNr = 0;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      loading = true;
    });
    following = widget.userData['followers']
        .contains(FirebaseAuth.instance.currentUser!.uid);
    followersNr = widget.userData['followers'].length;
    followingNr = widget.userData['following'].length;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? const LinearProgressIndicator(color: Colors.orange)
        : Card(
            child: Container(
              height: 190,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          alignment: Alignment.center,
                          //padding: EdgeInsets.only(top: 12, left: 20),
                          height: 150,
                          child: url == ""
                              ? const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      "https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg"),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      // MemoryImage(_image!),
                                      NetworkImage(url),
                                ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          width: 250,
                          child: Column(
                            children: <Widget>[
                              Text(
                                username,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: const Text(
                                          'Followers',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          followersNr.toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        child: const Text(
                                          'Following',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          followingNr.toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  FirebaseAuth.instance.currentUser!.uid ==
                          widget.userData['uid']
                      ? Container()
                      : Container(
                          height: 30,
                          child: GestureDetector(
                              onTap: () async {
                                await FirestoreMethods().followUser(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    widget.userData['uid']);
                                setState(() {
                                  if (following) {
                                    followersNr--;
                                  } else {
                                    followersNr++;
                                  }
                                  following = !following;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                width: 200,
                                child: following == true
                                    ? const Text(
                                        'Unfollow',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      )
                                    : const Text(
                                        'Follow',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                              )),
                        )
                ],
              ),
            ),
          );
  }
}
