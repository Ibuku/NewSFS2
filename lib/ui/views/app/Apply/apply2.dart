import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

import 'package:email_validator/email_validator.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:sfscredit/const.dart';
import 'package:sfscredit/models/bank.dart';

import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/widgets/busy_button.dart';
import 'package:sfscredit/ui/widgets/busy_overlay.dart';
import 'package:sfscredit/ui/widgets/card_item.dart';
import 'package:sfscredit/ui/widgets/custom_card.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/ui/widgets/full_screen_picker.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';

class ApplyScreen2 extends StatefulWidget {
  static const routeName = '/app/Apply/apply2';

  final LoanPackage loanPackage;
  final String currentSalary;

  ApplyScreen2(
      {Key key, @required this.loanPackage, @required this.currentSalary})
      : super(key: key);

  @override
  _ApplyScreen2State createState() => _ApplyScreen2State();
}

class _ApplyScreen2State extends State<ApplyScreen2> {
  final _formKey = GlobalKey<FormState>();

  Map _reqData = {};

  final _accountNoController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _bankController = TextEditingController();
  final _cardController = TextEditingController();

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: PAYSTACK_PUBLIC_KEY);
    _reqData['loan_package_id'] = widget.loanPackage.id.toString();
    _reqData['current_salary'] = int.parse(widget.currentSalary);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _accountNoController.dispose();
    _accountNameController.dispose();
    _bankController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  Widget buildPlatformButton(String string, Function() function) {
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new RaisedButton(
        onPressed: function,
        color: primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: new Text(
          string,
          style:
              GoogleFonts.mavenPro(fontSize: 15, fontWeight: FontWeight.normal)
                  .copyWith(color: Colors.white),
        ),
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PaymentViewModel>.withConsumer(
      viewModel: PaymentViewModel(),
      onModelReady: (model) {
        model.initLoanApplication().then((val) {
          model.setBuildContext(context);
        });
      },
      builder: (context, model, child) => WillPopScope(
        //onWillPop: () async => await model.onWillPop(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Apply"),
              centerTitle: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(FeatherIcons.logOut),
                  onPressed: () async {
                    await model.logout();
                  },
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: BusyOverlay(
              show: model.loading || model.busy,
              title: "Loading...",
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(color: primaryColor),
                        child: CardItem(
                          customTitleTextWidget: Text(
                            "Current Salary",
                            style: GoogleFonts.mavenPro(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ).copyWith(color: primaryColor),
                          ),
                          customBtnTextWidget: Text(
                            "N ${model.formatNumber(int.parse(widget.currentSalary))}.00",
                            style: GoogleFonts.mavenPro(
                              fontWeight: FontWeight.bold,
                            ).copyWith(color: primaryColor, fontSize: 20),
                          ),
                          icon: Icons.person,
                          paddingVertical: 30,
                        ),
                      ),
                      verticalSpaceTiny,
                      Container(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: CustomCard(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Column(
                                textDirection: TextDirection.ltr,
                                children: <Widget>[
                                  new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Loan Type",
                                          style: GoogleFonts.mavenPro(
                                            fontSize: 17,
                                          ).copyWith(color: Colors.indigo[900]),
                                        ),
                                        Text(
                                          "${widget.loanPackage.name}",
                                          style: GoogleFonts.mavenPro(
                                            fontSize: 17,
                                          ).copyWith(color: Colors.indigo[900]),
                                        ),
                                      ])
                                ])),
                      ),
                      verticalSpace15,
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Personal Information",
                          style: GoogleFonts.mavenPro(
                                  fontSize: 18, fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.indigo[900]),
                        ),
                      ),
                      verticalSpace15,
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
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
                                        _reqData['account_number'] = value;
                                      },
                                      textController: _accountNoController,
                                      inputType: TextInputType.number,
                                      onChanged: (value) async {
                                        if (model.selectedBank != null &&
                                            value.toString().length == 10) {
                                          await model.resolveBankDetails(
                                              value, model.selectedBank);
                                          _accountNameController.text =
                                              model.bankAccountName;
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      hintText: model.loading
                                          ? "Loading Banks ..."
                                          : (model.selectedBank != null
                                              ? model.selectedBank.display
                                              : "Select a bank"),
                                      hintTextStyle: TextStyle(fontSize: 12),
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
                                                    new TextEditingValue(
                                                        text: value))
                                                .value;
                                      },
                                      readOnly: true,
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      onTap: () {
                                        if (model.loading ||
                                            model.banks.isEmpty) {
                                          return;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenPicker(
                                              title: "Select a bank",
                                              dataSource: model.loading
                                                  ? []
                                                  : model.banks,
                                            ),
                                            fullscreenDialog: false,
                                          ),
                                        ).then((value) async {
                                          if (value != null) {
                                            model.setSelectedBank(value);
                                            if (_accountNoController
                                                    .text.length ==
                                                10) {
                                              await model.resolveBankDetails(
                                                  _accountNoController.text,
                                                  model.selectedBank);
                                              _accountNameController.text =
                                                  model.bankAccountName;
                                            }
                                            _bankController.value =
                                                new TextEditingController
                                                            .fromValue(
                                                        new TextEditingValue(
                                                            text:
                                                                value.display))
                                                    .value;
                                            _reqData['bank_name'] = value.code;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(15),
                              Column(children: <Widget>[
                                CustomTextField(
                                    hintText: "Account Name",
                                    hintTextStyle: TextStyle(fontSize: 12),
                                    textController: _accountNameController,
                                    readOnly: true,
                                    onSaved: (value) {
                                      _reqData['account_name'] = value;
                                    },
                                    enabled: !model.loading),
                                verticalSpace(15),
                                CustomTextField(
                                  hintText: "Guarantor Email",
                                  hintTextStyle: TextStyle(fontSize: 12),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Guarantor Email is required";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return "Email address is not valid";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _reqData['guarantor_email'] = value;
                                  },
                                ),
                              ]),
                              verticalSpace15,
                              Column(children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                          child: Center(
                                        child: Text(
                                          model.cards.length > 0
                                              ? "Select A Card"
                                              : "Add Card",
                                          style: GoogleFonts.mavenPro(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)
                                              .copyWith(
                                                  color: Colors.indigo[900]),
                                        ),
                                      )),
                                      IconButton(
                                        onPressed: () => model.startAfreshCharge(
                                            model.user.email),
                                          icon: Icon(Icons.add,
                                              color: primaryColor),
                                          color: Colors.transparent,
                                          tooltip: "Add a new Card",
                                          iconSize: 20),
                                    ])),
                                verticalSpace15,
                                // When User has at least 1 verified card on the platform
                                model.cards.length > 0
                                    ? CustomTextField(
                                        hintText: model.loading
                                            ? "Loading Cards ..."
                                            : (model.selectedCard != null
                                                ? model.selectedCard.display
                                                : "Select a card"),
                                        hintTextStyle: TextStyle(fontSize: 12),
                                        textController: _cardController,
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please select a card";
                                          }
                                          return null;
                                        },
                                        enabled: !model.loading,
                                        onSaved: (value) {
                                          _cardController.value =
                                              new TextEditingController
                                                          .fromValue(
                                                      new TextEditingValue(
                                                          text: value))
                                                  .value;
                                        },
                                        readOnly: true,
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                        onTap: () {
                                          if (model.loading ||
                                              model.banks.isEmpty) {
                                            return;
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenPicker(
                                                title: "Select a card",
                                                dataSource: model.loading
                                                    ? []
                                                    : model.cards,
                                              ),
                                              fullscreenDialog: false,
                                            ),
                                          ).then((value) {
                                            if (value != null) {
                                              model.setSelectedCard(value);
                                              _reqData[
                                                      'gw_authorization_code'] =
                                                  value.id.toString();
                                              _cardController.value =
                                                  new TextEditingController
                                                              .fromValue(
                                                          new TextEditingValue(
                                                              text: value
                                                                  .display))
                                                      .value;
                                            }
                                          });
                                        },
                                      )
                                    : Container(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              buildPlatformButton(
                                                  'Add a New Card',
                                                  () => model.startAfreshCharge(
                                                      model.user.email))
                                            ],
                                          ),
                                        ),
                                      ),
                              ])
                            ])),
                      ),
                      verticalSpace30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BusyButton(
                            title: "Cancel",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()),
                              );
                            },
                            busy: false,
                          ),
                          BusyButton(
                            title: "Finish",
                            onPressed: () async {
                              if (_reqData.isEmpty) {
                                return;
                              }
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              await model.makeLoanRequest(reqData: _reqData);
                            },
                            busy: false,
                          ),
                        ],
                      ),
                      verticalSpace30
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
