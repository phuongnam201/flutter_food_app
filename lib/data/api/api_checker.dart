import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignIn());
    } else {
      showCustomSnachBar(response.statusText!);
    }
  }
}
