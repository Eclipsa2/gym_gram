import 'package:flutter/material.dart';

import 'WorkingSet.dart';

//Exercise class contains the name of the exercise performed by the user,
//the muscle groups the exercise targets and a list of WorkingSets

enum Muscles {
  Abdominals,
  Abductors,
  Adductors,
  Biceps,
  Calves,
  Chest,
  Forearms,
  Glutes,
  Hamstrings,
  Lats,
  LowerBack,
  Quadriceps,
  Shoulders,
  Traps,
  Triceps,
  UpperBack,
  Other
}

class Exercise {
  final String id;
  final String exerciseName;
  final Enum mainMuscle;
  List<Enum> secondaryMuscles;
  List<WorkingSet> workingSets;

  Exercise(
      {
      required this.id,
      required this.exerciseName,
      required this.mainMuscle,
      required this.secondaryMuscles,
      required this.workingSets});

  get enumValue => null;

  void addSet(int reps, weight) {
    WorkingSet aux = new WorkingSet(reps: reps, weight: weight);
    workingSets.add(aux);
  }

  List<WorkingSet> getSets() {
    return this.workingSets;
  }

  int getTotalSets() {
    int totalSets = 0;

    for (int i = 0; i < workingSets.length; ++i) {
      totalSets++;
    }

    return totalSets;
  }

  int getTotalExerciseWeight() {
    int totalWeight = 0;

    for (int i = 0; i < workingSets.length; ++i) {
      totalWeight += workingSets.elementAt(i).getWeight();
    }

    return totalWeight;
  }

  String getExerciseName() {
    return exerciseName;
  }
}
