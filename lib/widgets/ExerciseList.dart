import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../cards/ExerciseCard.dart';

class ExerciseList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> exercises;

  ExerciseList({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ExerciseCard(exercise: exercise, editable: true,);
        },
      ),
    );
  }
}