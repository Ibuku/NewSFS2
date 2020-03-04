import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../../../ui/widgets/card_busy_button.dart';
import '../../../../ui/shared/ui_helpers.dart';
import '../../../../ui/widgets/busy_overlay.dart';
import '../../../../ui/widgets/custom_scaffold.dart';
import '../../../../ui/widgets/custom_text_field.dart';
import '../../../../viewmodels/profile_view_model.dart';

class UpdateKYC extends StatefulWidget {
  static const routeName = '/app/profile/update-kyc';
  @override
  _UpdateKYCState createState() => _UpdateKYCState();
}

class _UpdateKYCState extends State<UpdateKYC> {
  final _formKey = GlobalKey<FormState>();

  final _fnTextController = TextEditingController();
  final _lnTextController = TextEditingController();
  final _dobTextController = TextEditingController();
  final _pnTextController = TextEditingController();
  final _bvnTextController = TextEditingController();
  final _nokTextController = TextEditingController();

  Map _userProfile = {};
  DateTime _selectedDOB;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1960),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDOB = pickedDate;
        _userProfile['date_of_birth'] =
            DateFormat("y-MM-dd").format(_selectedDOB);
      });
      _dobTextController.text = DateFormat('dd MMMM, y').format(_selectedDOB);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        _fnTextController.text = model.user.firstname;
        _lnTextController.text = model.user.lastname;
        if (model.user.profile.dateOfBirth != null) {
          _selectedDOB = DateTime.parse(model.user.profile.dateOfBirth);
          _dobTextController.text = DateFormat("y-MM-dd").format(_selectedDOB);
        }
        _pnTextController.text = model.user.profile.phoneNumber;
        _bvnTextController.text = model.user.profile.bvn;
        _nokTextController.text = model.user.profile.nextOfKin;

        return BusyOverlay(
          show: model.busy,
          title: "Updating profile",
          child: CustomScaffold(
            pageTitle: "Edit Profile",
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      onTap: _presentDatePicker,
                      textController: _dobTextController,
                      hintText: "Date of Birth",
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Date of birth is required";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userProfile['date_of_birth'] =
                            DateFormat("y-MM-dd").format(_selectedDOB);
                      },
                      suffixIcon: Icon(Icons.calendar_today),
                      readOnly: true,
                      enabled: true,
                    ),
                    verticalSpace15,
                    CustomTextField(
                      hintText: "Mobile number",
                      textController: _pnTextController,
                      inputType: TextInputType.phone,
                      validator: (value) {
                        if (value.toString().length < 11) {
                          return "Phone number is less than 11 characters";
                        } else if (value.toString().length > 11) {
                          return "Phone number is more than 11 characters";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userProfile['phone_number'] = val;
                      },
                    ),
                    verticalSpace15,
                    CustomTextField(
                      hintText: "BVN",
                      textController: _bvnTextController,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value.toString().length < 11) {
                          return "BVN is less than 11 characters";
                        } else if (value.toString().length > 11) {
                          return "BVN is more than 11 characters";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userProfile['bvn'] = val;
                      },
                    ),
                    verticalSpace15,
                    CustomTextField(
                      hintText: "Next of Kin",
                      textController: _nokTextController,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Next of Kin is required";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _userProfile['next_of_kin'] = val;
                      },
                    ),
                    verticalSpace(50),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 160,
                        child: CardBusyButton(
                          title: "Update",
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            model.updateUser(_userProfile);
                          },
                          busy: model.busy,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
