import 'package:get_it/get_it.dart';

import 'services/base_service.dart';
import 'services/token_service.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  locator.registerLazySingleton(() => BaseService());
  locator.registerLazySingleton(() => TokenService());
  // locator.registerLazySingleton(() => ExploreService());
  // locator.registerLazySingleton(() => AuthenticationService());
  // locator.registerLazySingleton(() => FirestoreService());
}
