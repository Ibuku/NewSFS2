import 'dart:convert';

import 'package:http/http.dart';

import '../viewmodels/application_view_model.dart';
// import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
// import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

class ProfileViewModel extends ApplicationViewModel {
  final DialogService _dialogService = locator<DialogService>();
  // final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _applicationService = locator<ApplicationService>();
  // final AuthenticationService _authenticationService =
  //     locator<AuthenticationService>();

  Future updateUser(Map _userProfile) async {
    setBusy(true);

    var result = await _applicationService.updateUserProfile(_userProfile);

    setBusy(false);

    if (result.runtimeType == Response) {
      var body = jsonDecode(result.body);
      if (result.statusCode == 200) {
        setBusy(true);
        await ApplicationViewModel().getUserProfile();
        setBusy(false);
        print("Profile updated successfully");

        // _navigationService.navigateAndClearRoute(DashboardScreen.routeName);
      } else if (result.statusCode == 400) {
        await _dialogService.showDialog(
          title: 'Profile Update failed',
          description: body['message'],
        );
      } else {
        await _dialogService.showDialog(
          title: 'Profile Update failed',
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
