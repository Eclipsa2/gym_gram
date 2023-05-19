import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'WorkoutsList.dart';

class MyWorkoutsPage extends StatefulWidget {
  const MyWorkoutsPage({super.key});

  @override
  State<MyWorkoutsPage> createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final CollectionReference _workouts =
        FirebaseFirestore.instance.collection('workouts');

    int numberOfWorkouts = 0;

    _workouts.snapshots().listen((QuerySnapshot snapshot) {
      numberOfWorkouts = snapshot.docs.length + 1;
    });

    // this function adds workout object to firestore
    Future<void> _addWorkout() {
      return _workouts
          .add({
            'id': DateTime.now()
                .toString(), // ID which is exact date when the workout was added
            'workoutName':
                'Workout #${(numberOfWorkouts).toString()}', // Workout #1, 2, etc...
            'start': DateTime.now(),
            'length': 0,
            'userId': currentUser?.uid,
          })
          .then((value) => print("DBG: Workout Added!"))
          .catchError((onError) => print("Failed to add workout: ${onError}"));
    }

    Future<void> _delete(String workoutId) async {
      final CollectionReference _workoutExercises =
          FirebaseFirestore.instance.collection('workoutExercises');
      final CollectionReference _workingSets =
          FirebaseFirestore.instance.collection('workingSets');

      // Query all exercises with the workoutId to be deleted
      final QuerySnapshot exerciseSnapshot = await _workoutExercises
          .where('workoutId', isEqualTo: workoutId)
          .get();

      // delete each exercise document
      exerciseSnapshot.docs.forEach((element) async {
        // Query all the workingSets to be deleted
        final QuerySnapshot workingSetsSnapshot =
            await _workingSets.where('exerciseId', isEqualTo: element.id).get();

        // delete each workingSet document
        workingSetsSnapshot.docs.forEach((workingSetElement) async {
          await workingSetElement.reference.delete();
        });

        // delete the exercise document
        await _workoutExercises.doc(element.id).delete();
      });

      await _workouts.doc(workoutId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout deleted successfully!')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Workouts",
          style: TextStyle(fontFamily: 'FjallaOne', fontSize: 40),
        ),
      ),

      // StreamBuilder helps keeping persistent connection with firestore database
      body: StreamBuilder<QuerySnapshot>(
          stream: _workouts.orderBy('start', descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (snapshot.hasError) {
            //   return Text('Something went wrong');
            // }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //* Passing all the rows of _workouts to be displayed as list
                  WorkoutsList(
                    workouts: snapshot.data!.docs
                        .where((workout) =>
                            workout.get('userId') == currentUser?.uid)
                        .toList(),
                    deleteHandler: _delete,
                  ),
                ],
              );
            } else {
              // Handle the snapshot loading state
              return CircularProgressIndicator.adaptive();
            }
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.orange,
            heroTag: 'addWorkout',
            onPressed: () async {
              await _addWorkout();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}