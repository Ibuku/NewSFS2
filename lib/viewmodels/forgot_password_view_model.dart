import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

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

  Future forgotPassword({
    @required Map authData,
  }) async {
    setBusy(true);

    var result = await _authenticationService.forgotPassword(
      body: authData,
      type: "password/email",
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
}
