import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/pages/login_screen/widgets/large_button_widget.dart';
import 'package:next_data/pages/login_screen/widgets/text_form_field_widget.dart';
import 'package:next_data/pages/signup_screen/signup_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpScreen extends StackedView<SignUpViewModel> {
  const SignUpScreen({super.key});

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();


  @override
  Widget builder(
      BuildContext context, SignUpViewModel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90.0),
                  child: SvgPicture.asset(
                    appIconDark,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 44.0, bottom: 5.0),
                    child: Center(
                        child: Text(
                      "Welcome to NextData",
                      style: TextStyle(
                          fontSize: 20,
                          color: darkBlueColor,
                          fontWeight: FontWeight.w600),
                    ))),
                const Center(
                    child: Text(
                  "Create an account to get started",
                  style: TextStyle(
                      fontSize: 12,
                      color: greyColor,
                      fontWeight: FontWeight.w400),
                )),
                const SizedBox(
                  height: 24.0,
                ),
                Form(key: viewModel.formKey, child: const TextFieldWidget()),
                const SizedBox(height: 44.0),
                LargeButton(
                    labelButton: "Sign Up",
                    onPressed: viewModel.signUpWithEmailAndPassword,
                    isButtonFilled: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends ViewModelWidget<SignUpViewModel> {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Name",
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8.0,
        ),
        LoginTextFromField(
          fieldLabel: "Name",
          controller: viewModel.nameFieldController,
          formFieldValidator:(value) {
            if(value == null || value.isEmpty) {
              return viewModel.nameValidation(value);
            }else{
              return null;
            }
          },

        ),
        const SizedBox(height: 18.0),
        const Text(
          "Email",
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8.0,
        ),
        LoginTextFromField(
          fieldLabel: "Email",
          controller: viewModel.emailFieldController,
          formFieldValidator:(value) {
              return viewModel.emailValidation(value);
          },
        ),
        const SizedBox(height: 18.0),
        const Text(
          "Password",
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8.0,
        ),
        LoginTextFromField(
          fieldLabel: "Create a passaword",
          controller: viewModel.passwordFieldController,
          showSuffix: true,
          formFieldValidator:(value) {
              return viewModel.passwordValidation(value);
          },
        ),
        const SizedBox(height: 16.0),
        LoginTextFromField(
          fieldLabel: "Confirm password",
          controller: viewModel.confirmPasswordFieldController,
          showSuffix: true,
          formFieldValidator:(value) {
            if(value == null || value.isEmpty) {
              return viewModel.passwordConfirmation(value);
            }else{
              return null;
            }
          },
        ),
      ],
    );
  }
}
