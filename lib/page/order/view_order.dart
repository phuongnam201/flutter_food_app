import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  ViewOrder({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (controller) {
        if (controller.isLoading == false) {
          late List<OrderModel> orderList;
          if (controller.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? controller.currentOrderList.reversed.toList()
                : controller.historyOrderList.reversed.toList();
          }
          return SizedBox(
              width: Dimensions.screenWidth,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
                child: ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => null,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height10 / 2),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Color.fromARGB(255, 240, 233, 233)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("#order id: " +
                                  orderList[index].id.toString()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4)),
                                    child: Container(
                                        margin: EdgeInsets.all(
                                            Dimensions.height10 / 2),
                                        child: Text(
                                          orderList[index]
                                              .orderStatus
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  InkWell(
                                    onTap: () => null,
                                    child: Container(child: Text("track")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ));
        } else {
          return Center(child: CustomLoader());
        }
      }),
    );
  }
}
