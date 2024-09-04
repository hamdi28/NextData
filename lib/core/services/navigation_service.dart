import 'package:flutter/material.dart';

/// A service that manages navigation within the app, including tracking route names
/// and providing methods for navigation actions such as navigating to a route
/// and popping routes.
class NavigationService {
  /// List of route names to keep track of the navigation history.
  List<String> _routeNames = List<String>.empty(growable: true);

  /// Getter for the list of route names.
  List<String> get routeNames => _routeNames;

  /// Global key for accessing the navigator state.
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  /// Getter for the navigation key.
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  /// Returns the name of the current route (i.e., the last route in the list).
  String getCurrentRouteName() {
    return _routeNames.last;
  }

  /// Adds a route name to the list of route names.
  void addRouteName(String route) {
    _routeNames.add(route);
  }

  /// Navigates to the specified [routeName] and adds the route to the list of route names.
  ///
  /// Optionally takes [arguments] to pass to the new route.
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    addRouteName(routeName);
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  /// Clears all routes and navigates to the specified [routeName].
  ///
  /// This method also clears the list of route names and adds the new route.
  /// Optionally takes [arguments] to pass to the new route.
  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    _routeNames.clear();
    addRouteName(routeName);
    return _navigationKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
