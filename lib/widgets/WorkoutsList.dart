import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:intl/intl.dart';
import '../models/Workout.dart';

class WorkoutsList extends StatefulWidget {
  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
  @override
  Widget build(BuildContext context) {
    //Workouts initialization for testing purposes
    List<Workout> workouts = [];
    List<Exercise> exercises = [];
    List<WorkingSet> sets = [
      WorkingSet(reps: 20, weight: 80),
      WorkingSet(reps: 30, weight: 60)
    ];

    exercises.add(Exercise(
        exerciseName: "Bench Press",
        mainMuscle: Muscles.Chest,
        secondaryMuscles: [Muscles.Triceps, Muscles.Shoulders],
        workingSets: sets));

    workouts.add(Workout(
        workoutName: "Push",
        exercises: exercises,
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(minutes: 60))));

    workouts.add(Workout(
        workoutName: "Pull",
        exercises: exercises,
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(minutes: 60))));

    return Column(
      children: workouts.map((workout) {
        return Card(
          child: Row(children: <Widget>[
            Container(
              height: 150,
              width: 130,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  workout.getWorkoutName(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        workout.getTotalSets().toString() + " Sets",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('yMd').format(workout.start),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Total Weight: " + workout.getTotalWeight().toString() + " kg",
              ),
            )
          ]),
        );
      }).toList(),
    );
  }
}
