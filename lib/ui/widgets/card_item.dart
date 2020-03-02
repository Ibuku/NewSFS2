import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/ui_helpers.dart';

class CardItem extends StatelessWidget {
  final String titleText;
  final String btnText;
  final IconData icon;
  final Function onPressed;

  const CardItem({this.titleText, this.btnText, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  titleText,
                  style: GoogleFonts.mavenPro(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ).copyWith(color: primaryColor),
                ),
                Icon(icon),
              ],
            ),
            verticalSpace15,
            FlatButton(
              child: Text(
                btnText,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                ).copyWith(color: primaryColor, fontSize: 16),
              ),
              onPressed: onPressed,
              color: Color(0xffDBD9E2),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
    );
  }
}
