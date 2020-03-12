import 'dart:async';
import 'dart:convert';
import 'package:sfscredit/const.dart';
import 'package:sfscredit/locator.dart';
import 'local_storage_service.dart';
import 'network_service.dart';

import '../models/user.dart';

class ApplicationService {
  final NetworkService _network = locator<NetworkService>();
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

  Future updateUserProfile(Map body) async {
    try {
      var updateResult = await _network.post(
          "$API_BASE_URL/user/update-profile",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: body,
          encodeBody: false,
          isAuth: true
      );
      return updateResult;
    } catch (e) {
      return e;
    }
  }
  
  Future getActiveLoanRequests() async {
    try{
      return await _network.get("$API_BASE_URL/loan-requests", headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });
    } catch(e) {
      return e;
    }
  }
}
