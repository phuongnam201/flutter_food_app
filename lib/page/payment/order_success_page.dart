import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage(
      {super.key, required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {});
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle_outline
                    : Icons.warning_amber_outlined,
                size: 100,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? "Bạn đặt đã đặt hàng có mã đơn ${orderID}"
                    : "Đơn hàng có mã đơn  ${orderID}",
                style: TextStyle(fontSize: Dimensions.font20),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height20),
                child: Text(
                  status == 1 ? "Thành công" : "Thất bại",
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: CustomButton(
                  buttonText: "Back to home",
                  onPressed: () => Get.offAndToNamed(RouteHelper.getInitial()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
