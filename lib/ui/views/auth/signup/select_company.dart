import 'package:flutter/material.dart';

class SelectCompany extends StatelessWidget {
  static const routeName = '/auth/signup/select-company';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Company"),),
    );
  }
}