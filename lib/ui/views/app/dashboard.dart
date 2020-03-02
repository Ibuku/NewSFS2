import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/viewmodels/application_view_model.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/app/dashboard';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ApplicationViewModel>.withConsumer(
      viewModel: ApplicationViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
            centerTitle: false,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(),
            child: Column(
              children: [
                Text(model.getUser().toJson().toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
