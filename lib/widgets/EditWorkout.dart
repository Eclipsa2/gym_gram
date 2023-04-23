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

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  List<WorkoutExercise> _workoutExercises = [];

  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context)?.settings.arguments as DocumentSnapshot;

    final CollectionReference _exercises = FirebaseFirestore.instance.collection('exercises');

    Future<void> _addExercise(Exercise exercise) {
      return _exercises.add(
        {
          'exerciseName': exercise.exerciseName,
          'muscle': exercise.mainMuscle.toJson(),
          'workoutId': workout.id,
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
      title: Text(workout['workoutName']),
      actions: <Widget>[
        IconButton(
          onPressed: () => _addNewExerciseMenu(context), 
          icon: Icon(Icons.add)
        )
      ],
    );


    return Scaffold(
      appBar: appBar,
      body: StreamBuilder<QuerySnapshot>(
        stream: _exercises.snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          if(snapshot.hasData)
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ExerciseList(
                  exercises: snapshot.data!.docs
                    .where((exercise) => exercise.get('workoutId') == workout.id)
                    .toList(), 
                )
              ],
            );
          } else {
            return CircularProgressIndicator.adaptive();
          }
        },
      )
      // _workoutExercises.isNotEmpty ?
      // ListView.builder(itemBuilder: (context, index) {
      //   final workout = _workoutExercises[index];
      //   return ExerciseCard(exercise: workout);
      // }, itemCount: _workoutExercises.length,) :
      // Placeholder(),
    );
  }
}
