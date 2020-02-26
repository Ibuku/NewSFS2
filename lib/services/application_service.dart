import 'dart:async';

import 'package:sfscredit/locator.dart';
import 'package:sfscredit/services/local_storage_service.dart';

import '../models/user.dart';

class ApplicationService {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();
  static StreamController _user$;

  static User user = User(); // store the current authenticated user

  User get getUser => user;

  static Future<void> initialize() async {
    _user$ = StreamController<String>.broadcast();
  }

  Future<void> logout() async {
    await _localStorageService.empty();
  }

  static void dispose() {
    _user$.close();
  }
}
