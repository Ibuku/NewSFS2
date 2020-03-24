import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sfscredit/ui/views/auth/login_screen.dart';
import 'package:sfscredit/ui/views/auth/reset_password.dart';
import 'package:sfscredit/ui/views/auth/verify/activate_password.dart';
import 'package:sfscredit/viewmodels/signup_view_model.dart';

import '../const.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';

import '../locator.dart';

import 'base_model.dart';

class ForgotPasswordViewModel extends SignUpViewModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  String _userEmail;
  String get userEmail => _userEmail;
  String _otp;
  String get otp => _otp;

  void initParams({String email, String otp}) {
    setLoading(true);

    if (email != null) setUserEmail(email);
    if(otp != null) setOtp(otp);

    setLoading(false);
  }

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void setOtp(String otp) {
    _otp = otp;
    notifyListeners();
  }

  Future forgotPassword() async {
    Map authData = {
      'email': userEmail,
      'type': 'mobile',
      'callback_url': BASE_URL
    };

    setBusy(true);

    var result = await _authenticationService.forgotPassword(
      body: authData,
      type: "password/email",
    );

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        return toRoute("activate-password");
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Password Reset Verification Failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title:  'Account Reset Failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Application Error',
        description: result.toString(),
      );
    }
  }

  Future resetPassword({@required Map authData}) async {
    authData['type'] = 'mobile';
    print("Auth: $authData");
    setBusy(true);

    var result = await _authenticationService.resetPassword(body: authData);

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        await _dialogService.showDialog(
          title: body['message'],
          description: "Proceed to Login",
        );
        _navigationService.navigateTo(LoginScreen.routeName, replace: true);
      } else {
        print("Body(Error): $body");
        await _dialogService.showDialog(
          title: 'Password Reset Failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Application Error',
        description: result.toString(),
      );
    }
  }

  Future verifyOtp({@required Map authData, @required String otpText}) async {
    if (otpText == '' || otpText == null) {
      await _dialogService.showDialog(
        title: 'validation error',
        description: "OTP is required",
      );
      return;
    } else {
      if (otpText.length > 6 || otpText.length < 6) {
        await _dialogService.showDialog(
          title: 'validation error',
          description: "PIN is greater or less than 6 digits",
        );
        return;
      }
    }
    setBusy(true);

    var result = await _authenticationService.verifyAccount(
      authData: authData,
      type: "account/verify/otp",
    );

    setBusy(false);
    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        setOtp(otpText);
        return toRoute("reset-password");
      } else {
        await _dialogService.showDialog(
          title: 'Password Reset Verification Failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Application Error',
        description: result.toString(),
      );
    }
  }

  void goBack() {
    _navigationService.pop();
  }

  Future resendOTP2() async {
    setLoading(true);

    Map authData = {
      'email': userEmail,
      'type': 'mobile',
      'callback_url': BASE_URL
    };

    var result = await _authenticationService.forgotPassword(
      body: authData,
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
      case "activate-password":
        if (userEmail != null) {
          _navigationService.navigateTo(
            ActivatePassword.routeName,
            arguments: userEmail,
            replace: true
          );
        } else {
          _dialogService.showDialog(
            title: "Validation error",
            description: "You have not selected a company",
          );
        }
        break;
       case 'reset-password':
         if (userEmail != null) {
           _navigationService.navigateTo(
             ResetPassword.routeName,
             arguments: {'email': userEmail, 'otp': otp},
             replace: true
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

  void alert({@required String title, @required String description}) {
    _dialogService.showDialog(
      title: title,
      description: description,
    );
  }
}
