import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/page/home/main_food_page.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.height20,
            top: Dimensions.height45,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MainFoodPage());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5.5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height10),
              //color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index) {
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin:
                                EdgeInsets.only(bottom: Dimensions.height10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.mainColor),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                "/uploads/" +
                                                cartController
                                                    .getItems[index].img!),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        BigText(
                                          text:
                                              "\$ ${cartController.getItems[index].price!.toString()}",
                                          color: Colors.black54,
                                        ),
                                        //SmallText(text: "spicy"),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Icons.remove,
                                                      size:
                                                          Dimensions.iconSize24,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  BigText(text: "0"),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Icons.add,
                                                      size:
                                                          Dimensions.iconSize24,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
