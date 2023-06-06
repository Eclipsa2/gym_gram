import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../cards/CustomStyles.dart';
import '../models/User.dart' as model;

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  // sign user up method
  Future signUp() async {
    //try creating user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential cred =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        model.User user = model.User(
          email: usernameController.text,
          username: usernameController.text.split('@')[0],
          uid: cred.user!.uid,
          photoUrl: "https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg",
          followers: [],
          following: [],
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        print('Sign-up successful');
      } else {
        showErrorMessage("Passwords don\'t match!");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showErrorMessage(
          "The email address is already in use by another account!");
    }
  }

  void showErrorMessage(String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.black,
              title: Center(
                child: Text(text, style: const TextStyle(color: Colors.white)),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container( 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Image.asset(
                      'assets/images/gymGram.png',
                      height: 120,
                    ),
    
                  const SizedBox(height: 50),
    
                  // Let's get you started!
                  const Text(
                    'Let\'s get you started!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
    
                  const SizedBox(height: 25),
    
                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
    
                  const SizedBox(height: 10),
    
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
    
                  const SizedBox(height: 10),
    
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
    
                  const SizedBox(height: 25),
    
                  // sign in button
                  MyButton(
                    onTap: signUp,
                  ),
    
                  const SizedBox(height: 50),
    
                  const SizedBox(height: 50),
    
                  const SizedBox(height: 50),
    
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap!,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      ],
    );
  }
}
