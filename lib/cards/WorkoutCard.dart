import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gym_gram/utils/utils.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatefulWidget {
  final DocumentSnapshot workout;

  WorkoutCard({required this.workout});

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  int nr_sets = 0;
  int weight = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    int nr_rows;
    QuerySnapshot exercises = await FirebaseFirestore.instance
        .collection('workoutExercises')
        .where('workoutId', isEqualTo: widget.workout['id'])
        .get();

    List<String> exerciseIds = exercises.docs.map((doc) => doc.id).toList();

    if (exerciseIds.isNotEmpty) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('workingSets')
          .where('exerciseId', whereIn: exerciseIds)
          .get();
      nr_rows = querySnapshot.size;
    } else {
      nr_rows = 0;
    }

    int totalWeight = 0;
    if (exerciseIds.isNotEmpty) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('workingSets')
          .where('exerciseId', whereIn: exerciseIds)
          .get();

      for (var document in querySnapshot.docs) {
        int currentWeight =
            ((document.data() as Map<String, Object?>)['weight'] as int? ?? 0) *
                ((document.data() as Map<String, Object?>)['reps'] as int? ??
                    0);
        totalWeight += currentWeight;
      }
    }

    if (mounted) {
      setState(() {
        nr_sets = nr_rows;
        weight = totalWeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.workout['workoutName'],
                  overflow: TextOverflow.ellipsis,
                  //  workout.workoutName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 1/screenHeight*18000,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  DateFormat('yMd').format(widget.workout['start'].toDate()),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Total sets:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    nr_sets.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Total weight:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    weight.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
