import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/models/Exercise.dart';
import '../models/WorkingSet.dart';

Map<Enum, List<Exercise>> exercisesInitialization() {
  List<WorkingSet> startWorkingSets = [];
  startWorkingSets.add(new WorkingSet(reps: 0, weight: 0));
  //Initialization of some Exercises:
  Map<Enum, List<Exercise>> exercises = {};
  //Abdominal Exercises:
  //Weighted Crunches:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Crunches",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Weighted Russian Twists:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Russian Twists",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Abductor Exercises:
  //Hip Abduction Machine:
  exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Hip Abduction Machine",
      mainMuscle: Muscles.Abductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Adductor Exercises:
  //Hip Adduction Machine:
  exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Hip Adduction Machine",
      mainMuscle: Muscles.Adductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Biceps Exercises:
  //Preacher Curl Barbell:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Preacher Curl Barbell",
      mainMuscle: Muscles.Biceps,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Concentration Curl:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Concentration Curl",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));

  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Cruncheasds",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Weighted Russian Twists:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Weighted Russian Twiasdsts",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Abductor Exercises:
  //Hip Abduction Machine:
  exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Hip Abduction Machasdine",
      mainMuscle: Muscles.Abductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Adductor Exercises:
  //Hip Adduction Machine:
  exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Hip Adduction Macasdhine",
      mainMuscle: Muscles.Adductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Biceps Exercises:
  //Preacher Curl Barbell:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Preacher Curl Barasdbell",
      mainMuscle: Muscles.Biceps,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Concentration Curl:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      id: DateTime.now().toString(),
      exerciseName: "Concentration asdCurl",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));

  return exercises;
}


class AddExercise extends StatefulWidget {
  final Function actionHandler;
  AddExercise({required this.actionHandler});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  String dropdownvalue = "Weighted Crunches";
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  
  var exercises = exercisesInitialization();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10,),
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
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: dropdownvalue,
                            items: exercises.values
                                .expand((exercisesList) =>
                                    exercisesList.map((exercise) {
                                      String value = exercise.getExerciseName();
                                      print(value);
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(exercise.getExerciseName()),
                                      );
                                    }))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          )),
                      TextField(
                        decoration: InputDecoration(labelText: "Weight: "),
                        controller: weightController,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Reps: "),
                        controller: repsController,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            print(weightController.text);
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
          ])
        ),
      ),
    );
  }
}