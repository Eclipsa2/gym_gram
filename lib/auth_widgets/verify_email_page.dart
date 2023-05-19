import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/main.dart';
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
      return Scaffold(
          appBar: AppBar(
            title: Text("Verify Email"),
          ),
          body: Column(
            children: const <Widget>[
              Icon(
                Icons.email_rounded,
                size: 100,
                color: Colors.white,
              ),
              Text(
                "Waiting for email verification...",
                textAlign: TextAlign.center,
              )
            ],
          ));
    }
  }
}
