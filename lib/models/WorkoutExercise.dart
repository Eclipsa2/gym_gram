import './Exercise.dart';
import './WorkingSet.dart';

class WorkoutExercise {
  Exercise exercise;
  List<WorkingSet> workingSets;

  WorkoutExercise({required this.exercise, required this.workingSets});

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


}