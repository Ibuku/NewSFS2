import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:sfscredit/models/guarantor_request.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';

class GuarantorRequestWidget extends StatefulWidget {
  final GuarantorRequest request;
  final Function modifyRequest;

  GuarantorRequestWidget({@required this.request, this.modifyRequest});

  @override
  _GuarantorRequestState createState() => _GuarantorRequestState();
}

class _GuarantorRequestState extends State<GuarantorRequestWidget> {
  bool _clicked = false;

  Widget buildActionWidget() {
    return Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                widget.modifyRequest(
                    reqData: {'loan_package_id': widget.request.loanRequestId},
                    action: 'approve');
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
                widget.modifyRequest(
                    reqData: {'loan_package_id': widget.request.loanRequestId},
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
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
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
                            "${new DateFormat('d MMM yyyy').format(DateTime.parse(widget.request.createdAt))}",
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
                            "N ${new NumberFormat('###,###').format(widget.request.loanRequest.loanPackage.totalPayback)}.00",
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
                  child: GestureDetector(
                      onTap: () {
                        print("Clicked");
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                      child: Icon(
                        Platform.isAndroid
                            ? Icons.arrow_forward
                            : Icons.arrow_forward_ios,
                        color: lightGrey,
                        size: 20,
                      )),
                )
              ],
            )),
        _clicked && widget.request.loanRequest.status == 'pending' ? buildActionWidget() : Container()
      ],
    );
  }
}
