import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cards/UserProfileCard.dart';
import 'PostDetail.dart';

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
    return 
    Stack(children: [
      Container( 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
    loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          backgroundColor: Colors.transparent,
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
            body: Column(
              children: <Widget>[
                UserProfileCard(userData: userData),
                const SizedBox(height: 20,),
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
                            itemBuilder: (context, index){
                              DocumentSnapshot post = posts[index];
                              return  
                              GestureDetector(
                                onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                            reverseTransitionDuration: const Duration(milliseconds: 200),
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
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      post['photoUrl']
                                    ),
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
          )],
    );
  }
}
