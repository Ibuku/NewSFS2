import 'dart:async';

import 'package:sfscredit/const.dart';
import 'package:sfscredit/locator.dart';
import 'local_storage_service.dart';
import 'base_service.dart';

import '../models/user.dart';

class ApplicationService {
  final BaseService _network = locator<BaseService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  static StreamController _user$;

  static User user = User(); // store the current authenticated user

  User get getUser => user;

  static Future<void> initialize() async {
    _user$ = StreamController<String>.broadcast();
  }

  Future<void> logout() async {
    await _localStorageService.empty();
  }

  void dispose() async {
    await logout();
    _user$.close();
  }

  Future userProfile() async {
    try {
      final res = await _network.get(
        "$API_BASE_URL/user",
        isAuth: true,
        headers: {
          "Accept": "application/json",
        },
      );
      return res;
    } catch (e) {
      return e;
    }
  }
}
