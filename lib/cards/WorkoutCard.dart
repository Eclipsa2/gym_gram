import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  WorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Row(children: <Widget>[
            Container(
              height: 150,
              width: 130,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  workout.workoutName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        workout.getTotalSets().toString() + " Sets",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('yMd').format(workout.start),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Total Weight: " + workout.getTotalWeight().toString() + " kg",
              ),
            )
          ]),
        );
  }
}