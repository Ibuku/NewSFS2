import 'package:flutter/material.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import 'package:sfscredit/ui/shared/shared_styles.dart';

class CardBusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;

  const CardBusyButton({
    @required this.title,
    this.busy = false,
    @required this.onPressed,
    this.enabled = true,
  });

  @override
  _CardBusyButtonState createState() => _CardBusyButtonState();
}

class _CardBusyButtonState extends State<CardBusyButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.zero,
      elevation: 3,
      child: GestureDetector(
        onTap: widget.busy ? () {} : widget.onPressed,
        child: InkWell(
          child: AnimatedContainer(
            height: widget.busy ? 40 : null,
            width: widget.busy ? 40 : null,
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: widget.busy ? 10 : 48,
              vertical: widget.busy ? 10 : 18,
            ),
            child: !widget.busy
                ? Text(
                    widget.title,
                    style: cardButtonTextStyle,
                  )
                : CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
          ),
        ),
      ),
    );
  }
}
