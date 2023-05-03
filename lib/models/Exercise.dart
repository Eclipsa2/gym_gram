import 'package:flutter/material.dart';
import 'WorkingSet.dart';
import 'package:json_annotation/json_annotation.dart';
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
  Other;

  // firebase nu stie de json, transformam in string
  String toJson() => name;
  static Muscles fromJson(String json) => values.byName(json);
}

class Exercise {
  final String id;
  final String exerciseName;
  final Muscles mainMuscle;
  List<Muscles> secondaryMuscles;

  Exercise(
      {
      required this.id,
      required this.exerciseName,
      required this.mainMuscle,
      required this.secondaryMuscles});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: DateTime.now().toString(), 
      exerciseName: json['exerciseName'], 
      mainMuscle: Muscles.fromJson(json['mainMuscle']), 
      secondaryMuscles: <Muscles>[],
    );
  }
  // get enumValue => null;

  // String getExerciseName() {
  //   return exerciseName;
  // }
}
