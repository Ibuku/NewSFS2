import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:sfscredit/ui/views/app/Apply/apply2.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import 'package:sfscredit/ui/views/app/Requests/allRequest.dart';
import 'package:sfscredit/ui/views/app/Requests/approvedRequest.dart';
import 'package:sfscredit/ui/views/app/Requests/declinedRequest.dart';
import 'package:sfscredit/ui/views/app/Requests/pendingRequest.dart';
import 'package:sfscredit/ui/views/app/Requests/request.dart';
import 'package:sfscredit/ui/views/app/privacypolicy.dart';
import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';

import 'ui/views/app/Dashboard/dashboard.dart';
=======
import 'package:sfscredit/ui/views/app/dashboard2.dart';
//import 'package:sfscredit/ui/views/app/Apply/apply2.dart';

import 'ui/views/app/profile/update_kyc.dart';

import 'ui/views/app/dashboard.dart';
>>>>>>> fec8536300d401894e7189b24d220ef78b9393e3

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
  Dashboard2Screen.routeName: (ctx) =>Dashboard2Screen(),
  ApplyScreen1.routeName: (ctx) =>ApplyScreen1(),
<<<<<<< HEAD
  UpdateKYC.routeName: (ctx) => UpdateKYC(),
  ApplyScreen2.routeName: (ctx) =>ApplyScreen2(),
  Request1Screen.routeName: (ctx) => Request1Screen(),
  AllRequestScreen.routeName: (ctx) => AllRequestScreen(),
  ApprovedRequestScreen.routeName: (ctx) => ApprovedRequestScreen(),
  DeclinedRequestScreen.routeName: (ctx) => DeclinedRequestScreen(),
  PendingRequestScreen.routeName: (ctx) => PendingRequestScreen(),
  PolicyScreen.routeName: (ctx) => PolicyScreen(),
=======
  //ApplyScreen2.routeName: (ctx) =>ApplyScreen2(),
  UpdateKYC.routeName: (ctx) => UpdateKYC(),
  Dashboard2Screen.routeName: (ctx) =>DashboardScreen(),
>>>>>>> fec8536300d401894e7189b24d220ef78b9393e3
};