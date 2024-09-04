import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_data/core/config/routing_constants.dart';
import 'package:next_data/core/config/utils.dart';
import 'package:next_data/core/services/authentication_service.dart';
import 'package:next_data/core/services/local_database_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/locator.dart';
import 'package:stacked/stacked.dart';

/// ViewModel for managing the state of the Login screen.
///
/// This class extends [BaseViewModel] and provides functionality
/// for handling user authentication, form validation, and navigation.
class LoginScreenViewModel extends BaseViewModel {
  /// Instance of [NavigationService] used for navigating between screens.
  final NavigationService _navigationService = locator<NavigationService>();

  /// Instance of [AuthService] used for handling authentication.
  final AuthService _authService = locator<AuthService>();

  /// Controller for the email text field.
  final TextEditingController _emailFieldController = TextEditingController();

  /// Getter for the email field controller.
  TextEditingController get emailFieldController => _emailFieldController;

  /// Controller for the password text field.
  final TextEditingController _passwordFieldController = TextEditingController();

  /// Getter for the password field controller.
  TextEditingController get passwordFieldController => _passwordFieldController;

  /// Key for the form widget, used for validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Getter for the form key.
  GlobalKey<FormState> get formKey => _formKey;

  /// Initializes the ViewModel.
  ///
  /// This method can be used to perform any necessary setup or initial actions.
  void init() async {}

  /// Signs in the user with the provided email and password.
  ///
  /// This method validates the form, attempts to sign in using the [AuthService],
  /// and navigates to the home screen if successful.
  void signUpWithEmailAndPassword() {
    if (_formKey.currentState!.validate()) {
      Task(() => _authService.signInWithEmail(
          _emailFieldController.text, passwordFieldController.text))
          .attempt()
          .mapLeftToFailure()
          .run()
          .then((eitherResult) => eitherResult.fold(
              (failure) => {}, // Handle failure (currently empty).
              (token) => {
            _navigationService.popAllAndNavigateTo(homeScreenRouteName)
          }));
    }
  }

  /// Navigates to the sign-up screen.
  void navigateTOSignUP() {
    _navigationService.navigateTo(signUpScreenRouteName);
  }

  /// Validates the email input.
  ///
  /// [tappedText] is the text input from the email field.
  /// Returns an error message if the email is invalid, otherwise returns `null`.
  String? emailValidation(String? tappedText) {
    if (tappedText == null || tappedText.isEmpty) {
      return "Champ Obligatoire";
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(tappedText)) {
      return "Email invalide";
    }

    return null;
  }

  /// Validates the password input.
  ///
  /// [password] is the text input from the password field.
  /// Returns an error message if the password is too short or empty,
  /// otherwise returns `null`.
  String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Champ Obligatoire";
    }
    if (password.length < 7) {
      return "Le mot de passe doit comporter plus de 6 caractères";
    }

    return null;
  }
}
