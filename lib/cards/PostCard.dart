import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/cards/WorkoutCard.dart';

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

      if (mounted) {
        setState(() {
          username = usernameGet;
          workout = workout_snapshot;
          profilePicUrl = profilePicUrlGet;
        });
      }
    } catch (err) {
      print(err.toString() + 'EROARE');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        (profilePicUrl == '')
            ? const LinearProgressIndicator(color: Colors.orange)
            : Card(
                color: Color.fromARGB(0, 0, 0, 0),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 0, 0, 0),
                    border: Border.all(color: Colors.black54, width: 0.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                  height: 660,
                  // padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
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
                                  backgroundImage: NetworkImage(profilePicUrl),
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
                      Container(
                        width: double.infinity,
                        //height: 400,
                        child: AspectRatio(
                          aspectRatio: 4 / 5,
                          child:
                              Image.network(fit: BoxFit.cover, widget.photoUrl),
                        ),
                      ),
                      Container(
                          height: 80, child: WorkoutCard(workout: workout)),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 10),
                        height: 20,
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
                )),
      ],
    );
  }
}
