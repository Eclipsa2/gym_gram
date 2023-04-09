import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkoutExercise.dart';
import 'package:intl/intl.dart';

class ExerciseCard extends StatelessWidget {
  final WorkoutExercise exercise;
  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),

      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Text(
              exercise.exercise.exerciseName,
            ),
          ),
        ],
      ),
    );
  }
}