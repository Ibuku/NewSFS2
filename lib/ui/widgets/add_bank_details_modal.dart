import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';
import 'package:sfscredit/viewmodels/profile_view_model.dart';

import 'busy_button.dart';
import 'card_busy_button.dart';
import 'full_screen_picker.dart';

class BankDetailsModalWidget extends StatefulWidget {
  final BuildContext parentContext;
  final Function callback;
  final Function selectBank;

  BankDetailsModalWidget({@required this.parentContext, @required this.callback, @required this.selectBank});

  @override
  _BankDetailsModalState createState() => _BankDetailsModalState();
}

class _BankDetailsModalState extends State<BankDetailsModalWidget> {
  final _formKey = GlobalKey<FormState>();

  Map _userBankDetails = {};

  final _accountNoController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _bankController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
        viewModel: ProfileViewModel(),
        onModelReady: (model) => model.setBuildContext(widget.parentContext),
        builder: (context, model, child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(widget.parentContext).pop();
                    },
                    child: Text("Cancel",
                        style: GoogleFonts.mavenPro(
                          textStyle:
                              TextStyle(fontSize: 15, color: primaryColor),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text("Add Bank Details",
                            style: GoogleFonts.mavenPro(
                              textStyle:
                              TextStyle(fontSize: 17, color: primaryColor),
                            )),
                      ),
                    ],
                  ),
                ),
                verticalSpace30,
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 10,
                            child: CustomTextField(
                              hintText: "Account Number",
                              hintTextStyle: TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Account Number is required";
                                }
                                if (value.toString().length < 10) {
                                  return "Account Number is not valid";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userBankDetails['account_number'] = value;
                              },
                              textController: _accountNoController,
                              inputType: TextInputType.number,
                              onChanged: (value) async {
                                if (model.selectedBank != null &&
                                    value.toString().length == 10) {
                                  await model.resolveBankDetails(
                                      value, model.selectedBank);
                                  _accountNameController.text = model.bankAccountName;
                                }
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: horizontalSpaceSmall
                          ),
                          Flexible(
                            flex: 10,
                            child: CustomTextField(
                              hintText: model.loading
                                  ? "Loading Banks ..."
                                  : (model.selectedBank != null
                                  ? model.selectedBank.display
                                  : "Select bank"),
                              textController: _bankController,
                              hintTextStyle: TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please select a bank";
                                }
                                return null;
                              },
                              enabled: !model.loading,
                              onSaved: (value) {
                                _bankController.value =
                                    new TextEditingController.fromValue(
                                        new TextEditingValue(text: value))
                                        .value;
                              },
                              readOnly: true,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                              ),
                              onTap: () {
                                if (model.loading || model.banks.isEmpty) {
                                  return;
                                }
                                widget.selectBank(model).then((value) async {
                                  if (value != null) {
                                    model.setSelectedBank(value);
                                    if (_accountNoController.text.length == 10) {
                                      await model.resolveBankDetails(
                                          _accountNoController.text,
                                          model.selectedBank);
                                      _accountNameController.text =
                                          model.bankAccountName;
                                    }
                                    _bankController.value =
                                        new TextEditingController.fromValue(
                                            new TextEditingValue(
                                                text: value.display))
                                            .value;
                                    _userBankDetails['bank_name'] = value.code;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      verticalSpace30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         Flexible(
                           flex: 10,
                           child:  CustomTextField(
                               hintText: "Account Name",
                               hintTextStyle: TextStyle(fontSize: 12),
                               textController: _accountNameController,
                               readOnly: true,
                               enabled: !model.loading),
                         ),
                          Flexible(
                              flex: 1,
                              child: horizontalSpaceSmall
                          ),
                          Flexible(
                            flex: 10,
                            child: CustomTextField(
                              hintText: "Password",
                              hintTextStyle: TextStyle(fontSize: 12),
                              textController: _passwordController,
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
                                _userBankDetails['password'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      verticalSpace30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          BusyButton(
                            title: "Add",
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              var res = await model.updateUserBankDetails(_userBankDetails);
                              if(res == 'success'){
                                Navigator.of(widget.parentContext).pop();
                                await widget.callback();
                              }
                            },
                            busy: model.busy,
                          ),
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          );
        });
  }
}
