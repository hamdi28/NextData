import 'package:flutter/material.dart';
import 'package:next_data/core/config/app_theme.dart';

class LoginTextFromField extends StatefulWidget {
  String fieldLabel;
  bool showSuffix;
  bool enabeled;
  TextEditingController controller;

  final FormFieldValidator<String>? formFieldValidator;

  LoginTextFromField(
      {required this.fieldLabel,
      required this.controller,
      this.enabeled = true,
      required this.formFieldValidator,
      this.showSuffix = false,
      super.key});

  @override
  State<LoginTextFromField> createState() => _LoginTextFromFieldState();
}

class _LoginTextFromFieldState extends State<LoginTextFromField> {
  bool _showUserInput = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        enabled: widget.enabeled,
        validator: widget.formFieldValidator,
        controller: widget.controller,
        obscureText: widget.showSuffix ? _showUserInput : false,
        decoration: InputDecoration(
          // hintText: widget.fieldLabel,
          labelStyle: const TextStyle(
              color: greyColor, fontSize: 12.0, fontWeight: FontWeight.w400),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 0.0),
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor,width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: redColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4.0),
              bottomRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          suffixIcon: widget.showSuffix
              ? IconButton(
                  icon: Icon(
                    !_showUserInput ? Icons.visibility_off : Icons.visibility,
                    color: blackColor,
                    size: 19.0,
                  ),
                  onPressed: () {
                    setState(() {
                      _showUserInput = !_showUserInput;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
