import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sfscredit/models/bank.dart';
import 'package:sfscredit/ui/widgets/full_screen_picker.dart';
import 'package:sfscredit/viewmodels/profile_view_model.dart';

import '../../../../ui/widgets/card_busy_button.dart';
import '../../../../ui/shared/ui_helpers.dart';
import '../../../../ui/widgets/busy_overlay.dart';
import '../../../../ui/widgets/custom_scaffold.dart';
import '../../../../ui/widgets/custom_text_field.dart';

class AddBankDetails extends StatefulWidget {
  static const routeName = '/app/profile/add-bank-details';
  @override
  _AddBankDetailsState createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  final _formKey = GlobalKey<FormState>();

  final _accountNoController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _bankController = TextEditingController();
  final _passwordController = TextEditingController();

  Map _userBankDetails = {};

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      onModelReady: (model) => model.initBankDetails(),
      builder: (context, model, child) {
        if (model.bankDetails != null) {
          _accountNameController.text = model.bankDetails.accountName;
          _accountNoController.text = model.bankDetails.accountNo;
          List<Bank> usersBankList = model.banks
              .where((bank) => bank.code == model.bankDetails.bankCode)
              .toList();
          if(usersBankList.isNotEmpty) {
            _bankController.text = usersBankList[0].name;
          }
        }
        return BusyOverlay(
          show: model.busy,
          title: "Loading",
          child: CustomScaffold(
            pageTitle: "Bank Details",
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      hintText: "Account Number",
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
                    verticalSpace15,
                    CustomTextField(
                            hintText: model.loading
                                ? "Loading Banks ..."
                                : (model.selectedBank != null
                                    ? model.selectedBank.display
                                    : "Select a bank"),
                            textController: _bankController,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenPicker(
                                    title: "Select a bank",
                                    dataSource:
                                        model.loading ? [] : model.banks,
                                  ),
                                  fullscreenDialog: false,
                                ),
                              ).then((value) async {
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
                    verticalSpace15,
                    CustomTextField(
                        hintText: "Account Name",
                        textController: _accountNameController,
                        readOnly: true,
                        enabled: !model.loading),
                    verticalSpace15,
                    CustomTextField(
                      hintText: "Password",
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
                    verticalSpace(50),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 160,
                        child: CardBusyButton(
                          title: model.bankDetails == null ? "Add" : "Update",
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            model.updateUserBankDetails(_userBankDetails);
                          },
                          busy: model.busy,
                        ),
                      ),
                    ),
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
