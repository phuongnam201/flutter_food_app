import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/base/common_require_login.dart';
import 'package:food_app/base/custom_appbar.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/order_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/page/order/view_order.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Đơn hàng của bạn",
      ),
      body: _isLoggedIn ? _buildOrdersTab() : RequireLogin(),
    );
  }

  Widget _buildOrdersTab() {
    return Column(
      children: [
        Container(
          width: Dimensions.screenWidth,
          child: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).disabledColor,
            controller: _tabController,
            tabs: [
              Tab(
                text: "Đã thanh toán",
              ),
              Tab(
                text: "Chưa thanh toán",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            ViewOrder(isCurrent: true),
            ViewOrder(isCurrent: false),
          ]),
        )
      ],
    );
  }
}
