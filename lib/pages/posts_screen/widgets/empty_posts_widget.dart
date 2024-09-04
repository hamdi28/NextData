import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';

class EmptyPostsWidget extends StatelessWidget {
  const EmptyPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(errorIcon),
          SizedBox(height: 44.0,),
          const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text("Server Error Codes 5XX" , style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500,color: errorTextColor),),
          )
        ],
      ),
    );
  }
}
