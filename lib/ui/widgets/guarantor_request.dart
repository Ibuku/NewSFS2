import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:sfscredit/models/company.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import 'package:sfscredit/ui/views/app/Requests/single_request.dart';
import 'package:sfscredit/ui/widgets/cashdown_modal.dart';
import 'package:sfscredit/viewmodels/guarantor_request_view_model.dart';
import 'package:sfscredit/viewmodels/signup_view_model.dart';

class GuarantorRequestWidget extends StatefulWidget {
  final GuarantorRequest request;
  final String salary;
  final BuildContext parentContext;

  GuarantorRequestWidget(
      {@required this.request, this.salary, @required this.parentContext});

  @override
  _GuarantorRequestState createState() => _GuarantorRequestState();
}

class _GuarantorRequestState extends State<GuarantorRequestWidget> {
  bool _clicked = false;

  bool _isPending() {
    return widget.request.guarantorApproved == 'pending';
  }

  Future<void> showCashDownModal(
      BuildContext pageContext, GuarantorRequest request, Map guarantorBankDetailsReqData) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        backgroundColor: Colors.white,
        context: pageContext,
        builder: (builder) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CashDownModal(
                    parentContext: pageContext, request: request,
                    guarantorBankDetailsReqData: guarantorBankDetailsReqData),
              ),
            ),
          );
        });
  }

  Widget buildActionWidget(GuarantorRequestViewModel model) {
    return Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                if (widget.salary == "") {
                  model.showMessage("Approve Request",
                      "Add Your Salary before you can approve loan request");
                  return;
                }
                if (widget.request.loanRequest.loanPackage.amount >
                    (0.35 * (3 * int.parse(widget.salary)))) {
                  model.showMessage("Approve Loan Request",
                      "Your Current Salary is not enough to approve this Loan Request");
                  return;
                }
                await showCashDownModal(widget.parentContext, widget.request, {
                  'guarantor_salary': widget.salary,
                  'loan_request_id': widget.request.loanRequestId
                });
              },
              color: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(24.0),
              ),
              child: new Text(
                "Approve",
                style: GoogleFonts.mavenPro(
                        fontSize: 15, fontWeight: FontWeight.normal)
                    .copyWith(color: Colors.white),
              ),
            ),
            verticalSpace30,
            RaisedButton(
              onPressed: () {
                model.modifyGuarantorRequest(
                    reqData: {'loan_request_id': widget.request.loanRequestId},
                    action: 'declined');
              },
              color: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(24.0),
              ),
              child: new Text(
                "Decline",
                style: GoogleFonts.mavenPro(
                        fontSize: 15, fontWeight: FontWeight.normal)
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<GuarantorRequestViewModel>.withConsumer(
        viewModel: GuarantorRequestViewModel(),
        builder: (context, model, child) {
          return GestureDetector(
            onTap: () async {
              List<Company> companies = await SignUpViewModel().init();
              Company userCompany = companies.firstWhere((company) =>
                  company.id == widget.request.loanRequest.user.companyId);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => SingleRequest(
                          request: widget.request, company: userCompany)));
            },
            child: Column(
              children: <Widget>[
                Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.request.loanRequest.user?.profile
                                      ?.avatar ??
                                  "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "${widget.request.loanRequest.user?.firstname} ${widget.request.loanRequest.user?.lastname}",
                                    style: GoogleFonts.mavenPro(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${new DateFormat('d MMM yyyy').format(DateTime.parse(widget.request.loanRequest.createdAt))}",
                                    style: GoogleFonts.mavenPro(
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: lightGrey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "N ${new NumberFormat('###,###').format(widget.request.loanRequest.loanPackage.amount)}.00",
                                    style: GoogleFonts.mavenPro(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        _isPending()
                            ? Flexible(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _clicked = !_clicked;
                                    });
                                  },
                                  icon: Icon(
                                      Platform.isAndroid
                                          ? Icons.arrow_forward
                                          : Icons.arrow_forward_ios,
                                      color: lightGrey),
                                  iconSize: 20,
                                ),
                              )
                            : Container()
                      ],
                    )),
                _clicked && _isPending()
                    ? buildActionWidget(model)
                    : Container()
              ],
            ),
          );
        });
  }
}
