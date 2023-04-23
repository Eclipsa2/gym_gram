import 'package:flutter/material.dart';
import 'package:gym_gram/auth_widgets/LoginPage.dart';
import 'package:gym_gram/auth_widgets/RegisterPage.dart';

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
