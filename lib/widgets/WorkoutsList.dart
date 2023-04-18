import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/cards/WorkoutCard.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:intl/intl.dart';
import '../models/Workout.dart';


class WorkoutsList extends StatelessWidget {
  
  final List<QueryDocumentSnapshot<Object?>> workouts;

  final Function deleteHandler;

  WorkoutsList({required this.workouts, required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          //* DocumentSnapshot contains the rows of the workout table
          final DocumentSnapshot workout = workouts[index];
          
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                EditWorkoutPage.routeName,
                arguments: workout,
              );
            },
            child: Column(
              children: <Widget>[
                Dismissible(
                  key: Key(workout.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    deleteHandler(workout.id);
                  },
                  child: WorkoutCard(workout: workout)
                ),
              ],
            )
          );
        },
      ),
    );
  }
}