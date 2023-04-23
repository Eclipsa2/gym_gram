import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/models/WorkoutExercise.dart';
import 'package:gym_gram/widgets/EditWorkout.dart';
import 'package:gym_gram/widgets/WorkoutsList.dart';
import 'package:gym_gram/auth_widgets/auth_page.dart';
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
        home: AuthPage(),
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
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final CollectionReference _workouts =
        FirebaseFirestore.instance.collection('workouts');

    int numberOfWorkouts = 0;

    _workouts.snapshots().listen((QuerySnapshot snapshot) {
      numberOfWorkouts = snapshot.docs.length + 1;
    });

    // this function adds workout object to firestore
    Future<void> _addWorkout() {
      return _workouts
          .add({
            'id': DateTime.now()
                .toString(), // ID which is exact date when the workout was added
            'workoutName':
                'Workout #${(numberOfWorkouts).toString()}', // Workout #1, 2, etc...
            'exercises': <WorkoutExercise>[],
            'start': DateTime.now(),
            'length': 0,
            'userId': currentUser?.uid,
          })
          .then((value) => print("DBG: Workout Added!"))
          .catchError((onError) => print("Failed to add workout: ${onError}"));
    }

    Future<void> _delete(String workoutId) async {
      await _workouts.doc(workoutId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout deleted successfully!')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Gym Gram")),

      // StreamBuilder helps keeping persistent connection with firestore database
      body: StreamBuilder<QuerySnapshot>(
        stream: _workouts
                      .orderBy('start', descending: true)
                      .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // if (snapshot.hasError) {
          //   return Text('Something went wrong');
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          
          if(snapshot.hasData)
          {
            return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //* Passing all the rows of _workouts to be displayed as list
                          WorkoutsList(
                            workouts: snapshot.data!.docs
                              .where((workout) =>
                                workout.get('userId') == currentUser?.uid)
                                .toList(),
                            deleteHandler: _delete,
                          ),
                        ],
                      );
          } else {
            // Handle the snapshot loading state
            return CircularProgressIndicator.adaptive();
          }
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await _addWorkout();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
