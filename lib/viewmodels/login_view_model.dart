import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sfscredit/ui/views/app/Dashboard/dashboard2.dart';
import '../viewmodels/application_view_model.dart';
import '../ui/views/auth/verify/index.dart';
import '../ui/views/auth/verify/forgot_password.dart';
import '../ui/views/auth/signup/select_company.dart';

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

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  void setPasswordVisible(bool val) {
    _passwordVisible = val;
    notifyListeners();
  }

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
        setBusy(true);
        _authenticationService.loadToken(body);
        ApplicationViewModel().user = body['data'];
        // _authenticationService.loadUser(body['data']);
        // ApplicationService.user = User.fromJson(body['data']);
        await ApplicationViewModel().getUserProfile();
        setBusy(false);

        _navigationService.navigateAndClearRoute(DashboardScreen.routeName);
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
        description: result.toString(),
      );
    }
  }

  void toRoute(String type) {
    String toRoute = "";
    switch (type) {
      case "register":
        toRoute = SelectCompany.routeName;
        break;
      case "forgot-password":
        toRoute = ForgotPassword.routeName;
        break;
      case "verify-email":
        toRoute = VerifyIndex.routeName;
        break;
      default:
        toRoute = SelectCompany.routeName;
        break;
    }
    _navigationService.navigateTo(
      toRoute,
      replace: false,
    );
  }
}
