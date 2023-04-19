import 'package:flutter/material.dart';
import 'package:gym_gram/widgets/LoginPage.dart';
import 'package:gym_gram/widgets/RegisterPage.dart';

// class LoginOrRegisterPage extends StatefulWidget {
//   const LoginOrRegisterPage({super.key});

//   @override
//   State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
// }

// class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
//   //initially show login page:
//   bool showLoginPage = true;

//   //switch between login and signUp
//   void switchPages() {
//     // delaying the call of switchPages untill the build phase is complete
//     // schedules a callback to be called after the current frame has finished building
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         showLoginPage = !showLoginPage;
//       });
//       print(showLoginPage);
//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginPage) {
//       return LoginPage(
//         tapSwitch: switchPages,
//       );
//     } else {
//       return RegisterPage(
//         onTap: switchPages,
//       );
//     }
//   }
// }

class LoginOrRegisterPage extends StatefulWidget {
  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool _isLoginPage = true;

  void _switchPage() {
    setState(() {
      _isLoginPage = !_isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: _isLoginPage
          ? LoginPage(tapSwitch: _switchPage)
          : RegisterPage(onTap: _switchPage),
    );
  }
}
