import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:next_data/core/config/routing_constants.dart';
import 'package:next_data/core/config/utils.dart';
import 'package:next_data/core/services/authentication_service.dart';
import 'package:next_data/core/services/navigation_service.dart';
import 'package:next_data/locator.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>(); // Service for authentication
  final NavigationService _navigationService = locator<NavigationService>(); // Service for navigation

  // Controllers for form fields
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  TextEditingController _confirmPasswordFieldController = TextEditingController();

  // Getters for form field controllers
  TextEditingController get emailFieldController => _emailFieldController;
  TextEditingController get nameFieldController => _nameFieldController;
  TextEditingController get passwordFieldController => _passwordFieldController;
  TextEditingController get confirmPasswordFieldController => _confirmPasswordFieldController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the form

  GlobalKey<FormState> get formKey => _formKey;

  /// Signs up the user with email and password.
  /// Validates the form and performs the sign-up operation.
  void signUpWithEmailAndPassword() {
    if (_formKey.currentState!.validate()) {
      Task(() => _authService.signUpWithEmail(
          _emailFieldController.text, passwordFieldController.text))
          .attempt()
          .mapLeftToFailure()
          .run()
          .then((eitherResult) => eitherResult.fold(
            (_) => {
          // TODO: handle failure
        },
            (token) => {
          if (token != null) {
            _navigationService.popAllAndNavigateTo(homeScreenRouteName)
          }
        },
      ));
    }
  }

  /// Validates the name field.
  /// Returns a validation message if the field is empty.
  String nameValidation(String? tappedText) {
    String msgFormValidator = "";

    if (tappedText != null && tappedText.isEmpty) {
      msgFormValidator = "Champ Obligatoire"; // Field is required
    }
    notifyListeners();
    return msgFormValidator;
  }

  /// Validates the email field.
  /// Checks if the email is empty or in an invalid format.
  String? emailValidation(String? tappedText) {
    if (tappedText == null || tappedText.isEmpty) {
      return "Champ Obligatoire"; // Field is required
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(tappedText)) {
      return "Email invalide"; // Invalid email format
    }

    return null;
  }

  /// Validates the password field.
  /// Checks if the password is empty or less than 7 characters.
  String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Champ Obligatoire"; // Field is required
    }
    if (password.length < 7) {
      return "Le mot de passe doit comporter plus de 6 caractères"; // Password too short
    }

    return null;
  }

  /// Validates the password confirmation field.
  /// Checks if the confirmation password matches the original password.
  String? passwordConfirmation(String? password) {
    if (password == null || password.isEmpty) {
      return "Champ Obligatoire"; // Field is required
    }
    if (password != _passwordFieldController.text) {
      return "Les mots de passe ne correspondent pas"; // Passwords do not match
    }

    return null;
  }
}
