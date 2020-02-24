import 'package:flutter/material.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;

  const TextLink(
    this.text, {
    this.onPressed,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }
}
