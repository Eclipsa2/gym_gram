import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:gym_gram/widgets/WorkoutsList.dart';
import 'models/Workout.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Gram',
      home: MyWorkoutsPage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        EditWorkoutPage.routeName: (ctx) => EditWorkoutPage(),
        // '/EditWorkout': (context) => EditExer()
      });
  }
}

class MyWorkoutsPage extends StatefulWidget {
  const MyWorkoutsPage({super.key});

  @override
  State<MyWorkoutsPage> createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  List <Workout> _userWorkouts =[];

  void _addWorkout() {
    final newWorkout = Workout(
      id: DateTime.now().toString(),
      workoutName: 'Workout #' + (_userWorkouts.length + 1).toString(),
      exercises: <Exercise> [],
      start: DateTime.now());

    setState(() {
      _userWorkouts.add(newWorkout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gym Gram")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          WorkoutsList(workouts: _userWorkouts),
          Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    _addWorkout();
                    Navigator.of(context).pushNamed(
                      EditWorkoutPage.routeName, 
                      arguments: _userWorkouts.last
                    );
                  },
                  child: Text("Add workout")))
        ],
      )
    );
  }
}