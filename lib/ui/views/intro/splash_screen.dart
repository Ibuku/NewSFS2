import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/intro/splash';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Hello &\nWelcome!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mavenPro(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    textStyle: TextStyle(color: sfsPrimaryColor)
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/new_images/splash.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
