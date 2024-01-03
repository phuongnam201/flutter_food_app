import 'package:food_app/controller/popular_product_controller.dart';
import 'package:food_app/controller/recommended_product_controller.dart';
import 'package:food_app/page/home/food/popular_food_detail.dart';
import 'package:food_app/page/home/food/recommended_food_detail.dart';
import 'package:food_app/page/home/food_page_body.dart';
import 'package:food_app/page/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainFoodPage(),
      //initialRoute:  RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
