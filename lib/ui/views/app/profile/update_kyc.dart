import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/custom_app_bar.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/profile_view_model.dart';

class UpdateKYC extends StatefulWidget {
  static const routeName = '/app/profile/update-kyc';
  @override
  _UpdateKYCState createState() => _UpdateKYCState();
}

class _UpdateKYCState extends State<UpdateKYC> {
  final _formKey = GlobalKey<FormState>();
  final _fnTextController = TextEditingController();
  final _lnTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        _fnTextController.text = model.user.firstname;
        _lnTextController.text = model.user.lastname;

        return Container(
          child: Scaffold(
            body: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 24,
                    ),
                    child: CustomAppBar(title: "Edit Profile",),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              hintText: "Firstname",
                              enabled: false,
                              textController: _fnTextController,
                            ),
                            verticalSpace15,
                            CustomTextField(
                              hintText: "Lastname",
                              enabled: false,
                              textController: _lnTextController,
                            ),
                            verticalSpace15,
                            CustomTextField(
                              hintText: "Date of Birth",
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Date of birth is required";
                                }
                                return null;
                              },
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            verticalSpace15,
                            CustomTextField(
                              hintText: "Mobile number",
                              inputType: TextInputType.phone,
                              validator: (value) {
                                if (value.toString().length < 11) {
                                  return "Phone number is less than 11 characters";
                                } else if (value.toString().length > 11) {
                                  return "Phone number is more than 11 characters";
                                }
                                return null;
                              },
                            ),
                            verticalSpace15,
                            CustomTextField(
                              hintText: "BVN",
                              inputType: TextInputType.number,
                              validator: (value) {
                                if (value.toString().length < 11) {
                                  return "BVN is less than 11 characters";
                                } else if (value.toString().length > 11) {
                                  return "BVN is more than 11 characters";
                                }
                                return null;
                              },
                            ),
                            verticalSpace15,
                            CustomTextField(
                              hintText: "Next of Kin",
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Next of Kin is required";
                                }
                                return null;
                              },
                            ),
                            verticalSpace(50),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 3,
                                child: GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                      ).copyWith(
                                          color: primaryColor, fontSize: 16),
                                    ),
                                  ),
                                  onTap: () {
                                    _formKey.currentState.validate();
                                    // print("Hello world");
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
