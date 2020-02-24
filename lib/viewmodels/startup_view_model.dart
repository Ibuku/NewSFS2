import '../locator.dart';

import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';

import '../ui/views/intro/splash_screen.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    Future.delayed(Duration(seconds: 3), () {
      _navigationService.navigateTo(SplashScreen.routeName, replace: true);
    });
  }
}
