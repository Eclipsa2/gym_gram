import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_gram/widgets/HomeScreen.dart';
import 'forgot_password_page.dart';
import '../cards/CustomStyles.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback tapSwitch;
  LoginPage({super.key, required this.tapSwitch});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      print('Sign-in successful');
    } on FirebaseAuthException catch (e) {
      showErrorMessage();
    }
  }

  void showErrorMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              backgroundColor: Colors.black,
              title: Center(
                child: Text("Wrong username or password",
                    style: const TextStyle(color: Colors.white)),
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
                    // const SizedBox(height: 20),
                    // logo
                    Image.asset(
                      'assets/images/gymGram.png',
                      height: 120,
                    ),
          
                    const SizedBox(height: 50),
          
                    // welcome back, you've been missed!
                    const Text(
                      'Welcome back, you\'ve been missed!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'FjallaOne',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    const SizedBox(height: 50),
          
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
          
                    // forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()))
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    const SizedBox(height: 25),
          
                    // sign in button
                    MyButton(
                      onTap: signIn,
                    ),
          
                    const SizedBox(height: 50),
          
                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[100], fontSize: 20),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.tapSwitch,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
      ]
    );
  }
}
