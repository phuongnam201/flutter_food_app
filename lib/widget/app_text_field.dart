import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  //final String hinText;
  final String labelText;
  final IconData icon;
  final bool? obscureText;

  const AppTextField({
    super.key,
    required this.textController,
    required this.labelText,
    required this.icon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight / 14,
      margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
        top: Dimensions.height20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: TextField(
        obscureText: obscureText ?? false,
        controller: textController,
        decoration: InputDecoration(
          labelText: labelText,
          //prefix

          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
            size: Dimensions.iconSize16,
          ),

          //enable border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),

          //focus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.mainColor,
            ),
          ),

          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),

          //label style
        ),
      ),
    );
  }
}
