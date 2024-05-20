import 'package:flutter/material.dart';
import 'package:food_app/controller/food_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/icon_and_text_widget.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final FoodController foodController = Get.find<FoodController>();
  var queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm món ăn"),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          AppTextField(
            textController: queryController,
            labelText: "Tìm kiếm",
            icon: Icons.search,
            onChanged: (value) async {
              await foodController.searchProduct(value);
              print("check search food: " +
                  foodController.foodListSearch.length!.toString());
              setState(() {});
            },
          ),
          SizedBox(height: Dimensions.height10),
          Expanded(
            child: !foodController.isLoaded
                ? Center(child: CircularProgressIndicator())
                : (foodController.foodListSearch.isEmpty
                    ? Center(child: Text("Không tìm thấy món ăn nào"))
                    : ListView.builder(
                        itemCount: foodController.foodListSearch.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //print(foodController.foodListSearch[index].name);
                              Get.toNamed(RouteHelper.getFoodDetail(
                                  foodController.foodListSearch[index].id!,
                                  "searchPage"));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                bottom: Dimensions.height10,
                              ),
                              child: Row(
                                children: [
                                  // Image section
                                  Container(
                                    width: Dimensions.listViewImgSize,
                                    height: Dimensions.listViewImgSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white38,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                AppConstants.UPLOADS +
                                                foodController
                                                    .foodListSearch[index]
                                                    .img!),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.listViewTextContSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimensions.radius20),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFe8e8e8),
                                            offset: const Offset(0, 5.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 2.0,
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(5, 0),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: Dimensions.width10,
                                          right: Dimensions.width10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BigText(
                                                text: foodController
                                                    .foodListSearch[index]
                                                    .name!),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                RatingStars(
                                                  rating: double.parse(
                                                      foodController
                                                          .foodListSearch[index]
                                                          .stars
                                                          .toString()),
                                                  editable: false,
                                                  iconSize:
                                                      Dimensions.iconSize16,
                                                  color: AppColors.mainColor,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SmallText(
                                                  text: "₫ " +
                                                      foodController
                                                          .foodListSearch[index]
                                                          .price!
                                                          .toString(),
                                                  color: Colors.deepOrange,
                                                  size: Dimensions.font16 - 2,
                                                ),
                                                IconAndTextWidget(
                                                  icon: Icons.location_on,
                                                  text: "1.8km",
                                                  iconColor:
                                                      AppColors.mainColor,
                                                ),
                                                IconAndTextWidget(
                                                  icon:
                                                      Icons.access_time_rounded,
                                                  text: "35mins",
                                                  iconColor:
                                                      AppColors.iconColor2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
          ),
        ],
      ),
    );
  }
}
