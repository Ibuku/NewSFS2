import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';

import 'custom_card.dart';

class LoanPackageWidget extends StatelessWidget {
  LoanPackageWidget(
      {@required this.package, @required this.onPressed, this.selectedPackage});

  final LoanPackage package, selectedPackage;
  final Function onPressed;
  
  int monthlyRepayment(LoanPackage package) {
      return (package.totalPayback / package.tenure).round();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        verticalSpace20,
        CustomCard(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(textDirection: TextDirection.ltr, children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 30,
                    child:  Radio(
                        value: package,
                        groupValue: selectedPackage,
                        onChanged: (LoanPackage value) {
                          onPressed(value);
                        }),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Package: ${package.name}',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: primaryColor,
                              ),
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'N ${new NumberFormat('###,###').format(package.amount)}.00',
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child:Text(
                            'Interest Rate(%) = ${package.interestRate} | Tenure = ${package.tenure} months',
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: lightGrey,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
