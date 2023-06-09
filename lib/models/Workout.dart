// ignore: file_names
import 'package:gym_gram/models/WorkoutExercise.dart';


//Workout class contains some general stats regarding the workout performed by
//the user and a list of the exercises done. It also contains start time of the
//workout and the end time

class Workout {
  final String id;
  String workoutName;
  int totalSets = 0;
  int totalWeight = 0;
  late List<WorkoutExercise> exercises;
  late DateTime start;
  late DateTime end;
  late DateTime length;

  Workout(
      {required this.id,
      required this.workoutName,
      required this.exercises,
      required this.start});

  // void addExercise(Exercise aux) {
  //   exercises.add(aux);

  //   totalSets += aux.getSets().length;
  //   totalWeight += aux.getTotalExerciseWeight();
  // }

  String get getworkoutName {
    return workoutName;
  }
  void getWorkoutLength() {
    length = end.difference(start) as DateTime;
  }

  // String getWorkoutName() {
  //   return workoutName;
  // }

  int getTotalSets() {
    int totalSets = 0;

    for (WorkoutExercise e in exercises) {
      totalSets += e.getTotalSets();
    }

    return totalSets;
  }

  int getTotalWeight() {
    int totalWeight = 0;

    for (WorkoutExercise e in exercises) {
      totalWeight += e.getTotalExerciseWeight();
    }

    return totalWeight;
  }
}
