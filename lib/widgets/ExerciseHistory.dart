import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:flutter/material.dart';
class ExerciseHistory extends StatelessWidget {
  final List<Exercise> exercises;

  ExerciseHistory({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return exercises.isNotEmpty
     ? ListView.builder(
      itemBuilder: (context, index) {
        final exercise = exercises[index];
      },
     )
  }
}