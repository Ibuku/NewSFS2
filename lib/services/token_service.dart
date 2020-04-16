import 'dart:convert';
import '../locator.dart';
import '../models/token.dart';
import '../services/local_storage_service.dart';

class TokenService {
  final LocalStorageService _storageService = locator<LocalStorageService>();

  String getToken() {
    var userJson = userToken;

    if (userJson == null) {
      return null;
    }

    return userJson.accessToken;
  }

  Token get userToken {
    var userJson = _storageService.getFromDisk("token");

    if (userJson == null) {
      return null;
    }

    return Token.fromJson(json.decode(userJson));
  }

  set token(Map tokenData) {
    Token tk = Token.fromJson(tokenData);
    _storageService.saveToDisk("token", json.encode(tk.toJson()));
  }
}