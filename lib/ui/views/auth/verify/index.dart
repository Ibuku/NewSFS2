import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../../../ui/shared/app_colors.dart';
import '../../../../ui/shared/ui_helpers.dart';
import '../../../../ui/widgets/busy_button.dart';
import '../../../../ui/widgets/custom_card.dart';
import '../../../../ui/widgets/custom_text_field.dart';
import '../../../../ui/widgets/text_link.dart';
import '../../../../viewmodels/account_activate_view_model.dart';

class VerifyIndex extends StatefulWidget {
  static const routeName = '/auth/verify/index';

  @override
  _VerifyIndexState createState() => _VerifyIndexState();
}

class _VerifyIndexState extends State<VerifyIndex> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AccountActivateViewModel>.withConsumer(
      viewModel: AccountActivateViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          textTheme: TextTheme(
            title: Theme.of(context)
                .textTheme
                .title
                .copyWith(fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Text(
                "Please enter your\nemail address",
                textAlign: TextAlign.center,
                style: GoogleFonts.mavenPro(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              verticalSpace(30),
              CustomCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 40,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        hintText: "Email address",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email is required";
                          }
                          if (!EmailValidator.validate(value)) {
                            return "Email address is not valid";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.setUserEmail(value);
                        },
                      ),
                      verticalSpace(30),
                      BusyButton(
                        title: "Continue",
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          model.toRoute("activate-account");
                        },
                        busy: model.busy,
                      ),
                      verticalSpace(20),
                      TextLink(
                        "Cancel",
                        onPressed: () => model.toRoute("cancel"),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
