import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/startup_view_model.dart';

class DecisionScreen extends StatelessWidget {
  static const routeName = '/intro/decision';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartUpViewModel>.withConsumer(
      viewModel: StartUpViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/get_started.png'),
              verticalSpaceMedium,
              // Text(
              //   "Easy, quick loan processes",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w700,
              //     color: primaryColor,
              //     fontFamily: 'Maven Pro',
              //   ),
              // ),
              // verticalSpaceMassive,
              Text(
                "Let's get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                  fontFamily: 'Maven Pro',
                ),
              ),
              verticalSpaceMassive,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: BusyButton(
                  onPressed: () => model.toAuth('register'),
                  busy: false,
                  title: "Get Started",
                ),
              ),
              verticalSpaceMedium,
              TextLink(
                "Already have an account, Log in",
                onPressed: () => model.toAuth('login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
