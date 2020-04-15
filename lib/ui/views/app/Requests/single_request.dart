import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:sfscredit/models/company.dart';
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';
import '../../../../ui/widgets/custom_scaffold.dart';

class SingleRequest extends StatelessWidget {
  final GuarantorRequest request;
  final Company company;

  SingleRequest({@required this.request, @required this.company});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTitle: "Loan Request",
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                    "${request.loanRequest.user.firstname} ${request.loanRequest.user.lastname}",
                    style: GoogleFonts.mavenPro(
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    )),
                verticalSpace30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Date applied",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor),
                        )),
                    Text(
                        "${new DateFormat('d MMMM, yyyy').format(DateTime.parse(request.loanRequest.createdAt))}",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ))
                  ],
                ),
                verticalSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Amount Requested",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor),
                        )),
                    Text(
                        "N ${new NumberFormat('###,###').format(request.loanRequest.loanPackage.amount)}.00",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ))
                  ],
                ),
                verticalSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Current Monthly Salary",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor),
                        )),
                    Text(
                        "N ${new NumberFormat('###,###').format(request.loanRequest.currentSalary)}.00",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ))
                  ],
                ),
                verticalSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Company",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor),
                        )),
                    Text("${company.name}",
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ))
                  ],
                ),
                verticalSpace20,
                Container(
                    decoration: BoxDecoration(color: primaryColor),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Text(
                            "${request.guarantorApproved[0].toUpperCase()}${request.guarantorApproved.substring(1)}",
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: request.guarantorApproved == 'approved'
                                      ? Colors.green
                                      : request.guarantorApproved == 'declined'
                                          ? Colors.red
                                          : Colors.white),
                            ))))
              ],
            ),
          )),
    );
  }
}
