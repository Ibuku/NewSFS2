import 'dart:convert';

import 'package:sfscredit/ui/views/app/profile/update_kyc.dart';

import '../models/user.dart';

import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'base_model.dart';

class ApplicationViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User _user;

  User get user {
    _user = _application.getUser;
    return _user;
  }

  set user(userJson) {
    _authenticationService.loadUser(userJson);
    ApplicationService.user = User.fromJson(userJson);
  }

  Future getUserProfile() async {
    var userProfile = await _application.userProfile();
    if (userProfile.statusCode == 200) {
      var body = jsonDecode(userProfile.body);
      user = body['data'];
      // _authenticationService.loadUser(body['data']);
      // ApplicationService.user = User.fromJson(body['data']);
    }
  }

  void toRoute(String type) {
    switch (type) {
      case UpdateKYC.routeName:
        _navigationService.navigateTo(UpdateKYC.routeName);
        break;
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
