import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(
      String routeName, {
        dynamic arguments,
        bool replace = false,
      }) {
    if (replace) {
      return _navigationKey.currentState.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    }
    return _navigationKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateAndClearRoute(
      String routeName, {
        dynamic arguments,
        String baseRouteName,
      }) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      baseRouteName == null
          ? (Route<dynamic> route) => false
          : ModalRoute.withName(baseRouteName),
      arguments: arguments,
    );
  }
}