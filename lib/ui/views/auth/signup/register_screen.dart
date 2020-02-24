import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/signup_view_model.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/auth/signup/register';
  final _formKey = GlobalKey<FormState>();

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
                  ),
                  verticalSpace(15),
                  CustomTextField(
                    hintText: "Email",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  verticalSpace(15),
                  CustomTextField(
                    hintText: "Password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  verticalSpace(15),
                  CustomTextField(
                    hintText: "Confirm Password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Confirm password is required";
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
                      // model.signUp(email: null, password: null, fullName: null)
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
