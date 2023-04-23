import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_gram/auth_widgets/verify_email_page.dart';
import 'LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //user logged in:
              if (snapshot.hasData) {
                return VerifyEmailPage();
              } else {
                return LoginOrRegisterPage();
              }
            }));
  }
}
