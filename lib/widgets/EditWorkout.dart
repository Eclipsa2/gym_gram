import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import '../models/Workout.dart';
import './AddExercise.dart';
//Initialization of Muscles enum:

class EditWorkoutPage extends StatefulWidget {
  static const routeName = '/EditWorkout';

  @override
  _EditWorkoutPageState createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  List<Exercise> _workoutExercises = [];

  void __addExercise(String exerciseName, Muscles mainMuscle,
      List<Enum> secondaryMuscles, List<WorkingSet> workingSets) {
    final newExercise = Exercise(
        id: DateTime.now().toString(),
        exerciseName: exerciseName,
        mainMuscle: mainMuscle,
        secondaryMuscles: secondaryMuscles,
        workingSets: workingSets);

    setState(() {
      _workoutExercises.add(newExercise);
    });
  }

  void __addNewExerciseMenu(BuildContext cnt) {
    showModalBottomSheet(
        context: cnt,
        builder: (builderContext) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior
                .opaque, // tapping on the modal sheet wont close it
            child: AddExercise(actionHandler: __addExercise),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context)?.settings.arguments as Workout;

    // AppBar menu
    final appBar = AppBar(
      title: Text(workout.workoutName),
      actions: <Widget>[
        IconButton(
          onPressed: () => __addNewExerciseMenu(context), 
          icon: Icon(Icons.add)
        )
      ],
    );

    final exerciseListContainer = Container(
      child: ExerciseHistory(),
    );

    return Scaffold(
      appBar: appBar,
      body: Placeholder(),
    );
  }
}
