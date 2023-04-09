import 'package:flutter/material.dart';
import 'package:gym_gram/cards/WorkoutCard.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:intl/intl.dart';
import '../models/Workout.dart';


class WorkoutsList extends StatelessWidget {
  final List<Workout> workouts;

  WorkoutsList({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                EditWorkoutPage.routeName,
                arguments: workouts[index],
              );
            },
            child: WorkoutCard(workout: workouts[index]),
          );
        },
        itemCount: workouts.length,
      ),
    );
    // return Column(
    //   children: workouts.map((workout) {
    //     return WorkoutCard(workout: workout);
    //   }).toList(),
    // );
  }
}