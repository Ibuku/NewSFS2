import 'package:get_it/get_it.dart';

import 'services/payment_service.dart';
import 'services/application_service.dart';
import 'services/authentication_service.dart';
import 'services/network_service.dart';
import 'services/token_service.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';
import 'services/local_storage_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var lsInstance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(lsInstance);

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => TokenService());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ApplicationService());
  locator.registerLazySingleton(() => PaymentService());
}
