import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';
import 'package:next_data/pages/login_screen/login_screen_view_model.dart';
import 'package:next_data/pages/login_screen/widgets/large_button_widget.dart';
import 'package:next_data/pages/login_screen/widgets/text_form_field_widget.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StackedView<LoginScreenViewModel> {
  @override
  LoginScreenViewModel viewModelBuilder(BuildContext context) =>
      LoginScreenViewModel();

  @override
  void onViewModelReady(LoginScreenViewModel viewModel) => viewModel.init();

  @override
  Widget builder(
      BuildContext context, LoginScreenViewModel viewModel, Widget? child) {
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
                  "Login with Email",
                  style: TextStyle(
                      fontSize: 12,
                      color: greyColor,
                      fontWeight: FontWeight.w400),
                )),
                const SizedBox(
                  height: 24.0,
                ),
                Form(key: viewModel.formKey, child: const TextFieldWidget()),
                const SizedBox(height: 24.0),
                LargeButton(
                    labelButton: "Login", onPressed: viewModel.signUpWithEmailAndPassword, isButtonFilled: true),
                const SizedBox(
                  height: 12.0,
                ),
                LargeButton(
                    labelButton: "Sign Up",
                    onPressed: viewModel.navigateTOSignUP,
                    isButtonFilled: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends ViewModelWidget<LoginScreenViewModel> {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, LoginScreenViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          formFieldValidator: (value) {
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
          fieldLabel: "Password",
          controller: viewModel.passwordFieldController,
          showSuffix: true,
          formFieldValidator: (value) {
            return viewModel.passwordValidation(value);
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                color: lightBlueColor,
                fontSize: 10.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
