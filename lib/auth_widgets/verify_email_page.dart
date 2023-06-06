import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/widgets/HomeScreen.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isVerified) {
      return HomeScreen();
    } else {
      return Stack(children: [
        Container( 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: const Icon(
                  Icons.email_outlined,
                  size: 150,
                ),
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  'Verify Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'FjallaOne',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                width: double.infinity,
                child: const Text(
                  'Check your inbox and verify your email by clicking on the link sent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'FjallaOne',
                  ),
                ),
              ),
              TextButton(
                  onPressed: sendVerificationEmail,
                  child: Text(
                    'Send again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'FjallaOne',
                    ),
                  )),
              // TextButton(
              //     onPressed: () async {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => LoginOrRegisterPage()));
              //     },
              //     child: Text(
              //       'Send again',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontFamily: 'FjallaOne',
              //       ),
              //     ))
              //To DO: Cancel button -> login_or_register_page
            ],
          ),
        ),
      ]);
    }
  }
}
