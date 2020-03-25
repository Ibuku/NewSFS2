import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:sfscredit/ui/shared/app_colors.dart';

class CustomListItem extends StatelessWidget {
  CustomListItem({@required this.leadingIcon, @required this.title, @required this.date, @required this.amount, this.arrowIconColor});

  final Widget leadingIcon;
  final String title;
  final String date;
  final int amount;
  final Color arrowIconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: leadingIcon
                ),
                Flexible(
                  flex: 7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            title,
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${new DateFormat('d MMM yyyy').format(DateTime.parse(date))}",
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
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "N ${new NumberFormat('###,###').format(amount)}.00",
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        print("Clicked");
//                        setState(() {
//                          _clicked = !_clicked;
//                        });
                      },
                      child: Icon(
                        Platform.isAndroid
                            ? Icons.arrow_forward
                            : Icons.arrow_forward_ios,
                        color: arrowIconColor ?? Colors.white,
                        size: 20,
                      )),
                )
              ],
            )),
      ],
    );
  }
}
