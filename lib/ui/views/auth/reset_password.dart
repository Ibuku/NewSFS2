import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/forgot_password_view_model.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/auth/reset-password';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _resetFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  Map _authData = {};

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ForgotPasswordViewModel>.withConsumer(
      viewModel: ForgotPasswordViewModel(),
      onModelReady: (model) {
        model.initEmail(email: ModalRoute.of(context).settings.arguments);
        print("[Reset Password] Email: ${model.userEmail}");
        _authData['email'] = model.userEmail;
      },
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
                "Create a new password",
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
                  key: _resetFormKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        hintText: "Password",
                        textController: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                          ),
                          onPressed: () => model.setPasswordVisible(
                            !model.passwordVisible,
                          ),
                        ),
                        obscureText: model.passwordVisible,
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      verticalSpace(15),
                      CustomTextField(
                        hintText: "Confirm Password",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Confirm password is required";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                          ),
                          onPressed: () => model.setPasswordVisible(
                            !model.password2Visible,
                            type: 2,
                          ),
                        ),
                        obscureText: model.password2Visible,
                      ),
                      verticalSpace(15),
                      BusyButton(
                        title: "Reset",
                        onPressed: () async {
                          if (!_resetFormKey.currentState.validate()) {
                            return;
                          }
                          _resetFormKey.currentState.save();
                          print("Data: $_authData");
                          await model.resetPassword(authData: _authData);
                        },
                        busy: model.busy,
                      ),
                      verticalSpace(20),
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
