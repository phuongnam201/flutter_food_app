import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height20 * 4,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(
                top: Dimensions.height10, bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                height: 400,
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: ListView(
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      //for (int i = itemsPerOrder.length - 1; i >= 0; i--)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(238, 238, 238, 1))),
                        height: Dimensions.height20 * 6,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //BigText(text: getCartHistoryList[i].time!),
                              (() {
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(
                                        getCartHistoryList[listCounter].time!);
                                var inputDate =
                                    DateTime.parse(parseDate.toString());
                                var outputFormat =
                                    DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outputFormat.format(inputDate);

                                return SmallText(
                                  text: outputDate,
                                  size: Dimensions.font16,
                                  color: AppColors.titleColor,
                                );
                              }()),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i],
                                        (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return index <= 2
                                          ? Container(
                                              height: Dimensions.height10 * 6.5,
                                              width: Dimensions.width10 * 6.5,
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants.UPLOADS +
                                                          getCartHistoryList[
                                                                  listCounter -
                                                                      1]
                                                              .img!),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimensions.height15 * 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: Colors.amber,
                                        ),
                                        SmallText(
                                          text: itemsPerOrder[i].toString() +
                                              " items",
                                          color: AppColors.titleColor,
                                          size: Dimensions.font16,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 10,
                                              right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor),
                                          ),
                                          child: SmallText(
                                            text: "detail",
                                            color: AppColors.mainColor,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
