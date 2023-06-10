import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/cards/ExerciseCard.dart';
import 'package:gym_gram/models/Exercise.dart';
import './AddExercise.dart';
import 'ExerciseList.dart';
import '../models/WorkoutExercise.dart';
//Initialization of Muscles enum:

class EditWorkoutPage extends StatefulWidget {
  static const routeName = '/EditWorkout';
  final DocumentSnapshot workout;
  EditWorkoutPage({required this.workout});

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  late TextEditingController _workoutNameController;
  late DocumentSnapshot _workout;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _workout = widget.workout;
    _workoutNameController =
        TextEditingController(text: _workout['workoutName']);
  }

  @override
  void initState() {
    super.initState();
    DocumentSnapshot _workout = widget.workout;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _workout = ModalRoute.of(context)?.settings.arguments as DocumentSnapshot;
  //   _workoutNameController =
  //       TextEditingController(text: _workout['workoutName']);
  // }

  @override
  Widget build(BuildContext context) {
    final CollectionReference _exercises =
        FirebaseFirestore.instance.collection('workoutExercises');

    Future<void> _addExercise(Exercise exercise) {
      return _exercises
          .add({
            'exerciseName': exercise.exerciseName,
            'muscle': exercise.mainMuscle.toJson(),
            'workoutId': _workout.get("id"),
          })
          .then((value) => print("DBG: Exercise added!"))
          .catchError((onError) => print("Failed to add exercise: ${onError}"));
    }

    void _addNewExerciseMenu(BuildContext cnt) {
      showModalBottomSheet(
          context: cnt,
          builder: (builderContext) {
            return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior
                  .opaque, // tapping on the modal sheet wont close it
              child: AddExercise(actionHandler: _addExercise),
            );
          });
    }

    // AppBar menu
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      title: GestureDetector(
        onTap: () => _showEditWorkoutNameDialog(context),
        child: Text(_workout['workoutName']),
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () => _addNewExerciseMenu(context),
            icon: Icon(Icons.add))
      ],
    );

    return WillPopScope(
      onWillPop: () {
        _workout.reference.get().then((value) => Navigator.pop(context, value));
        return Future.value(
            false); // Return false to prevent the default back button behavior
      },
      child: Stack(
        children: [
          Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: StreamBuilder<QuerySnapshot>(
              stream: _exercises.snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }
      
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ExerciseList(
                        exercises: snapshot.data!.docs
                            .where((exercise) =>
                                exercise.get('workoutId') == _workout.get("id"))
                            .toList(),
                      )
                    ],
                  );
                } else {
                  return CircularProgressIndicator.adaptive();
                }
              },
            )),],
      ),
    );
  }

  void _showEditWorkoutNameDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit workout name'),
            content: TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(
                hintText: 'Enter new workout name',
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
                  final newWorkoutName = _workoutNameController.text;
                  // update the workout name in the firestore
                  await _workout.reference
                      .update({'workoutName': newWorkoutName});

                  // getting the reference for the update workout document
                  DocumentSnapshot updatedWorkout =
                      await _workout.reference.get();

                  // calling setState to update the workout immediately
                  setState(() {
                    _workout = updatedWorkout;
                  });
                  // close the dialog
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
