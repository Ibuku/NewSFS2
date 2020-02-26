import 'dart:convert';

import '../models/user.dart';

import '../services/authentication_service.dart';
// import '../services/dialog_service.dart';
// import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'base_model.dart';

class ApplicationViewModel extends BaseModel {
  // final DialogService _dialogService = locator<DialogService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  getUser() {
    return _application.getUser;
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
}
