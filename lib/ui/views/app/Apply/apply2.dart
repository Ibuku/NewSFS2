import 'package:email_validator/email_validator.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
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
import 'package:sfscredit/viewmodels/loan_application_view_model.dart';

class ApplyScreen2 extends StatefulWidget {
  static const routeName = '/app/Apply/apply2';

  final LoanPackage loanPackage;

  ApplyScreen2({Key key, @required this.loanPackage}) : super(key: key);

  @override
  _ApplyScreen2State createState() => _ApplyScreen2State();
}

class _ApplyScreen2State extends State<ApplyScreen2> {
  final _formKey = GlobalKey<FormState>();

  Map _reqData = {};
  Map _cardReqData = {};
  Map _bankDetailsReqData = {};

  final _accountNoController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _bankController = TextEditingController();
  final  _cardController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoanApplicationViewModel>.withConsumer(
      viewModel: LoanApplicationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => WillPopScope(
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
            show: model.loading,
            title: "Loading...",
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      decoration: BoxDecoration(
                          color: primaryColor
                      ),
                      child: CardItem(
                        customTitleTextWidget: Text(
                          "Current Salary",
                          style: GoogleFonts.mavenPro(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ).copyWith(color: primaryColor),
                        ),
                        customBtnTextWidget: Text(
                          "N 1,000.00",
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
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: CustomCard(
                          padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: CustomTextField(
                                    hintText: "Account Number",
                                    hintTextStyle: TextStyle(
                                        fontSize: 12
                                    ),
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
                                      _bankDetailsReqData['account_number'] = value;
                                    },
                                    textController: _accountNoController,
                                    inputType: TextInputType.number,
                                    readOnly: model.bankDetails?.accountNo != null,
                                    onChanged: (value) async {
                                      if(model.selectedBank != null && value.toString().length == 10){
                                        await model.resolveBankDetails(value, model.selectedBank);
                                        _accountNameController.text = model.bankAccountName;
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
                                    hintTextStyle: TextStyle(
                                        fontSize: 12
                                    ),
                                    textController: _bankController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Please select a bank";
                                      }
                                      return null;
                                    },
                                    enabled:!model.loading,
                                    onSaved: (value) {
                                      model.setSelectedBank(value);
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
                                            dataSource: model.loading ? []: model.banks,
                                          ),
                                          fullscreenDialog: false,
                                        ),
                                      ).then((value) async {
                                        if (value != null) {
                                          model.setSelectedBank(value);
                                          print("Account No Controller " + _accountNoController.value.toString());
                                          if(_accountNoController.text.length == 10){
                                            await model.resolveBankDetails(_accountNoController.text, model.selectedBank);
                                            _accountNameController.text = model.bankAccountName;
                                          }
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
                                hintTextStyle: TextStyle(
                                    fontSize: 12
                                ),
                                textController: _accountNameController,
                                readOnly: true,
                                enabled: !model.loading
                              ),
                              verticalSpace(15),
                              CustomTextField(
                                hintText: "Guarantor Email",
                                hintTextStyle: TextStyle(
                                    fontSize: 12
                                ),
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
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                model.cards.length > 0 ? "Select A Card" : "Add Card",
                                style: GoogleFonts.mavenPro(
                                    fontSize: 18, fontWeight: FontWeight.bold)
                                    .copyWith(color: Colors.indigo[900]),
                              ),
                            ),
                            verticalSpace15,
                            // When User has at least 1 verified card on the platform
                            model.cards.length > 0 ? CustomTextField(
                              hintText: model.loading
                                  ? "Loading Cards ..."
                                  : (model.selectedCard != null
                                  ? model.selectedCard.display
                                  : "Select a card"),
                              hintTextStyle: TextStyle(
                                  fontSize: 12
                              ),
                              textController: _cardController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please select a card";
                                }
                                return null;
                              },
                              enabled:!model.loading,
                              onSaved: (value) {
                                model.setSelectedCard(value);
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
                                      title: "Select a card",
                                      dataSource: model.loading ? []: model.cards,
                                    ),
                                    fullscreenDialog: false,
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    model.setSelectedCard(value);
                                  }
                                });
                              },
                            ):
                            // When the user has no card on the platform
                            // - FIND A WAY TO CALL PAYSTACK TO CHARGE THEM N10
                            // TO VERIFY THEIR CARD and ADD IT TO THE PLATFORM.
                            Container(),
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
                          busy: model.busy,
                        ),
                        BusyButton(
                          title: "Finish",
                          onPressed: () async {
                            if (_reqData.isEmpty) {
                              return;
                            }
                            await model.makeLoanRequest();
                          },
                          busy: model.busy,
                        ),
                      ],
                    ),
                    verticalSpace30
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
