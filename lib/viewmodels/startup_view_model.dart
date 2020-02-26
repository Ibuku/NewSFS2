import 'package:sfscredit/ui/views/auth/signup/select_company.dart';

import '../locator.dart';

import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';

import '../ui/views/intro/splash_screen.dart';
import '../ui/views/intro/decision_screen.dart';

import '../ui/views/auth/login_screen.dart';
import '../ui/views/auth/signup/select_company.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.navigateTo(SplashScreen.routeName, replace: true);
    });
  }

  Future handleSplashLogic() async {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.navigateTo(DecisionScreen.routeName, replace: true);
    });
  }

  void toAuth(String type) {
    String toRoute = "";
    switch (type) {
      case "login":
        toRoute = LoginScreen.routeName;
        break;
      case "register":
        toRoute = SelectCompany.routeName;
        break;
      default:
        toRoute = LoginScreen.routeName;
        break;
    }
    _navigationService.navigateTo(
      toRoute,
      replace: false,
    );
  }
}
