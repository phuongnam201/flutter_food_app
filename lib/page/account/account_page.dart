import 'package:flutter/material.dart';
import 'package:food_app/base/common_require_login.dart';
import 'package:food_app/base/custom_appbar.dart';
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
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thông tin cá nhân",
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Get.toNamed(RouteHelper.getEditProfile());
            },
            color: Colors.white,
          ),
        ],
      ),
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
                                            "loading".toString())),
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
                                            "loading")),
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
                                            "loading")),
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
                                          bigText:
                                              BigText(text: "Thêm địa chỉ")),
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
                                              BigText(text: "Địa chỉ của bạn")),
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
                                    bigText: BigText(text: "Liên hệ")),
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
                                      bigText: BigText(text: "Đăng xuất")),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : CustomLoader())
            : RequireLogin();
      }),
    );
  }
}
