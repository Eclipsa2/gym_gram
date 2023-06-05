import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/resources/firestore_methods.dart';
import 'package:gym_gram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../cards/WorkoutCard.dart';
import 'EditWorkout.dart';
import 'WorkoutsList.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int selectedIndex = -1;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late QuerySnapshot _workouts;
  var workouts;
  var _file;
  late String selectedWorkoutId;
  bool loading = false;
  bool posted = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    _workouts = await FirebaseFirestore.instance
        .collection('workouts')
        .where('userId', isEqualTo: currentUser?.uid)
        .get();
    workouts = _workouts.docs.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _workouts =
        FirebaseFirestore.instance.collection('workouts');

    final User? currentUser = FirebaseAuth.instance.currentUser;

    void post(String uid, String workoutId) async {
      setState(() {
        loading = true;
      });
      String res = 'Some error';
      try {
        res = await FirestoreMethods().uploadPost(_file, uid, workoutId);
        setState(() {
          loading = false;
          posted = true;
        });
      } catch (e) {
        res = e.toString();
        setState(() {
          loading = false;
        });
      }
    }

    _selectImage(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Upload image'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    var file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Select a photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    var file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add a new post',
          style: TextStyle(fontFamily: 'FjallaOne', fontSize: 35),
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
              onPressed: () => post(
                    currentUser!.uid,
                    selectedWorkoutId,
                  ),
              child: const Text('Post',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      body: posted == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: const Icon(
                      Icons.verified_rounded,
                      size: 150,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: const Text(
                      'Posted successfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'FjallaOne',
                      ),
                    ),
                  ),
                ])
          : Column(
              children: [
                loading == true
                    ? const LinearProgressIndicator(
                        color: Colors.orange,
                      )
                    : Container(),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: const Center(
                    child: Text('Select a photo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                Container(
                  height: 300,
                  child: _file == null
                      ? Center(
                          child: GestureDetector(
                            onTap: () => _selectImage(context),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 100,
                            ),
                          ),
                        )
                      : Image.memory(_file!),
                ),
                Container(
                  height: 80,
                  child: const Center(
                      child: Text(
                    'Choose a workout:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
                ),
                workouts == null
                    ? const LinearProgressIndicator(
                        color: Colors.orange,
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: workouts.length,
                          itemBuilder: (context, index) {
                            //* DocumentSnapshot contains the rows of the workout table
                            DocumentSnapshot workout = workouts[index];

                            // var updated_workout=workout;
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedWorkoutId = workout['id'];
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    Dismissible(
                                        key: Key(workout.id),
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: selectedIndex == index
                                                  ? Colors.orange
                                                  : Colors.transparent,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: WorkoutCard(workout: workout),
                                        )),
                                  ],
                                ));
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
