import 'package:flutter/material.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class RequireLogin extends StatelessWidget {
  const RequireLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: double.maxFinite,
              height: Dimensions.screenHeight * .3,
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Column(children: [
                Center(
                  child: Image.asset(
                    "assets/image/logo part 1.png",
                    width: Dimensions.splashImg,
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/image/logo part 2.png",
                    width: Dimensions.splashImg,
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSignIn());
            },
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20 * 3,
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius15)),
                child: Center(
                  child: BigText(
                    text: "Vui lòng đăng nhập",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
