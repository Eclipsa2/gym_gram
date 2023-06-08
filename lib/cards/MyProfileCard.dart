import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gym_gram/utils/utils.dart';

class MyProfileCard extends StatefulWidget {
  var userData = {};
  MyProfileCard({required this.userData});

  @override
  State<MyProfileCard> createState() => _MyProfileCardState();
}

class _MyProfileCardState extends State<MyProfileCard> {
  late String username = widget.userData['username'];
  late TextEditingController _usernameController =
      TextEditingController(text: widget.userData['username']);
  late String url = widget.userData['photoUrl'];
  int followersNr = 0;
  int followingNr = 0;

  void selectImage() async {
    var im = await pickImage(ImageSource.gallery);
    if (im != null) {
      String img_url =
          await StorageMethods().uploadImageToStorage('profilePics', im, false);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userData['uid'])
          .update({'photoUrl': img_url});
      setState(() {
        url = img_url;
      });
    }
  }

  void _showEditUsernameDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change username'),
            content: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Enter new username',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
              TextButton(
                child: const Text('SAVE'),
                onPressed: () async {
                  final newUsername = _usernameController.text;
                  //update the username in the firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userData['uid'])
                      .update({'username': newUsername});
                  setState(() {
                    username = newUsername;
                  });
                  // close the dialog
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(deviceFontSize);
    followersNr = widget.userData['followers'].length;
    followingNr = widget.userData['following'].length;
    return Card(
      color: Colors.transparent,
      elevation: 5,
      child: Container(
        height: 150,
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
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: CachedNetworkImageProvider(
                          url,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              size: 35,
                              Icons.change_circle_outlined,
                            ),
                          )),
                    ]),
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
                    width: 250,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _showEditUsernameDialog(context),
                          child: Text(
                            username,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Text(
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
                                  child: Text(
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
          ],
        ),
      ),
    );
  }
}
