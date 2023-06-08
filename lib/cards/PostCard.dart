import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/cards/WorkoutCard.dart';
import 'package:gym_gram/utils/utils.dart';
import 'package:gym_gram/widgets/WorkoutDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/UserProfileScreen.dart';

class PostCard extends StatefulWidget {
  final String uid;
  final String photoUrl;
  final String workoutId;
  const PostCard(
      {required this.uid,
      required this.photoUrl,
      required this.workoutId,
      super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String username = '';
  late DocumentSnapshot workout;
  String profilePicUrl = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: widget.uid)
          .limit(1)
          .get();
      var userData =
          userQuerySnapshot.docs.first.data() as Map<String, dynamic>?;
      String usernameGet = userData!['username'];
      String profilePicUrlGet = userData['photoUrl'];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('workouts')
          .where('id', isEqualTo: widget.workoutId)
          .get();
      DocumentSnapshot workout_snapshot = querySnapshot.docs.first;

      var userDataa =
          userQuerySnapshot.docs.first.data() as Map<String, dynamic>?;
      //print('userData: $userDataa');

      if (mounted) {
        setState(() {
          username = usernameGet;
          workout = workout_snapshot;
          profilePicUrl = profilePicUrlGet;
        });
      }
    } catch (err) {
      print(err.toString() + ' EROARE');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(screenWidth);
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        LayoutBuilder(builder: (context, constraints) {
          // final screenWidth = constraints.maxWidth;
          // final screenHeight = constraints.maxHeight;
          // final scalingFactor = 0.5; // Adjust the scaling factor as needed
          // final containerHeight = screenWidth * scalingFactor;
          print(screenHeight);
          return Card(
              color: Color.fromARGB(0, 0, 0, 0),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 0, 0, 0),
                  border: Border.all(color: Colors.black54, width: 0.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),

                height: screenHeight * 0.77,
                // padding: EdgeInsets.only(left: 20, right: 20),
                child: (profilePicUrl == '')
                    ? SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 25,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfile(uid: widget.uid),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 17,
                                      backgroundImage:
                                          NetworkImage(profilePicUrl),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 7),
                                      child: Text(
                                        username,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 4 / 5,
                            child: CachedNetworkImage(
                              imageUrl: widget.photoUrl,
                              placeholder: (context, url) =>
                                  Container(height: 10, width: 10, alignment: Alignment.center, child: const CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            // Image(
                            //   fit: BoxFit.cover,
                            //   image: NetworkImage(
                            //     widget.photoUrl,
                            //   ),
                            // ),
                          ),
                          GestureDetector(
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
                                      Animation<double> secondaryAnimation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: WorkoutDetail(workout: workout),
                                    );
                                  },
                                ),
                              );
                            },
                            child:
                                Container(child: WorkoutCard(workout: workout)),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 10),
                            child: Row(children: [
                              Container(
                                child: Icon(Icons.heart_broken, size: 30),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.comment_rounded, size: 30),
                              )
                            ]),
                          )
                        ],
                      ),
              ));
        }),
      ],
    );
  }
}
