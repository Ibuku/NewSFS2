import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/viewmodels/startup_view_model.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/intro/splash';

  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) => model.handleSplashLogic(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello &\nWelcome!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontFamily: 'Maven Pro',
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
