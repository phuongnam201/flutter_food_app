import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: "My orders",
      ),
      body: _isLoggedIn ? _buildOrdersTab() : _buildLoginContainer(),
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
                text: "Current",
              ),
              Tab(
                text: "History",
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

  Widget _buildLoginContainer() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height20 * 7,
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/signintocontinue.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSignIn());
            },
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20 * 3,
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                child: Center(
                  child: BigText(
                    text: "Sign in",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
