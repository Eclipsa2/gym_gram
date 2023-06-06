import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cards/ExerciseCard.dart';
import 'ExerciseList.dart';

class WorkoutDetail extends StatelessWidget {
  final DocumentSnapshot workout;
  const WorkoutDetail({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final CollectionReference _exercises =
        FirebaseFirestore.instance.collection('workoutExercises');
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text(
            workout['workoutName'],
          ),
          backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 10), // Adjust blur intensity
              child: Container(
                color: Colors.black
                    .withOpacity(0.3), // Adjust the opacity of the background
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _exercises.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }

              if (snapshot.hasData) {
                var exercises = snapshot.data!.docs
                    .where((exercise) =>
                        exercise.get('workoutId') == workout.get("id"))
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return ExerciseCard(exercise: exercise, editable: false,);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator.adaptive();
              }
            },
          ),
        ],
      ),
    );
  }
}
