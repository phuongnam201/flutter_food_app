import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_and_text_widget.dart';
import 'package:food_app/widget/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String price;

  const AppColumn({super.key, required this.text, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.iconSize16,
                );
              }),
            ),
            SizedBox(
              width: 5,
            ),
            SmallText(text: '5'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: '100'),
            SizedBox(
              width: 5,
            ),
            SmallText(text: 'Comments'),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconAndTextWidget(
              icon: Icons.attach_money_rounded,
              text: price.toString(),
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "35mins",
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
