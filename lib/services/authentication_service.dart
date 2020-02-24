import 'package:flutter/foundation.dart';

import '../const.dart';
import '../locator.dart';

import 'base_service.dart';

class AuthenticationService {
  final BaseService _networkService = locator<BaseService>();
  final String baseURL = API_BASE_URL;
  
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

  // User _currentUser;
  // User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    // try {
    //   var authResult = await _firebaseAuth.signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   await _populateCurrentUser(authResult.user);
    //   return authResult.user != null;
    // } catch (e) {
    //   return e.message;
    // }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
  }) async {
    try {
      // var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      // create a new user profile on firestore
      // _currentUser = User(
      //   id: authResult.user.uid,
      //   email: email,
      //   fullName: fullName,
      //   userRole: role,
      // );

      // await _firestoreService.createUser(_currentUser);

      // return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    // var user = await _firebaseAuth.currentUser();
    // await _populateCurrentUser(user);
    // return user != null;
  }

  Future _populateCurrentUser(var user) async {
    // if (user != null) {
    //   _currentUser = await _firestoreService.getUser(user.uid);
    // }
  }
}
