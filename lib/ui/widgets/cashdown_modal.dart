import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/models/user_card.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';
import 'package:sfscredit/viewmodels/payment_view_model.dart';

import 'busy_button.dart';

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
  bool _enoughCashInWallet = false;
  bool _canApproveLoan = false;
  UserCard selectedCard;

  Future approveRequest(
      GuarantorRequestViewModel model, String cashDown) async {
    bool guarantorBankDetailsRes = await model.addGuarantorBankDetails(
        reqData: widget.guarantorBankDetailsReqData);

    if (guarantorBankDetailsRes) {
      bool cashDownRes = await model.cashDownPayment(reqData: {
        'loan_request_id': widget.request.loanRequestId,
        'cash_down': cashDown
      });
      if (cashDownRes) {
        await model.modifyGuarantorRequest(
            reqData: {'loan_request_id': widget.request.loanRequestId},
            action: 'approve');
      }
    }
  }

  Widget _buildSelectCard(PaymentViewModel model) {
    return Column(
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
                    textStyle: TextStyle(fontSize: 15, color: primaryColor))),
          ]);
        }).toList(),
        GestureDetector(
            onTap: () {
              model.startAfreshCharge(model.user.email);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add),
                Text("Add a new card",
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(fontSize: 15, color: primaryColor),
                    ))
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
        viewModel: GuarantorRequestViewModel(),
        onModelReady: (model) {
          model.getWalletBalance();
        },
        builder: (context, model, child) {
          return ViewModelProvider<PaymentViewModel>.withConsumer(
              viewModel: PaymentViewModel(),
              onModelReady: (pModel) {
                pModel.getUsersCards().then((_) {
                  pModel.setBuildContext(widget.parentContext);
                });
              },
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
                          _canApproveLoan
                              ? "Approve Loan"
                              : _choosingCard
                                  ? "Choose Card"
                                  : "Choose Funding Source",
                          style: GoogleFonts.mavenPro(
                            textStyle:
                                TextStyle(fontSize: 17, color: primaryColor),
                          )),
                      verticalSpace15,
                      _canApproveLoan
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  "Do you want to approve this Loan Request?",
                                  style: GoogleFonts.mavenPro(
                                    textStyle: TextStyle(
                                        fontSize: 15, color: primaryColor),
                                  )))
                          : !_choosingCard
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      !_canApproveLoan
                          ? BusyButton(
                              title: _choosingCard ? "Fund Wallet" : "Proceed",
                              onPressed: () async {
                                if (_cashDown == 'no') {
                                  // Admin Funding
                                 setState(() {
                                   _canApproveLoan = true;
                                 });
                                } else if (_cashDown == 'yes') {
                                  setState(() {
                                    _enoughCashInWallet = model.walletBalance >=
                                        widget.request.loanRequest.loanPackage
                                            .amount;
                                    if (_enoughCashInWallet) {
                                      _canApproveLoan = true;
                                    } else {
                                      model.showMessage(
                                          "Insufficient funds in wallet",
                                          "Choose a card to fund wallet");
                                      _choosingCard = true;
                                    }
                                  });
                                  if (_choosingCard &&
                                      pModel.selectedCard != null) {
                                    // Fund Wallet with Loan Request Amount
                                    bool res = await pModel.startWalletCharge({
                                      'amount': widget.request.loanRequest
                                          .loanPackage.amount
                                          .toString()
                                    });
                                    if (res) {
                                      setState(() {
                                        _choosingCard = false;
                                        _enoughCashInWallet = true;
                                        _canApproveLoan = true;
                                      });
                                    }
                                  }
                                }
                              },
                              busy: model.busy ||
                                  model.loading ||
                                  pModel.busy ||
                                  pModel.loading,
                            )
                          : BusyButton(
                              title: "Approve Request",
                              onPressed: () async =>
                                  await approveRequest(model, _cashDown),
                              busy: model.busy || model.loading),
                    ],
                  ),
                );
              });
        });
  }
}
