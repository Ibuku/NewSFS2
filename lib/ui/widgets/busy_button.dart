import 'package:flutter/material.dart';
import 'package:sfscredit/ui/shared/app_colors.dart';
import '../shared/shared_styles.dart';

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;

  const BusyButton({
    @required this.title,
    this.busy = false,
    @required this.onPressed,
    this.enabled = true,
  });

  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          decoration: BoxDecoration(
            color: widget.enabled ? primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).dividerColor,
                blurRadius: 8,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: !widget.busy
              ? Text(
                  widget.title,
                  style: buttonTitleTextStyle,
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
        ),
      ),
    );
  }
}
