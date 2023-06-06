import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/firestore_methods.dart';
import 'package:gym_gram/widgets/PostDetail.dart';

import '../cards/MyProfileCard.dart';
import '../cards/PostCard.dart';

class MyProfile extends StatefulWidget {
  final String uid;
  const MyProfile({Key? key, required this.uid}) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
    return Stack(children: [
      Container( 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'FjallaOne',
              fontSize: 35,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 158,
                    child: MyProfileCard(userData: userData),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var posts = (snapshot.data!).docs.toList();
                      posts.sort((a, b) => b['date'].compareTo(a['date']));
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1,
                            ),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot post = posts[index];
                              return GestureDetector(
                                onLongPress: () async {
                                  await FirestoreMethods().deletePost(post['postId']);
                                  setState(() {                                   
                                  });
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 200),
                                      opaque: false,
                                      pageBuilder: (context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: PostDetail(post: post),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(post['photoUrl']),
                                  ),
                                ),
                              );
                            }),
                        // child: ListView.builder(
                        //     itemCount: snapshot.data!.docs.length,
                        //     itemBuilder: (context, index) {
                        //       DocumentSnapshot post = posts[index];
                        //       return post['uid'] == widget.uid
                        //           ? PostCard(
                        //               uid: post['uid'],
                        //               photoUrl: post['photoUrl'],
                        //               workoutId: post['workoutId'],
                        //             )
                        //           : Container();
                        //     }),
                      );
                    },
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          heroTag: 'signOut',
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Icon(Icons.logout),
        ),
      ),
    ]);
  }
}
