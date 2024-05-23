import 'package:flutter/material.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/utils/style.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;

  PaymentOptionButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Container(
          //margin: EdgeInsets.only(top: Dimensions.height10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!, blurRadius: 5, spreadRadius: 1)
              ]),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize: Dimensions.font20),
            ),
            subtitle: Text(
              subTitle,
              maxLines: 1,
              style: robotoRegular.copyWith(
                fontSize: Dimensions.font16,
              ),
            ),
            trailing: _selected
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.check_circle,
                    color: Theme.of(context).disabledColor,
                  ),
          ),
        ),
      );
    });
  }
}
