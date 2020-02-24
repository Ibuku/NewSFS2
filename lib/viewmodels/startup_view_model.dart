import '../locator.dart';

import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';

// import '../ui/views/explore/index.dart';

class StartUpViewModel extends BaseModel {
  // final AuthenticationService _authenticationService =
  //     locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    // var hasLoggedInUser = false;
    Future.delayed(Duration(seconds: 3), () {
      // _navigationService.navigateTo(ExplorePage.routeName, replace: true);
    });

    // var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    // if (hasLoggedInUser) {
    //   _navigationService.navigateTo(HomeViewRoute);
    // } else {
    //   _navigationService.navigateTo(LoginViewRoute);
    // }
  }
}
