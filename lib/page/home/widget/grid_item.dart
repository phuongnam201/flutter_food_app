import 'package:flutter/material.dart';
import 'package:food_app/controller/food_controller.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_and_text_widget.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class GridItem extends StatelessWidget {
  GridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodController>(builder: (controller) {
      return Container(
        // height: Dimensions.screenHeight,
        margin: EdgeInsets.only(
            left: Dimensions.width20, right: Dimensions.width20),
        width: Dimensions.screenWidth,
        child: GridView.builder(
          padding: EdgeInsets.only(top: Dimensions.height10),
          physics:
              NeverScrollableScrollPhysics(), // Disable GridView's scrolling
          shrinkWrap: true, // Wrap the GridView inside SingleChildScrollView
          itemCount: controller.foodList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: Dimensions.height10 * 25,
            mainAxisSpacing: Dimensions.height10 * 1.5,
            crossAxisSpacing: Dimensions.width10 * 1.5,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getFoodDetail(index, "homePage"));
              },
              child: Container(
                //height: 200, // Độ cao của container
                //width: double.infinity, // Chiều rộng mở rộng toàn bộ
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 211, 201, 201),
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        //color: Colors.blue,
                        image: DecorationImage(
                          image: NetworkImage(
                            AppConstants.BASE_URL +
                                "/storage/" +
                                controller.foodList[index].img!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      width: Dimensions.screenWidth * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: controller.foodList[index].name!,
                            //color: Colors.blue[800],
                            size: Dimensions.font20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingStars(
                                rating: double.parse(controller
                                    .foodList[index].stars
                                    .toString()),
                                editable: false,
                                iconSize: Dimensions.iconSize16,
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height10 / 2,
                          ),
                          Container(
                              width: Dimensions.screenWidth * 0.4,
                              child: IconAndTextWidget(
                                icon: Icons.access_time_rounded,
                                text: "35 phút",
                                iconColor: AppColors.iconColor2,
                              )),
                          SizedBox(
                            height: Dimensions.height10 / 2,
                          ),
                          SmallText(
                            text: "Giá: ₫ " +
                                controller.foodList[index].price!.toString(),
                            color: Colors.deepOrange,
                            size: Dimensions.font16 - 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
