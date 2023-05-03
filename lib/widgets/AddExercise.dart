import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_gram/models/Exercise.dart';
import '../models/WorkingSet.dart';

Future<List<Exercise>> fetchExercises() async {
  final exercises = <Exercise>[];
  
  // querying the data from the reference of the firestore collection
  final querySnapshot =
      await FirebaseFirestore.instance.collection('exercises').get();

  for (final doc in querySnapshot.docs) {
    final exercise = Exercise.fromJson(doc.data());
    exercises.add(exercise);
  }

  return exercises;
}

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

  List<Exercise> exercises = [];

  // setting a random exercise as the selected one to ensure that it has been initialized
  // before the dropdown list is beign generatted
  late Exercise selectedExercise = Exercise(
    id: DateTime.now().toString(),
    exerciseName: "Loading...",
    mainMuscle: Muscles.Abdominals,
    secondaryMuscles: [],
  );

  void _submit() {
    widget.actionHandler(selectedExercise);
    Navigator.of(context).pop();
  }

  // initState is called once the widget is insterted in the widget tree
  @override
  void initState() {
    super.initState();

    // .then() method is called on the Future object returned by fetchExercises() (then() is called after the fetchExercises completed its execution)
    // the callback function takes the resolved value aka the list of exercises as its argument
    // it then sets the exercises values 
    fetchExercises().then((exercisesFromDatabase) {
      setState(() {
        exercises = exercisesFromDatabase;
        selectedExercise = exercises[0];
      });
    });

  }

  
  @override
  Widget build(BuildContext context) {
    if (exercises == null) {
      return const Center(child: CircularProgressIndicator());
    }
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
                                  print('Selected exercise: ${newValue?.exerciseName}');
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
                                  _submit();
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
