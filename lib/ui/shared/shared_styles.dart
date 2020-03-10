import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

// Box Decorations

BoxDecoration fieldDecorataion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecorataion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
<<<<<<< HEAD
const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

TextStyle cardButtonTextStyle = GoogleFonts.nunito(
    fontWeight: FontWeight.bold,
=======
    const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

TextStyle cardButtonTextStyle = GoogleFonts.nunito(
  fontWeight: FontWeight.bold,
>>>>>>> fec8536300d401894e7189b24d220ef78b9393e3
).copyWith(color: primaryColor, fontSize: 16);
