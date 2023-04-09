import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:gym_gram/widgets/WorkoutsList.dart';
import 'models/Workout.dart';
import 'package:gym_gram/widgets/AddExerciseForm.dart';

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
        home: WorkoutsPage(),
        routes: <String, WidgetBuilder>{
          '/AddWorkout': (context) => AddExercisePage()
        });
  }
}

class WorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Gym Gram")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            WorkoutsList(),
            Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/AddWorkout");
                    },
                    child: Text("Add workout")))
          ],
        ));
  }
}
