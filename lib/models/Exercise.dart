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

  Exercise(
      {
      required this.id,
      required this.exerciseName,
      required this.mainMuscle,
      required this.secondaryMuscles});

  get enumValue => null;

  String getExerciseName() {
    return exerciseName;
  }
}
