import 'package:flutter/material.dart';
import 'package:food_app/base/common_text_button.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/food_controller.dart';
import 'package:food_app/controller/location_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/page/order/delivery_option.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/utils/style.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:food_app/page/order/payment_option.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = new TextEditingController();
    //Get.find<LocationController>().getUserAddress();
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
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
                      var _cartList = cartController.getItems;
                      return _cartList.length > 0
                          ? ListView.builder(
                              itemCount: cartController.getItems.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // var popularIndex =
                                    //     Get.find<PopularProductController>()
                                    //         .popularProductList
                                    //         .indexOf(_cartList[index].product!);
                                    // if (popularIndex >= 0) {
                                    //   Get.toNamed(RouteHelper.getPopularFood(
                                    //       popularIndex, "cartPage"));
                                    // } else {
                                    //   var recommendedIndex =
                                    //       Get.find<RecommendedProductController>()
                                    //           .recommendedProductList
                                    //           .indexOf(_cartList[index].product!);

                                    //   Get.toNamed(RouteHelper.getRecommendedFood(
                                    //       recommendedIndex, "cartPage"));
                                    // }
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: Dimensions.height20 * 5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
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
                                                        AppConstants.UPLOADS +
                                                        cartController
                                                            .getItems[index]
                                                            .img!),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                  color: Colors.black87,
                                                ),
                                                BigText(
                                                  text:
                                                      "₫ ${cartController.getItems[index].price!.toString()}",
                                                  color: Colors.deepOrange,
                                                ),
                                                //SmallText(text: "spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.only(),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              size: Dimensions
                                                                  .iconSize24,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          BigText(
                                                              text: _cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 /
                                                                2,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              size: Dimensions
                                                                  .iconSize24,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController
                                                            .deleteItem(
                                                                _cartList[index]
                                                                    .product!);
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        child: AppIcon(
                                                          icon: Icons
                                                              .delete_outlined,
                                                          size: Dimensions
                                                              .iconSize24,
                                                          iconColor: Colors.red,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: "Giỏ hàng trống",
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<OrderController>(builder: (orderController) {
          noteController.text = orderController.foodNote;
          return GetBuilder<CartController>(builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                ),
                Container(
                  height: Dimensions.bottomHeightBar * 1.5,
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    ),
                  ),
                  child: controller.getItems.length > 0
                      ? Column(children: [
                          InkWell(
                            onTap: () => showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (_) {
                                      return Column(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Container(
                                                height:
                                                    Dimensions.screenHeight *
                                                        0.6,
                                                width: Dimensions.screenWidth,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Dimensions.radius20 /
                                                              2),
                                                      topRight: Radius.circular(
                                                          Dimensions.radius20 /
                                                              2)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        //color: Colors.red,
                                                        borderRadius: BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    Dimensions
                                                                            .radius20 /
                                                                        2),
                                                            topRight:
                                                                Radius.circular(
                                                                    Dimensions
                                                                            .radius20 /
                                                                        2)),
                                                      ),
                                                      //color: Colors.red,
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .width20,
                                                          left: Dimensions
                                                              .width20,
                                                          right: Dimensions
                                                              .width20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          PaymentOptionButton(
                                                            icon: Icons.money,
                                                            title: 'Ship COD',
                                                            subTitle:
                                                                "Bạn sẽ thanh toán sau khi nhận hàng",
                                                            index: 0,
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          PaymentOptionButton(
                                                            icon: Icons
                                                                .payment_outlined,
                                                            title:
                                                                'Thanh toán online',
                                                            subTitle:
                                                                "Nhanh chóng và an toàn",
                                                            index: 1,
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height20,
                                                          ),
                                                          Text(
                                                            "Hình thức nhận hàng",
                                                            style: robotoMedium,
                                                          ),
                                                          DeliveryOption(
                                                              value: "delivery",
                                                              title:
                                                                  "Giao hàng tại nhà",
                                                              amount: double.parse(Get
                                                                          .find<
                                                                              CartController>()
                                                                      .totalAmount
                                                                      .toString()) *
                                                                  0.15,
                                                              isFree: false),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height10,
                                                          ),
                                                          DeliveryOption(
                                                              value: "takeaway",
                                                              title:
                                                                  "Tôi sẽ đến lấy",
                                                              amount: 10,
                                                              isFree: true),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .height20,
                                                          ),
                                                          Text(
                                                            "Ghi chú",
                                                            style: robotoMedium,
                                                          ),
                                                          AppTextField(
                                                              textController:
                                                                  noteController,
                                                              labelText:
                                                                  'Điền ghi chú của bạn',
                                                              icon: Icons.note)
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                .whenComplete(() => orderController
                                    .setFoodNote(noteController.text.trim())),
                            child: Container(
                              width: double.maxFinite,
                              child: CommonTextButton(
                                  text: "Lựa chọn hình thức thanh toán"),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height15,
                                    bottom: Dimensions.width15,
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(text: "Tổng: "),
                                      BigText(
                                        text: "₫ " +
                                            controller.totalAmount.toString(),
                                        color: Colors.deepOrange,
                                      ),
                                    ]),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    //controller.addItem(product);
                                    //controller.addToHistory();
                                    //Get.find<LocationController>().getUserAddress();
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      if (controller.totalItems > 0) {
                                        if (Get.find<LocationController>()
                                            .addressList
                                            .isEmpty) {
                                          Get.toNamed(
                                              RouteHelper.getAddressPage());
                                        } else {
                                          //Get.offNamed(RouteHelper.getPaymentPage("100003",
                                          //Get.find<UserController>().userModel!.id!));
                                          var location =
                                              Get.find<LocationController>()
                                                  .getUserAddress();
                                          var cart = Get.find<CartController>()
                                              .getItems;
                                          var user = Get.find<UserController>()
                                              .userModel;
                                          PlaceOrderBody placeOrderBody =
                                              PlaceOrderBody(
                                                  cart: cart,
                                                  orderAmount: 100.0,
                                                  orderNote:
                                                      orderController.foodNote,
                                                  address: location.address,
                                                  latitude: location.latitude,
                                                  longitude: location.longitude,
                                                  contactPersonName: user!.name,
                                                  contactPersonNumber:
                                                      user!.phone,
                                                  scheduleAt: '',
                                                  distance: 10.0,
                                                  paymentMethod: orderController
                                                              .paymentIndex ==
                                                          0
                                                      ? 'wallet'
                                                      : 'digital_payment',
                                                  orderType: orderController
                                                      .orderType);
                                          // print("check order type: " +
                                          //     placeOrderBody
                                          //         .toJson()['order_type']);
                                          // return;
                                          Get.find<OrderController>()
                                              .placeOrder(
                                                  placeOrderBody, _callback);
                                        }
                                      } else {
                                        Get.snackbar("Ops",
                                            "You don't have anything in your cart");
                                      }
                                    } else {
                                      Get.toNamed(RouteHelper.getSignIn());
                                    }
                                  },
                                  child: CommonTextButton(text: "Thanh Toán")),
                            ],
                          ),
                        ])
                      : Container(),
                ),
              ],
            );
          });
        }));
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharePreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id!));
      }
    } else {
      showCustomSnachBar(message);
    }
  }
}
