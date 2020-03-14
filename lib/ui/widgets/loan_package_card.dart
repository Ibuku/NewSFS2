import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sfscredit/models/loan_package.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/views/app/Apply/apply1.dart';

class LoanPackageWidget extends StatelessWidget {
  LoanPackageWidget({@required this.package});

  final LoanPackage package;

  @override
  Widget build(BuildContext context){
    return Container(
        child: Stack(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 14, bottom: 25),
                padding: EdgeInsets.only(left: 20, right: 40,bottom: 20),
                height: 125,
                width: 345,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(
                          75,
                          97,
                          119,
                          .1,
                        ),
                        blurRadius: 20,
                        offset: Offset(0, 10),)
                    ]),
                child: Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Image(image: AssetImage('assets/images/circle2.png',),color: Colors.grey,alignment: Alignment.topLeft,),
                        new Text('${package.name} Package',
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: primaryColor,
                            ),
                          ),

                        ),

                        RaisedButton(
                          color: Hexcolor('#120A44'),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "See terms ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    new Text('N ${new NumberFormat('###,###').format(package.amount)}.00',
                      style: GoogleFonts.mavenPro(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                    ),
                    new Text('N 25,000.00 monthly repayment',
                      style: GoogleFonts.mavenPro(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryColor,
                        ),
                      ),

                    ),
                  ],
                ),
              )
            ]
        )
    );
  }
}