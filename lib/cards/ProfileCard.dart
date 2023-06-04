import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/storage_methods.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCard extends StatefulWidget {
  var userData = {};
  ProfileCard({required this.userData});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late String username = widget.userData['username'];
  late TextEditingController _usernameController =
      TextEditingController(text: widget.userData['username']);
  Uint8List? _image;
  late String url = widget.userData['photoUrl'];
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No image selected');
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
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
    return Card(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.only(top: 12, left: 20),
              height: 150,
              child: Stack(children: [
                // _image == null
                url == ""
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
                Positioned(
                    bottom: 0,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                              '100',
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
                              '1',
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
    );
  }
}
