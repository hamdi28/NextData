import 'package:next_data/core/config/routing_constants.dart';
import 'package:next_data/core/services/authentication_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/locator.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  /// Flag to control the start of animation
  bool _startAnimation = false;

  /// Getter for the animation flag
  bool get startAnimation => _startAnimation;

  /// Initialize the view model by starting animation and then loading data
  void init() {
    _triggerAnimation().then((_) => getData());
  }

  /// Delays for 5 seconds before handling navigation
  void getData() {
    Future.delayed(Duration(seconds: 5)).then((_) => handleNavigation());
  }

  /// Triggers the animation by delaying for 1 second and then updating the animation flag
  Future<void> _triggerAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    _startAnimation = true;
    notifyListeners(); // Notify listeners to update UI
  }

  /// Handles navigation based on the user's sign-in status
  void handleNavigation() async {
    bool isUserSignedIn = await _authService.isUserSignedIn();
    if (isUserSignedIn) {
      _navigationService.navigateTo(homeScreenRouteName); // Navigate to home screen if signed in
    } else {
      _navigationService.navigateTo(loginScreenRouteName); // Navigate to login screen if not signed in
    }
  }
}
