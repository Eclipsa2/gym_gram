import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cards/UserProfileCard.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  const UserProfile({super.key, required this.uid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userData = {};
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = snap.data()!;
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 35,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              children: <Widget>[
                UserProfileCard(userData: userData),
              ],
            ),
          );
  }
}
