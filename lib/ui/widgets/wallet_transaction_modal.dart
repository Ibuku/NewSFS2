import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/bank_details.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/profile/add_bank_details.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';

import 'busy_button.dart';
import 'full_screen_picker.dart';

class WalletTransactionModalWidget extends StatefulWidget {
  final BuildContext parentContext;
  final String transactionType;
  final BankDetails bankDetails;

  WalletTransactionModalWidget(
      {@required this.parentContext,
      @required this.transactionType,
      this.bankDetails});

  @override
  _WalletTransactionModalState createState() => _WalletTransactionModalState();
}

class _WalletTransactionModalState extends State<WalletTransactionModalWidget> {
  final _amountFormKey = GlobalKey<FormState>();

  Map _reqData = {};

  final _amountController = TextEditingController();
  final _cardController = TextEditingController();

  String _modalTitle = "";

  Widget buildCardInput(PaymentViewModel model) {
    return !model.loading && !model.busy
        ? widget.transactionType == 'withdraw'
            ? Container()
            : model.cards.length > 0 && widget.transactionType == 'fund'
                ? CustomTextField(
                    hintText: model.loading
                        ? "Loading Cards ..."
                        : (model.selectedCard != null
                            ? model.selectedCard.display
                            : "Select a card"),
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
                          new TextEditingController.fromValue(
                                  new TextEditingValue(text: value))
                              .value;
                    },
                    readOnly: true,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                    onTap: () {
                      if (model.loading) {
                        return;
                      }
                      Navigator.push(
                        widget.parentContext,
                        MaterialPageRoute(
                          builder: (context) => FullScreenPicker(
                            title: "Select a card",
                            dataSource: model.loading ? [] : model.cards,
                          ),
                          fullscreenDialog: false,
                        ),
                      ).then((value) {
                        if (value != null) {
                          model.setSelectedCard(value);
                          _cardController.value =
                              new TextEditingController.fromValue(
                                      new TextEditingValue(text: value.display))
                                  .value;
                        }
                      });
                    },
                  )
                : Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () =>
                                model.startAfreshCharge(model.user.email),
                            color: primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: new Text(
                              "Add A Card",
                              style: GoogleFonts.mavenPro(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
        : Container();
  }

  Widget _buildForm() {
    return ViewModelProvider<PaymentViewModel>.withConsumer(
        viewModel: PaymentViewModel(),
        onModelReady: (model) {
          var modelInit = widget.transactionType == 'fund'
              ? model.getUsersCards()
              : model.getUsersBankDetails();
          modelInit.then((val) {
            model.setBuildContext(widget.parentContext);
            if (widget.bankDetails == null) {
              Navigator.push(widget.parentContext,
                  MaterialPageRoute(builder: (builder) => AddBankDetails()));
            } else if (widget.bankDetails != null &&
                widget.transactionType == 'withdraw') {
              _reqData['account_number'] = widget.bankDetails.accountNo;
              _reqData['bank_name'] = widget.bankDetails.bankCode;
            }
          });
        },
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(_modalTitle,
                          style: GoogleFonts.mavenPro(
                            textStyle:
                                TextStyle(fontSize: 17, color: primaryColor),
                          )),
                    ),
                  ],
                ),
              ),
              verticalSpace15,
              Form(
                key: _amountFormKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      hintText: 'Amount',
                      textController: _amountController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Amount is required";
                        }
                        return null;
                      },
                      inputType: TextInputType.number,
                      onSaved: (value) {
                        _reqData['amount'] = value;
                      },
                    ),
                    verticalSpace15,
                    buildCardInput(model),
                    widget.transactionType == 'withdraw'
                        ? Container()
                        : verticalSpace15,
                    widget.transactionType == 'withdraw'
                        ? Column(
                            children: <Widget>[
                              Text(
                                "Which account will you like to use?",
                                style: GoogleFonts.mavenPro(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                ),
                              ),
                              verticalSpaceTiny,
                              Row(
                                children: <Widget>[
                                  Radio(
                                    activeColor: primaryColor,
                                    value: widget.bankDetails,
                                    groupValue: widget.bankDetails,
                                  ),
                                  horizontalSpaceSmall,
                                  Text(
                                      "${widget.bankDetails.bankName}: ${widget.bankDetails.accountNo}",
                                      style: GoogleFonts.mavenPro(
                                        textStyle: TextStyle(
                                            fontSize: 15, color: primaryColor),
                                      ))
                                ],
                              )
                            ],
                          )
                        : Container(),
                    verticalSpace15,
                    BusyButton(
                      title:
                          "${widget.transactionType[0].toUpperCase()}${widget.transactionType.substring(1)}",
                      onPressed: () async {
                        if (!_amountFormKey.currentState.validate()) {
                          return;
                        }
                        _amountFormKey.currentState.save();
                        if (widget.transactionType == 'fund') {
                          await model.startWalletCharge(_reqData);
                        } else if (widget.transactionType == 'withdraw') {
                          await model.withdrawFromWallet(_reqData);
                        }
                      },
                      busy: model.busy,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _modalTitle = widget.transactionType == 'withdraw'
        ? "Withdraw From Wallet"
        : "Fund Wallet";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
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
                    textStyle: TextStyle(fontSize: 15, color: primaryColor),
                  )),
            ),
          ),
          _buildForm(),
        ],
      ),
    );
  }
}
