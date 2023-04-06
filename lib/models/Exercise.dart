import 'package:flutter/material.dart';

import 'WorkingSet.dart';

//Exercise class contains the name of the exercise performed by the user,
//the muscle groups the exercise targets and a list of WorkingSets

class Exercise {
  final String exerciseName;
  final Enum mainMuscle;
  List<Enum> secondaryMuscles;
  List<WorkingSet> workingSets;

  Exercise(
      {required this.exerciseName,
      required this.mainMuscle,
      required this.secondaryMuscles,
      required this.workingSets});

  void addSet(int reps, weight) {
    WorkingSet aux = new WorkingSet(reps: reps, weight: weight);
    workingSets.add(aux);
  }

  List<WorkingSet> getSets() {
    return this.workingSets;
  }

  int getTotalExerciseWeight() {
    int totalWeight = 0;

    for (int i = 0; i < workingSets.length; ++i) {
      totalWeight += workingSets.elementAt(i).getWeight();
    }

    return totalWeight;
  }
}
