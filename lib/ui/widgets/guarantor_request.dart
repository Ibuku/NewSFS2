import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';

class GuarantorRequestWidget extends StatelessWidget {
  GuarantorRequestWidget({@required this.request});

  final GuarantorRequest request;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Clicked");
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/person.png",
              ),
            ),
            ),
           Flexible(
             flex: 7,
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 Column(
                   children: <Widget>[
                     Text(
                       "Donald Trump",
                       style: GoogleFonts.mavenPro(
                         textStyle: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.w600,
                           color: primaryColor,
                         ),
                       ),
                     ),
                     Text(
                       "${new DateFormat('d MMM yyyy').format(DateTime.parse(request.createdAt))}",
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
                       "N ${new NumberFormat('###,###').format(request.loanAmount)}.00",
                       style: GoogleFonts.mavenPro(
                         textStyle: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                           color: primaryColor,
                         ),
                       ),
                     ),
                     Text(
                       "Active",
                       style: GoogleFonts.mavenPro(
                         textStyle: TextStyle(
                           fontSize: 12,
                           fontWeight: FontWeight.normal,
                           color: lightGrey,
                         ),
                       ),
                     )
                   ],
                 )
               ],
             ),
           ),
            Flexible(
              flex: 1,
              child: Icon(
                Platform.isAndroid ? Icons.arrow_forward : Icons.arrow_forward_ios,
                color: lightGrey,
                size: 20,
              ),
            )
          ],
        )
      )
    );
  }
}
