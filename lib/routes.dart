import 'package:flutter/material.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';

import 'ui/views/app/dashboard.dart';

import 'ui/views/intro/startup_view.dart';
import 'ui/views/intro/splash_screen.dart';
import 'ui/views/intro/decision_screen.dart';

import 'ui/views/auth/login_screen.dart';
import 'ui/views/auth/signup/select_company.dart';
import 'ui/views/auth/signup/register_screen.dart';
import 'ui/views/auth/verify/index.dart';
import 'ui/views/auth/verify/activate_account.dart';
import 'ui/views/auth/forgot_password.dart';
import 'ui/views/app/Apply/apply1.dart';

var appRoutes = <String, WidgetBuilder>{
  '/': (ctx) => StartUpView(),
  SplashScreen.routeName: (ctx) => SplashScreen(),
  DecisionScreen.routeName: (ctx) => DecisionScreen(),

  LoginScreen.routeName: (ctx) => LoginScreen(),
  SelectCompany.routeName: (ctx) => SelectCompany(),
  RegisterScreen.routeName: (ctx) => RegisterScreen(),
  VerifyIndex.routeName: (ctx) => VerifyIndex(),
  ActivateAccount.routeName: (ctx) => ActivateAccount(),
  ForgotPassword.routeName: (ctx) => ForgotPassword(),

  DashboardScreen.routeName: (ctx) =>DashboardScreen(),
  ApplyScreen1.routeName: (ctx) =>ApplyScreen1(),
  //ApplyScreen2.routeName: (ctx) =>ApplyScreen2(),
};