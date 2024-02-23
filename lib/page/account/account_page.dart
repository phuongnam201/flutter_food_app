import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/account_widget.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (!userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        //icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: 75,
                          size: Dimensions.height20 * 7.5,
                        ),
                        SizedBox(
                          height: Dimensions.height10 * 2,
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //name
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel?.name ??
                                            "Null".toString())),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                //phone
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel?.phone ??
                                            "Null")),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                //mail
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.mail,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel?.email ??
                                            "Null")),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                //address
                                GetBuilder<LocationController>(
                                    builder: (locationController) {
                                  if (_userLoggedIn &&
                                      locationController.addressList.isEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.addAddress);
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.mainColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                              text: "fill your address")),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.addAddress);
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor:
                                                AppColors.mainColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText:
                                              BigText(text: "Your address")),
                                    );
                                  }
                                }),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                //message
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Message")),
                                SizedBox(
                                  width: Dimensions.height10,
                                ),
                                //logout
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearShareData();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.find<CartController>().clear();
                                      Get.offNamed(RouteHelper.getSignIn());
                                    } else {}
                                  },
                                  child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Logout")),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : CustomLoader())
            : Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 7,
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/image/signintocontinue.png"),
                          ),
                        ),
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
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15)),
                          child: Center(
                            child: BigText(
                              text: "Sign in",
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
      }),
    );
  }
}
