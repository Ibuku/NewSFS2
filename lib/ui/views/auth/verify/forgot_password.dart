import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/const.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/auth/verify/activate_password.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/ui/widgets/text_link.dart';
import 'package:sfscredit/viewmodels/forgot_password_view_model.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/auth/verify/forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  Map _authData = {
    'type': 'mobile',
    'callback_url': BASE_URL,
  };
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ForgotPasswordViewModel>.withConsumer(
      viewModel: ForgotPasswordViewModel(),
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
              Image.asset('assets/images/login.png'),
              verticalSpace(30),
              Text(
                "Sorry to hear that",
                textAlign: TextAlign.center,
                style: GoogleFonts.mavenPro(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              verticalSpaceTiny,
              Text(
                "Please enter your email address",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                        title: "Reset Password",
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          model.toRoute("activate-password");
                        },
                        busy: model.busy,
                      ),
                      verticalSpace(20),
                      Center(
                        child: TextLink(
                          "Cancel",
                          onPressed: () => model.goBack(),
                        ),
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
