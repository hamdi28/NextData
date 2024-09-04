import 'package:flutter/material.dart';
import 'package:next_data/pages/home_screen/home_screen_view.dart';
import 'package:next_data/pages/login_screen/login_screen_view.dart';
import 'package:next_data/pages/posts_screen/single_post_screen/single_post_screen_view.dart';
import 'package:next_data/pages/signup_screen/signup_screen_view.dart';
import 'package:next_data/pages/splash_screen/splash_screen_view.dart';
import 'package:page_transition/page_transition.dart';

import 'core/config/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRouteName:
      return getPageRoute(SplashScreen());
    case loginScreenRouteName:
      return getPageRoute(LoginScreen());
    case signUpScreenRouteName:
      return getPageRoute(const SignUpScreen());
    case homeScreenRouteName:
      return getPageRoute(const HomeScreen());
    case singlePostScreenRouteName:
      return getPageRoute(SinglePostView(
          post: Map.from(settings.arguments as Map<dynamic, dynamic>)['post'],
          user: Map.from(settings.arguments as Map<dynamic, dynamic>)['user']));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              ));
  }
}

getPageRoute(Widget viewToShow,
    {PageTransitionType transitionAnimation = PageTransitionType.rightToLeft,
    dynamic args}) {
  return MaterialPageRoute(builder: (context) {
    return viewToShow;
  });
}
