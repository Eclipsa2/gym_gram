import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/models/Exercise.dart';
import '../models/WorkingSet.dart';

List<Exercise> exercisesInitialization() {
//   List<WorkingSet> startWorkingSets = [];
//   startWorkingSets.add(new WorkingSet(reps: 0, weight: 0));
  //Initialization of some Exercises:
  List<Exercise> exercisesList = [];

  exercisesList.add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Crunches",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: []));
  exercisesList.add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Russian Twists",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: []));
  exercisesList.add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Hip Abduction Machine",
      mainMuscle: Muscles.Abductors,
      secondaryMuscles: []));

  print(exercisesList);
  // Map<Enum, List<Exercise>> exercises = {};
  // //Abdominal Exercises:
  // //Weighted Crunches:
  // exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Weighted Crunches",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));
  // //Weighted Russian Twists:
  // exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Weighted Russian Twists",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));
  // //Abductor Exercises:
  // //Hip Abduction Machine:
  // exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Hip Abduction Machine",
  //     mainMuscle: Muscles.Abductors,
  //     secondaryMuscles: []));
  // //Adductor Exercises:
  // //Hip Adduction Machine:
  // exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Hip Adduction Machine",
  //     mainMuscle: Muscles.Adductors,
  //     secondaryMuscles: []));
  // //Biceps Exercises:
  // //Preacher Curl Barbell:
  // exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Preacher Curl Barbell",
  //     mainMuscle: Muscles.Biceps,
  //     secondaryMuscles: []));
  // //Concentration Curl:
  // exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Concentration Curl",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));

  // exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Weighted Cruncheasds",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));
  // //Weighted Russian Twists:
  // exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Weighted Russian Twiasdsts",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));
  // //Abductor Exercises:
  // //Hip Abduction Machine:
  // exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Hip Abduction Machasdine",
  //     mainMuscle: Muscles.Abductors,
  //     secondaryMuscles: []));
  // //Adductor Exercises:
  // //Hip Adduction Machine:
  // exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Hip Adduction Macasdhine",
  //     mainMuscle: Muscles.Adductors,
  //     secondaryMuscles: []));
  // //Biceps Exercises:
  // //Preacher Curl Barbell:
  // exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Preacher Curl Barasdbell",
  //     mainMuscle: Muscles.Biceps,
  //     secondaryMuscles: []));
  // //Concentration Curl:
  // exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
  //     id: DateTime.now().toString(),
  //     exerciseName: "Concentration asdCurl",
  //     mainMuscle: Muscles.Abdominals,
  //     secondaryMuscles: []));

  return exercisesList;
}

class AddExercise extends StatefulWidget {
  final Function actionHandler;
  AddExercise({required this.actionHandler});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final weightController = TextEditingController();
  final repsController = TextEditingController();

  List<Exercise> exercises = exercisesInitialization();

  @override
  Widget build(BuildContext context) {
    Exercise selectedExercise = exercises.elementAt(0);

    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: DropdownButton<Exercise>(
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                value: selectedExercise,
                                onChanged: (Exercise? newValue) {
                                  setState(() {
                                    selectedExercise = newValue as Exercise;
                                  });
                                },
                                items: 
                                  exercises.map<DropdownMenuItem<Exercise>>((Exercise value) {
                                    return DropdownMenuItem<Exercise>(
                                      value: value,
                                      child: Text(value.exerciseName),
                                    );
                                  }).toList(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.actionHandler(selectedExercise);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Add Set",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
