import 'package:food_app/models/order_model.dart';
import 'package:food_app/page/address/add_address_page.dart';
import 'package:food_app/page/address/pick_address_map.dart';
import 'package:food_app/page/auth/sign_in_page.dart';
import 'package:food_app/page/cart/cart_page.dart';
import 'package:food_app/page/food/food_detail.dart';
import 'package:food_app/page/food/popular_food_detail.dart';
import 'package:food_app/page/food/recommended_food_detail.dart';
import 'package:food_app/page/home/home_page.dart';
import 'package:food_app/page/payment/order_success_page.dart';
import 'package:food_app/page/payment/payment_page.dart';
import 'package:food_app/page/search/search_product.dart';
import 'package:food_app/page/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String foodDetail = "/food-details";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/signIn";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";
  static const String searchProduct = "/search";

  static String getInitial() => '$initial';
  static String getSplashPage() => '$splashPage';
  static String getSearchProduct() => '$searchProduct';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getFoodDetail(int pageId, String page) =>
      '$foodDetail?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignIn() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status) =>
      '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: foodDetail,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return FoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signIn,
      page: () {
        return SignInPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddressMap = Get.arguments;
          return _pickAddressMap;
        }),
    GetPage(
        name: payment,
        page: () => PaymentPage(
            orderModel: OrderModel(
                id: int.parse(Get.parameters['id']!),
                userId: int.parse(Get.parameters['userID']!)))),
    GetPage(
      name: orderSuccess,
      page: () => OrderSuccessPage(
          orderID: Get.parameters['id']!,
          status:
              Get.parameters["status"].toString().contains("success") ? 1 : 0),
    ),
    GetPage(
      name: searchProduct,
      page: () {
        return SearchProductPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
