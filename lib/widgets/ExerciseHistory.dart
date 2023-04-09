import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/models/WorkoutExercise.dart';
import '../cards/ExerciseCard.dart';

class ExerciseList extends StatelessWidget {
  final List<WorkoutExercise> exercises;

  ExerciseList({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
            child: ExerciseCard(exercise: exercises[index]);
        },
        itemCount: exercises.length,
      ),
    );
  }
}