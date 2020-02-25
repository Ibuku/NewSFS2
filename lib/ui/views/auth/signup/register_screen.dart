import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/const.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/signup_view_model.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/auth/signup/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  Map _authData = {
    'type': 'mobile',
    'callback_url': BASE_URL,
  };

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      onModelReady: (model) {
        model.setSelectedCompany(ModalRoute.of(context).settings.arguments);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Create Account"),
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
          child: CustomCard(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    hintText: "First name",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['firstname'] = value;
                    },
                  ),
                  verticalSpace(15),
                  CustomTextField(
                    hintText: "Last name",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Last name is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['lastname'] = value;
                    },
                  ),
                  verticalSpace(15),
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
                    obscureText: true,
                  ),
                  verticalSpace(15),
                  BusyButton(
                    title: "Finish",
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      model.signUp(authData: _authData);
                    },
                    busy: model.busy,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
