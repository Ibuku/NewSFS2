import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../shared/app_colors.dart';
import '../../../viewmodels/startup_view_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
