import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sfscredit/services/dialog_service.dart';

import '../models/user.dart';

import '../services/authentication_service.dart';
// import '../services/dialog_service.dart';
// import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'base_model.dart';

class ApplicationViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User _user;

  getUser() {
    _user = _application.getUser;
    return _user;
  }

  Future getUserProfile() async {
    var userProfile = await _application.userProfile();
    if (userProfile.statusCode == 200) {
      var body = jsonDecode(userProfile.body);
      _authenticationService.loadUser(body['data']);
      ApplicationService.user = User.fromJson(body['data']);
    }
  }

  void toRoute(String type) {
    switch (type) {
      // case "back":
      //   _navigationService.pop();
      //   break;
      // case "activate-account":
      //   // _navigationService.navigateTo(
      //   //   ActivateAccount.routeName,
      //   // );
      //   break;
      default:
    }
  }

  Future<bool> onWillPop() async {
    bool ans = false;
    await _dialogService
        .showConfirmationDialog(
      title: "Confirm Action !",
      description: "Do you want to exit SFS Credit",
      cancelTitle: "No",
      confirmationTitle: "Yes",
    )
        .then((val) {
      ans = val.confirmed;
    });
    return ans;
  }
}
