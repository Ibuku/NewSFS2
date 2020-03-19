import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sfscredit/ui/views/auth/verify/activate_password.dart';

import '../ui/views/auth/login_screen.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';

import '../locator.dart';

import 'base_model.dart';

class ForgotPasswordViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  String _userEmail;

  String get userEmail => _userEmail;

  Future init({String email}) async {
    setLoading(true);

    if (email != null) setUserEmail(email);

    setLoading(false);
  }

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  Future forgotPassword({
    @required Map authData, String otpText,
  }) async {
    setBusy(true);

    var result = await _authenticationService.forgotPassword(
      body: authData,
      type: "mobile",
    );

    setBusy(false);
    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        await _dialogService.showDialog(
          title: 'Password reset successful',
          description: body['message'],
        );
        _navigationService.navigateTo(LoginScreen.routeName, replace: true);
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Password reset failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'Password reset failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Application error',
        description: result,
      );
    }
  }

  void goBack() {
    _navigationService.pop();
  }

  Future resendOTP() async {
    setLoading(true);

    var result = await _authenticationService.resendOTP(
      email: userEmail,
      type: "password/email",
    );

    setLoading(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        await _dialogService.showDialog(
          title: 'OTP Resend request Sent',
          description: body['message'],
        );
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'OTP Resend failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'OTP Resend failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'OTP Resend failed',
        description: result.toString(),
      );
    }
  }

  void toRoute(String type) {
    switch (type) {
      case "cancel":
        _navigationService.pop();
        break;
      case "activate-account":
        if (userEmail != null) {
          _navigationService.navigateTo(
            ActivateAccount.routeName,
            arguments: userEmail,
          );
        } else {
          _dialogService.showDialog(
            title: "Validation error",
            description: "You have not selected a company",
          );
        }
        break;
      default:
    }
  }

}


