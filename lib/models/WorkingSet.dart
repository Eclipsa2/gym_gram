// ignore: file_names
import 'package:flutter/foundation.dart';

//WorkingSet class which holds the number of reps and the weight for an exercise

class WorkingSet {
  int reps;
  int weight;

  WorkingSet({
    required this.reps,
    required this.weight,
  });

  int getReps() {
    return reps;
  }

  void setReps(int reps) {
    this.reps = reps;
  }

  int getWeight() {
    return weight;
  }

  void setWeight(int weight) {
    this.weight = weight;
  }
}
