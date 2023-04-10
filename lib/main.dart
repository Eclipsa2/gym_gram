import 'package:flutter/material.dart';
import 'package:gym_gram/models/Exercise.dart';
import 'package:gym_gram/models/WorkingSet.dart';
import 'package:gym_gram/models/WorkoutExercise.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:gym_gram/widgets/WorkoutsList.dart';
import 'models/Workout.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add. 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Gram',
      home: MyWorkoutsPage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        EditWorkoutPage.routeName: (ctx) => EditWorkoutPage(),
        // '/EditWorkout': (context) => EditExer()
      });
  }
}

class MyWorkoutsPage extends StatefulWidget {
  const MyWorkoutsPage({super.key});

  @override
  State<MyWorkoutsPage> createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
//  List <Workout> _userWorkouts =[];
  CollectionReference workouts = 
        FirebaseFirestore.instance.collection('workouts');
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Workout> _userWorkouts = [];
    CollectionReference workouts = FirebaseFirestore.instance.collection('workouts');
    int numberOfWorkouts = 0;
    workouts.get().then((QuerySnapshot snapshot) {
      numberOfWorkouts = snapshot.docs.length + 1;
    });
    // this function adds workout object to firestore
    Future<void> addWorkoutToDB() {
      return workouts
          .add({
            'id': DateTime.now().toString(),                                        // ID which is exact date when the workout was added
            'workoutName': 'Workout #${(numberOfWorkouts).toString()}',     // Workout #1, 2, etc...
            'exercises': <WorkoutExercise> [],
            'start': DateTime.now(),
            'length': 0
          })
          .then((value) => print("DBG: Workout Added!"))
          .catchError((onError) => print("Failed to add workout: ${onError}"));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Gym Gram")),
      body: StreamBuilder<QuerySnapshot>(
        stream: workouts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<Workout> workoutsList = snapshot.data!.docs.map((document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String workoutId = document.id;
            String workoutName = data['workoutName'];
            Timestamp startTimestamp = data['start'];
            DateTime start = startTimestamp.toDate();       // converting firebase time datatype to datatime
            int length = data['length'] ?? 0;
            return Workout(
                id: workoutId,
                workoutName: workoutName,
                exercises: [],
                start: start);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              WorkoutsList(workouts: workoutsList),
              Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        addWorkoutToDB();
                      },
                      child: Text("Add workout")))
            ],
          );
        },
      ),
    );
  }
}

// // simulating multiple accounts
// Future<String> getAccountKey() async {
//   return '12345678';
// }