// ignore: file_names
import 'Exercise.dart';

//Workout class contains some general stats regarding the workout performed by
//the user and a list of the exercises done. It also contains start time of the
//workout and the end time

class Workout {
  late int totalSets;
  late int totalWeight;
  late List<Exercise> exercises;
  late DateTime start;
  late DateTime end;
  late DateTime length;

  Workout() {
    totalSets = 0;
    totalWeight = 0;
    exercises = [];
    start = DateTime.now();
    end = DateTime.now();
    length = DateTime(0, 0, 60);
  }

  void addExercise(Exercise aux) {
    exercises.add(aux);

    totalSets += aux.getSets().length;
    totalWeight += aux.getTotalExerciseWeight();
  }

  void getWorkoutLength() {
    length = end.difference(start) as DateTime;
  }
}