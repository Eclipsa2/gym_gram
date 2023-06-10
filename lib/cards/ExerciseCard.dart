import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkoutExercise.dart';
import 'package:intl/intl.dart';
import 'WorkingSets.dart';

class ExerciseCard extends StatelessWidget {
  final DocumentSnapshot exercise;
  final bool editable;
  ExerciseCard({required this.exercise, required this.editable});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    exercise['exerciseName'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                  // adding the sets
                  // exercise.id = FK

                  SingleChildScrollView(
                    child: WorkingSets(
                      exerciseId: exercise.id,
                      editable: editable,
                    ),
                  ),
              ],
            ),     
      ),
    );
  }
}
