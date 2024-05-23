import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/utils/style.dart';
import 'package:get/get.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOption(
      {super.key,
      required this.value,
      required this.title,
      required this.amount,
      required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Row(
        children: [
          Radio(
              value: value,
              groupValue: controller.orderType,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (String? value) => controller.setDeliveryType(value!)),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            title,
            style: robotoRegular,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
              '(${(value == "Tôi sẽ đến lấy" || isFree) ? "free" : "₫ ${amount}"})'),
        ],
      );
    });
  }
}
