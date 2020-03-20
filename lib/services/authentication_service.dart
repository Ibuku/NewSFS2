import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sfscredit/models/user.dart';

import '../const.dart';
import '../locator.dart';

import 'network_service.dart';
import 'local_storage_service.dart';
import 'token_service.dart';

class AuthenticationService {
  final NetworkService _networkService = locator<NetworkService>();
  final _storageService = locator<LocalStorageService>();
  final TokenService _tokenService = locator<TokenService>();

  final String baseURL = API_BASE_URL;

  get authData => null;



  Future getCompanies() async {
    try {
      return await _networkService.get("$baseURL/companies", headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });
    } catch (e) {
      return (e.message);
    }
  }

  Future authenticate({@required Map authData, @required String type}) async {
    try {
      var authResult = await _networkService.post(
        "$API_BASE_URL/$type",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: authData,
      );
      return authResult;
    } catch (e) {
      return e;
    }
  }

  Future verifyAccount({@required Map authData, @required String type}) async {
    try {
      var authResult = await _networkService.post(
        "$API_BASE_URL/$type",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: authData,
        encodeBody: false,
      );
      return authResult;
    } catch (e) {
      return e;
    }
  }

  Future resendOTP({@required String email, @required String type}) async {
    try {
      var authResult = await _networkService.put(
        "$API_BASE_URL/$type",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {"email": email},
        encodeBody: false,
      );
      return authResult;
    } catch (e) {
      return e;
    }
  }

  Future forgotPassword({@required Map body, @required String type}) async {
    try {
      var authResult = await _networkService.post(
        "$API_BASE_URL/$type",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          'type': 'mobile',
        },
        body: body,
        encodeBody: false,
      );
      return authResult;
    } catch (e) {
      return e;
    }
  }
  Future resendOTP2({@required String email, @required String type}) async {
    try {
      var authResult = await _networkService.put(
        "$API_BASE_URL/$type",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {"email": email},
        encodeBody: false,
      );
      return authResult;
    } catch (e) {
      return e;
    }
  }


  Future<bool> isUserLoggedIn() async {
    var token = _tokenService.userToken;
    return token.accessToken != null ? true : false;
  }

  Future loadUser(var user) async {
    if (user != null) {
      User us = User.fromJson(user);
      _storageService.saveToDisk("user", json.encode(us.toJson()));
    }
    return true;
  }

  Future loadToken(var token) async {
    if (token != null) {
      _tokenService.token = token;
    }
    return true;
  }
}
