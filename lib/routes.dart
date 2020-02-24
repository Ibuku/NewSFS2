import 'package:flutter/material.dart';

import 'ui/views/intro/startup_view.dart';
import 'ui/views/intro/splash_screen.dart';

var appRoutes = <String, WidgetBuilder>{
  '/': (ctx) => StartUpView(),
  SplashScreen.routeName: (ctx) => SplashScreen(),

  // SingleStory.routeName: (ctx) => SingleStory(),
  // SingleInformation.routeName: (ctx) => SingleInformation(),
  // SingleEvent.routeName: (ctx) => SingleEvent(),
};