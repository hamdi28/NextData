import 'package:flutter/material.dart';
import 'package:next_data/core/config/app_theme.dart';

class LargeButton extends StatelessWidget {
  final String labelButton;
  final Function() onPressed;
  final bool isButtonFilled;

  LargeButton(
      {required this.labelButton,
        required this.onPressed,
        required this.isButtonFilled});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isButtonFilled ? lightBlueColor : whiteColor,
              border: Border.all(color: lightBlueColor ),
            borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
      child: Center(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(labelButton,style: TextStyle(color: isButtonFilled ? whiteColor : lightBlueColor ,fontSize: 14,fontWeight: FontWeight.w500)  ,),
      )),
      ),
    );
  }
}