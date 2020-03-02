import 'package:flutter/material.dart';

class UpdateKYC extends StatefulWidget {
  static const routeName = '/app/profile/update-kyc';
  @override
  _UpdateKYCState createState() => _UpdateKYCState();
}

class _UpdateKYCState extends State<UpdateKYC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
    );
  }
}
