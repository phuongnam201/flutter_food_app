import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_and_text_widget.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final String price;
  double rate;

  AppColumn(
      {super.key, required this.text, required this.price, required this.rate});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    // RatingBar.builder(
                    //   initialRating: rate,
                    //   minRating: 1,
                    //   direction: Axis.horizontal,
                    //   allowHalfRating: false,
                    //   itemCount: 5,
                    //   itemSize: Dimensions.iconSize16,
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    //   itemBuilder: (context, _) => Icon(
                    //     Icons.star,
                    //     color: AppColors.mainColor,
                    //   ),
                    //   onRatingUpdate: (rating) {
                    //     print(rating);
                    //   },
                    // ),
                    RatingStars(
                      rating: rate,
                      editable: false,
                      iconSize: Dimensions.iconSize16,
                      color: AppColors.mainColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SmallText(text: '100'),
                    SizedBox(
                      width: 5,
                    ),
                    SmallText(text: 'Comments'),
                  ],
                )
              ],
            )
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
