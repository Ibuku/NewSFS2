import 'package:flutter/material.dart';
import 'package:sfscredit/services/application_service.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/app/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Text(ApplicationService.user.toJson().toString()),
      ),
    );
  }
}
