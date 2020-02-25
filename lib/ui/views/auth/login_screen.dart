import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/login_view_model.dart';

import '../../../const.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  Map _authData = {};

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
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
                "Please Log in",
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
                        hintText: "Email",
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
                          _authData['email'] = value;
                        },
                      ),
                      verticalSpace(15),
                      CustomTextField(
                        hintText: "Password",
                        textController: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      verticalSpace(30),
                      BusyButton(
                        title: "Finish",
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          model.login(authData: _authData);
                        },
                        busy: model.busy,
                      )
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
