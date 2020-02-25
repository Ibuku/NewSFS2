import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../ui/views/auth/login_screen.dart';
import '../ui/views/auth/verify/activate_account.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../locator.dart';

import 'base_model.dart';

class AccountActivateViewModel extends BaseModel {
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

  Future verifyAccount({
    @required Map authData,
  }) async {
    if (authData['pin'].length > 6 || authData['pin'].length < 6) {
      await _dialogService.showDialog(
        title: 'validation error',
        description: "PIN is greater or less than 6 digits",
      );
      return;
    }
    setBusy(true);

    var result = await _authenticationService.authenticate(
      authData: authData,
      type: "verify/otp",
    );

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        _navigationService.navigateTo(LoginScreen.routeName, replace: true);
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Account verification failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'Account verification failed',
          description: body['message'],
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Account verification failed',
        description: result,
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
