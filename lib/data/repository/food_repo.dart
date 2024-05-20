import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class FoodRepo extends GetxService {
  final ApiClient apiClient;

  FoodRepo({required this.apiClient});
  Future<Response> getAllFoodList() async {
    return await apiClient.getData(AppConstants.ALL_PRODUCT_URI);
  }

  Future<Response> searchFood(String? query) async {
    return await apiClient
        .getData(AppConstants.SEARCH_PRODUCT_URI + "?keyword=${query}");
  }
}
