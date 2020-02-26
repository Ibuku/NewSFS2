import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class Application {
  static StreamController _user$;

  static User user = User(); // store the current authenticated user

  static Future<void> initialize() async {
    _user$ = StreamController<String>.broadcast();
  }

  static void logout() {
    SharedPreferences.getInstance().then((s) {
      s.setString('userData', null);
      Application.user = User();
      // Application.user.load(s);
    });
  }

  static void dispose() {
    _user$.close();
  }
}
