import 'package:flutter/material.dart';
import '../shared/app_colors.dart';

/// A modal overlay that will show over your child widget (fullscreen) when the show value is true
///
/// Wrap your scaffold in this widget and set show value to model.isBusy to show a loading modal when
/// your model state is Busy
class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;
  final Color overlayBackground;

  const BusyOverlay({
    this.child,
    this.title = 'Please wait...',
    this.show = false,
    this.overlayBackground = const Color.fromARGB(100, 0, 0, 0)
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: <Widget>[
          child,
          IgnorePointer(
            child: Opacity(
              opacity: show ? 1.0 : 0.0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                alignment: Alignment.center,
                color: overlayBackground,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                    SizedBox(height: 10),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
