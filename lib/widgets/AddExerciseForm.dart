import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import '../models/Workout.dart';

//Initialization of Muscles enum:

Map<Enum, List<Exercise>> exercisesInitialization() {
  List<WorkingSet> startWorkingSets = [];
  startWorkingSets.add(new WorkingSet(reps: 0, weight: 0));
  //Initialization of some Exercises:
  Map<Enum, List<Exercise>> exercises = {};
  //Abdominal Exercises:
  //Weighted Crunches:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      exerciseName: "Weighted Crunches",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Weighted Russian Twists:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      exerciseName: "Weighted Russian Twists",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Abductor Exercises:
  //Hip Abduction Machine:
  exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
      exerciseName: "Hip Abduction Machine",
      mainMuscle: Muscles.Abductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Adductor Exercises:
  //Hip Adduction Machine:
  exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
      exerciseName: "Hip Adduction Machine",
      mainMuscle: Muscles.Adductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Biceps Exercises:
  //Preacher Curl Barbell:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      exerciseName: "Preacher Curl Barbell",
      mainMuscle: Muscles.Biceps,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Concentration Curl:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      exerciseName: "Concentration Curl",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));

  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      exerciseName: "Weighted Cruncheasds",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Weighted Russian Twists:
  exercises.putIfAbsent(Muscles.Abdominals, () => []).add(Exercise(
      exerciseName: "Weighted Russian Twiasdsts",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Abductor Exercises:
  //Hip Abduction Machine:
  exercises.putIfAbsent(Muscles.Abductors, () => []).add(Exercise(
      exerciseName: "Hip Abduction Machasdine",
      mainMuscle: Muscles.Abductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Adductor Exercises:
  //Hip Adduction Machine:
  exercises.putIfAbsent(Muscles.Adductors, () => []).add(Exercise(
      exerciseName: "Hip Adduction Macasdhine",
      mainMuscle: Muscles.Adductors,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Biceps Exercises:
  //Preacher Curl Barbell:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      exerciseName: "Preacher Curl Barasdbell",
      mainMuscle: Muscles.Biceps,
      secondaryMuscles: [],
      workingSets: startWorkingSets));
  //Concentration Curl:
  exercises.putIfAbsent(Muscles.Biceps, () => []).add(Exercise(
      exerciseName: "Concentration asdCurl",
      mainMuscle: Muscles.Abdominals,
      secondaryMuscles: [],
      workingSets: startWorkingSets));

  return exercises;
}

class AddExercisePage extends StatefulWidget {
  const AddExercisePage();

  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  String dropdownvalue = "Weighted Crunches";
  final weightController = TextEditingController();
  final repsController = TextEditingController();

  var exercises = exercisesInitialization();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gym Gram")),
      body: Column(
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
          ]),
    );
  }
}
