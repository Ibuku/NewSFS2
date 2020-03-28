import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';

import 'busy_button.dart';

class GuarantorDetailsModalWidget extends StatefulWidget {
  final GuarantorRequest request;

  GuarantorDetailsModalWidget({@required this.request});

  @override
  _GuarantorDetailsModalState createState() => _GuarantorDetailsModalState();
}

class _GuarantorDetailsModalState extends State<GuarantorDetailsModalWidget> {
  final _salaryFormKey = GlobalKey<FormState>();

  Map _reqData = {};

  final _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
      viewModel: GuarantorRequestViewModel(),
      builder: (context, model, child) => WillPopScope(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            children: <Widget>[
              Flexible(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      onPressed: () {
                        print('Cancel Clicked');
                      },
                      child: Text("Cancel",
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(fontSize: 15, color: primaryColor),
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Add Your Current Salary",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(fontSize: 17, color: primaryColor),
                        )),
                    Form(
                      key: _salaryFormKey,
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            hintText: 'Current Salary',
                            textController: _salaryController,
                            hintTextStyle: TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Current Salary is required";
                              }
                              return null;
                            },
                            inputType: TextInputType.number,
                            onChanged: (value) {
                              _reqData['guarantor_salary'] = value;
                            },
                            onSaved: (value) {
                              _reqData['guarantor_salary'] = value;
                            },
                          ),
                          verticalSpace15,
                          BusyButton(
                            title: "Approve Request",
                            onPressed: () async {
                              if (_reqData.isEmpty) {
                                return;
                              }
                              if (!_salaryFormKey.currentState.validate()) {
                                return;
                              }
                              _salaryFormKey.currentState.save();
                              _reqData['loan_request_id'] =
                                  widget.request.loanRequestId;
                              await model.addGuarantorBankDetails(reqData: _reqData);
                            },
                            busy: model.busy,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
