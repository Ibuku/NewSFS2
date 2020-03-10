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
const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

TextStyle cardButtonTextStyle = GoogleFonts.nunito(
    fontWeight: FontWeight.bold,
).copyWith(color: primaryColor, fontSize: 16);
