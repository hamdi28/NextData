import 'package:flutter/material.dart';
import 'package:next_data/core/config/app_theme.dart';

class HorizentaleDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,

      margin: EdgeInsets.only(
        left: 0.5,
        right: 0.5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: dividerColor,
          width: 0.5,
        ),
      ),
    );
  }
}