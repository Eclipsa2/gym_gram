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
  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  exercise['exerciseName'],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 400, // adjust the width as needed

                // adding the sets
                // exercise.id = FK

                child: SingleChildScrollView(
                  child: WorkingSets(
                    exerciseId: exercise.id,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
