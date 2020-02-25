import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../locator.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required Map authData,
  }) async {
    setBusy(true);

    var result = await _authenticationService.authenticate(
      authData: authData,
      type: "login",
    );

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        // if (result) {
        //   _navigationService.navigateTo("");
        // } else {
        //   await _dialogService.showDialog(
        //     title: 'Sign Up Failure',
        //     description: 'General sign up failure. Please try again later',
        //   );
        // }
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Login Failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'Login Failed',
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
}
