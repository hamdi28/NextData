import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_data/core/config/app_theme.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController searchController ;
  Function(String) onValueChanges;
   SearchContainer({required this.searchController, required this.onValueChanges,super.key});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Adjusts internal padding
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteGreyColor),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteGreyColor),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        labelText: "search",
        filled: true,
        prefixIcon: Icon(Icons.search,color: searchLabelTextColor),
        labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: searchLabelTextColor),
        fillColor: whiteGreyColor,
      ),
      controller: searchController,
      onChanged: onValueChanges,
    );
  }
}
