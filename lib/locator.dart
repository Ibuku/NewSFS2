import 'package:get_it/get_it.dart';

import 'services/authentication_service.dart';
import 'services/base_service.dart';
import 'services/token_service.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';
import 'services/local_storage_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  locator.registerLazySingleton(() => BaseService());
  locator.registerLazySingleton(() => TokenService());
  
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() async => await LocalStorageService.getInstance());
}
