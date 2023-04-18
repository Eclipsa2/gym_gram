import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/cards/ExerciseCard.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import '../models/Workout.dart';
import './AddExercise.dart';
import './ExerciseHistory.dart';
import '../models/WorkoutExercise.dart';
//Initialization of Muscles enum:

class EditWorkoutPage extends StatefulWidget {
  static const routeName = '/EditWorkout';

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  List<WorkoutExercise> _workoutExercises = [];

  void _addExercise(Exercise exercise) {
    final newExercise = WorkoutExercise(exercise: exercise, workingSets: [WorkingSet(reps: 0, weight: 0)]);

    setState(() {
      _workoutExercises.add(newExercise);
    });
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

  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context)?.settings.arguments as DocumentSnapshot;

    final CollectionReference _exercises = FirebaseFirestore.instance.collection('exercises');

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

    final exerciseListContainer = Container(
      child: ExerciseList(exercises: _workoutExercises),
    );

    return Scaffold(
      appBar: appBar,
      body: 
      _workoutExercises.isNotEmpty ?
      ListView.builder(itemBuilder: (context, index) {
        final workout = _workoutExercises[index];
        return ExerciseCard(exercise: workout);
      }, itemCount: _workoutExercises.length,) :
      Placeholder(),
    );
  }
}
