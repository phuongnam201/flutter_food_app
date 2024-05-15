import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:flutter/material.dart';

import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  /**if app has trouble store memory */
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecommendedProductController>().getRecommendedProductList();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato",
          ),
          //home: MainFoodPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });

    /**old version */
    // Get.find<PopularProductController>().getPopularProductList();
    // Get.find<RecommendedProductController>().getRecommendedProductList();
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   //home: SplashScreen(),
    //   initialRoute: RouteHelper.getSplashPage(),
    //   getPages: RouteHelper.routes,
    // );
  }
}
