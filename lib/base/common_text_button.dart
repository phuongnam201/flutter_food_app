import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.height15,
        bottom: Dimensions.height15,
        left: Dimensions.width20,
        right: Dimensions.width20,
      ),
      child: Center(
        child: BigText(
          text: text,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: AppColors.mainColor,
      ),
    );
  }
}
