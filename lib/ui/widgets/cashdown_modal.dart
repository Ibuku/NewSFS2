import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/models/user_card.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/widgets/custom_text_field.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';

import 'busy_button.dart';
import 'full_screen_picker.dart';

class CashDownModal extends StatefulWidget {
  final BuildContext parentContext;
  final GuarantorRequest request;
  final Map guarantorBankDetailsReqData;

  CashDownModal(
      {@required this.parentContext,
      @required this.request,
      @required this.guarantorBankDetailsReqData});

  @override
  _CashDownModalState createState() => _CashDownModalState();
}

class _CashDownModalState extends State<CashDownModal> {
  String _cashDown = 'no';
  bool _choosingCard = false;
  UserCard selectedCard;

  Future approveRequest(
      GuarantorRequestViewModel model, String cashDown) async {
    bool cashDownRes = await model.cashDownPayment(reqData: {
      'loan_request_id': widget.request.loanRequestId,
      'cash_down': cashDown
    });
    if (cashDownRes) {
      bool guarantorBankDetailsRes = await model.addGuarantorBankDetails(
          reqData: widget.guarantorBankDetailsReqData);
      if (guarantorBankDetailsRes) {
        await model.modifyGuarantorRequest(
            reqData: {'loan_request_id': widget.request.loanRequestId},
            action: 'approve');
      }
    }
  }

  Widget _buildSelectCard(PaymentViewModel model) {
    return model.cards.length > 0
        ? Column(
            children: <Widget>[
              ...model.cards.map((card) {
                return Row(children: <Widget>[
                  Radio(
                    value: card,
                    groupValue: model.selectedCard,
                    onChanged: (value) {
                      model.setSelectedCard(card);
                    },
                  ),
                  Text("${card.display}",
                      style: GoogleFonts.mavenPro(
                          textStyle:
                              TextStyle(fontSize: 15, color: primaryColor))),
                ]);
              }).toList()
            ],
          )
        : Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BusyButton(
                    title: 'Add a New Card',
                    onPressed: () {
                      model.startAfreshCharge(model.user.email);
                    },
                    busy: model.busy,
                  )
                ],
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
        viewModel: GuarantorRequestViewModel(),
        onModelReady: (model) => model.getWalletBalance(),
        builder: (context, model, child) {
          return ViewModelProvider<PaymentViewModel>.withConsumer(
              viewModel: PaymentViewModel(),
              onModelReady: (pModel) => pModel.getUsersCards(),
              builder: (context, pModel, child) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 35),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _choosingCard
                              ? FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _choosingCard = false;
                                    });
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: primaryColor),
                                )
                              : Container(),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(widget.parentContext).pop();
                            },
                            child: Text("Cancel",
                                style: GoogleFonts.mavenPro(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                )),
                          ),
                        ],
                      ),
                      Text(
                          _choosingCard
                              ? "Choose Card"
                              : "Choose Funding Source",
                          style: GoogleFonts.mavenPro(
                            textStyle:
                                TextStyle(fontSize: 17, color: primaryColor),
                          )),
                      verticalSpace15,
                      !_choosingCard
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 'no',
                                          groupValue: _cashDown,
                                          onChanged: (value) {
                                            setState(() {
                                              _cashDown = 'no';
                                            });
                                          },
                                        ),
                                        Text("Admin Funding",
                                            style: GoogleFonts.mavenPro(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: primaryColor),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: 'yes',
                                          groupValue: _cashDown,
                                          onChanged: (value) {
                                            setState(() {
                                              _cashDown = 'yes';
                                            });
                                          },
                                        ),
                                        Text("Cashdown",
                                            style: GoogleFonts.mavenPro(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: primaryColor),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          : _buildSelectCard(pModel),
                      verticalSpace15,
                      BusyButton(
                        title: _choosingCard ? "Fund Wallet" : "Proceed",
                        onPressed: () async {
                          bool enoughCashInWallet = model.walletBalance >=
                              widget
                                  .request.loanRequest.loanPackage.totalPayback;
                          if (_cashDown == 'no') {
                            // Admin Funding
                            await approveRequest(model, 'no');
                          } else if (_cashDown == 'yes' && enoughCashInWallet) {
                            // CashDown with enough cash in the Wallet
                            await approveRequest(model, 'yes');
                          } else if (_choosingCard &&
                              pModel.selectedCard != null) {
                            // Fund Wallet with Loan Request Amount
                            bool res = await pModel.startWalletCharge({
                              'amount': widget
                                  .request.loanRequest.loanPackage.amount
                                  .toString()
                            });
                            if (res) {
                              // CashDown after Wallet Fund
                              await approveRequest(model, 'yes');
                            }
                          } else if (_cashDown == 'yes' &&
                              !enoughCashInWallet) {
                            // CashDown with insufficient funds
                            model.showMessage("Insufficient funds in wallet",
                                "Choose a card to fund wallet");
                            setState(() {
                              _choosingCard = true;
                            });
                          }
                        },
                        busy: model.busy ||
                            model.loading ||
                            pModel.busy ||
                            pModel.loading,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
