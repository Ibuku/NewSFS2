import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/auth/signup/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
    );
  }
}