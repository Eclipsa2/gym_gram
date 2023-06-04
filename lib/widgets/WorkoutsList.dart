import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/cards/WorkoutCard.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';

class WorkoutsList extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> workouts;

  final Function deleteHandler;

  WorkoutsList({required this.workouts, required this.deleteHandler});

  @override
  State<WorkoutsList> createState() => WorkoutsListState();
}

class WorkoutsListState extends State<WorkoutsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.workouts.length,
        itemBuilder: (context, index) {
          //* DocumentSnapshot contains the rows of the workout table
          DocumentSnapshot workout = widget.workouts[index];

          // var updated_workout=workout;
          return GestureDetector(
              onTap: () {
                final result = Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditWorkoutPage(workout: workout)),
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
                        widget.deleteHandler(workout.id);
                      },
                      child: WorkoutCard(workout: workout)),
                ],
              ));
        },
      ),
    );
  }
}
