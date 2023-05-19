import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              title: Text(
                userData['username'],
                style: const TextStyle(
                  fontFamily: 'FjallaOne',
                  fontSize: 40,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              children: [],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.orange,
              heroTag: 'signOut',
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout),
            ),
          );
  }
}
