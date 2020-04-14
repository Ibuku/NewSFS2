import 'package:flutter/material.dart';
import 'package:sfscredit/ui/views/app/profile/add_bank_details.dart';

import 'ui/views/app/Loans/loan.dart';

import 'ui/views/app/profile/settings.dart';
import 'ui/views/app/profile/update_kyc.dart';

import 'ui/views/app/Dashboard/dashboard2.dart';
import 'ui/views/app/Dashboard/wallet.dart';

import 'ui/views/intro/startup_view.dart';
import 'ui/views/intro/splash_screen.dart';
import 'ui/views/intro/decision_screen.dart';

import 'ui/views/auth/login_screen.dart';
import 'ui/views/auth/signup/select_company.dart';
import 'ui/views/auth/signup/register_screen.dart';
import 'ui/views/auth/verify/index.dart';
import 'ui/views/auth/verify/activate_account.dart';
import 'ui/views/auth/verify/forgot_password.dart';
import 'ui/views/auth/verify/activate_password.dart';
import 'ui/views/auth/reset_password.dart';

import 'ui/views/app/Apply/apply1.dart';
import 'ui/views/app/Apply/apply2.dart';

import 'ui/views/app/Requests/allRequest.dart';

var appRoutes = <String, WidgetBuilder>{
  '/': (ctx) => StartUpView(),
  SplashScreen.routeName: (ctx) => SplashScreen(),
  DecisionScreen.routeName: (ctx) => DecisionScreen(),
  LoginScreen.routeName: (ctx) => LoginScreen(),
  SelectCompany.routeName: (ctx) => SelectCompany(),
  RegisterScreen.routeName: (ctx) => RegisterScreen(),
  VerifyIndex.routeName: (ctx) => VerifyIndex(),
  ActivateAccount.routeName: (ctx) => ActivateAccount(),
  ActivatePassword.routeName: (ctx) => ActivatePassword(),
  ForgotPassword.routeName: (ctx) => ForgotPassword(),
  ResetPassword.routeName: (ctx) => ResetPassword(),
  DashboardScreen.routeName: (ctx) =>DashboardScreen(),
  ApplyScreen1.routeName: (ctx) =>ApplyScreen1(),
  ApplyScreen2.routeName: (ctx) =>ApplyScreen2(),
  MyLoanScreen.routeName: (ctx) =>MyLoanScreen(),
  UpdateKYC.routeName: (ctx) => UpdateKYC(),
  WalletScreen.routeName: (ctx) => WalletScreen(),
  AllRequestScreen.routeName: (ctx) => AllRequestScreen(),
  SettingScreen.routeName: (ctx) => SettingScreen(),
  AddBankDetails.routeName: (ctx) => AddBankDetails(),
};