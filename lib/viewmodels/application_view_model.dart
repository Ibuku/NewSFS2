import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../services/application_service.dart';
import '../locator.dart';

import 'base_model.dart';

class ApplicationViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApplicationService _application = locator<ApplicationService>();

  getUser() {
    return _application.getUser;
  }

  void toRoute(String type) {
    switch (type) {
      case "back":
        _navigationService.pop();
        break;
      case "activate-account":
        // _navigationService.navigateTo(
        //   ActivateAccount.routeName,
        // );
        break;
      default:
    }
  }
}
