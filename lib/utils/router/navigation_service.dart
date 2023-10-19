import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey_ = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => navigationKey_;

  pop() {
    return navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateReplacementTo(String routeName, {dynamic arguments}) {
    return navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
  Future<dynamic> pushAndRemoveUntil<T extends dynamic>(String newRoute) {
   return   navigationKey.currentState!.pushNamedAndRemoveUntil(newRoute,  (Route<dynamic> route) => false);

  }

}
