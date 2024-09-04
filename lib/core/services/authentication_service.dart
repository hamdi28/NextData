import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:next_data/core/config/app_config.dart';
import 'package:next_data/core/services/platform_channels_service.dart';
import 'package:next_data/locator.dart';

/// A service that handles user authentication, including sign-in and sign-up,
/// using platform channels for communication with native code.
class AuthService {
  /// Instance of [PlatformChannelsService] used to invoke platform-specific methods.
  final PlatformChannelsService _platformChannelService =
  locator<PlatformChannelsService>();

  /// Instance of [FirebaseAuth] used to handle Firebase authentication operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Signs in a user with the provided [email] and [password].
  ///
  /// Returns a [String] representing the user ID if the sign-in is successful,
  /// or `null` if it fails. Throws a [FirebaseAuthException] if there is an
  /// error during the sign-in process.
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      // Arguments to be passed to the platform channel method.
      Map<String, dynamic> arguments = {
        AuthPropertiesKeys.email: email,
        AuthPropertiesKeys.password: password,
      };

      // Invokes the platform-specific method for signing in with email and password.
      final result = await _platformChannelService.invokeMethod(
          authChannelName, signInWithEmailAndPassword,
          arguments: arguments);

      // Returns the result if available, otherwise returns null.
      if (result != null) {
        return result.toString();
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      // Throws a FirebaseAuthException if a platform exception occurs.
      throw FirebaseAuthException(code: e.code);
    }
  }

  /// Signs up a user with the provided [email] and [password].
  ///
  /// Returns a [String] representing the user ID if the sign-up is successful,
  /// or `null` if it fails.
  Future<String?> signUpWithEmail(String email, String password) async {
    // Arguments to be passed to the platform channel method.
    Map<String, dynamic> arguments = {
      AuthPropertiesKeys.email: email,
      AuthPropertiesKeys.password: password,
    };

    // Invokes the platform-specific method for signing up with email and password.
    final result = await _platformChannelService.invokeMethod(
        authChannelName, signUPWithEmailAndPassword,
        arguments: arguments);

    // Returns the result if available, otherwise returns null.
    if (result != null) {
      return result.toString();
    } else {
      return null;
    }
  }

  /// Checks if a user is currently signed in.
  ///
  /// Returns `true` if a user is signed in, otherwise returns `false`.
  Future<bool> isUserSignedIn() async {
    // Checks for changes in the user's authentication state.
    var user = await _auth.authStateChanges().first;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
