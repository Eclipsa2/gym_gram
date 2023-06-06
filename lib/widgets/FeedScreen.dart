import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../cards/PostCard.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  var userData;
  late List following;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    try {
      userData = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: currentUser!.uid)
          .get();

      QueryDocumentSnapshot userSnapshot = userData.docs[0];
      Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
      following = data['following'];
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: loading == true
          ? const LinearProgressIndicator(color: Colors.orange)
          : StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator(
                    color: Colors.orange,
                  );
                }
                var posts = snapshot.data!.docs.toList();
                posts.sort((a, b) => b['date'].compareTo(a['date']));
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot post = posts[index];
                      return following.contains(post['uid'])
                          ? PostCard(
                              uid: post['uid'],
                              photoUrl: post['photoUrl'],
                              workoutId: post['workoutId'],
                            )
                          : Container();
                    });
              },
            ),
      ),
    );
  }
}
