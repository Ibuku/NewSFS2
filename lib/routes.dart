import 'package:flutter/material.dart';

import 'ui/views/intro/startup_view.dart';
import 'ui/views/intro/splash_screen.dart';
import 'ui/views/intro/decision_screen.dart';

import 'ui/views/auth/login_screen.dart';
import 'ui/views/auth/signup/select_company.dart';
import 'ui/views/auth/signup/register_screen.dart';

var appRoutes = <String, WidgetBuilder>{
  '/': (ctx) => StartUpView(),
  SplashScreen.routeName: (ctx) => SplashScreen(),
  DecisionScreen.routeName: (ctx) => DecisionScreen(),

  LoginScreen.routeName: (ctx) => LoginScreen(),
  SelectCompany.routeName: (ctx) => SelectCompany(),
  RegisterScreen.routeName: (ctx) => RegisterScreen(),
};