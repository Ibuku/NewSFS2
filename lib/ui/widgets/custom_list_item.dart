import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';

class CustomListItem extends StatelessWidget {
  CustomListItem(
      {@required this.leadingIcon,
      @required this.title,
      @required this.date,
      @required this.amount,
      this.color,
      this.actionIcon});

  final Widget leadingIcon;
  final String title;
  final String date;
  final int amount;
  final Color color;
  final IconButton actionIcon;

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
                Flexible(flex: 1, child: leadingIcon),
                horizontalSpace(15),
                Flexible(
                  flex: 7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: GoogleFonts.mavenPro(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: color ?? primaryColor,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${new DateFormat('d MMM yyyy').format(DateTime.parse(date))}",
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: color == Colors.white ? color : lightGrey,
                              ),
                            ),
                          )),
                        ],
                      ),),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "N ${new NumberFormat('###,###').format(amount)}.00",
                          style: GoogleFonts.mavenPro(
                            textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: color ?? primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                 Flexible(
                  flex: 1,
                  child: actionIcon != null ? actionIcon : Container(),
                ),
              ],
            )),
      ],
    );
  }
}
