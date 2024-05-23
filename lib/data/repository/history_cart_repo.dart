import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class HistoryCartRepo extends GetxService {
  final ApiClient apiClient;

  HistoryCartRepo({required this.apiClient});
  Future<Response> getAllFoodList() async {
    return await apiClient.getData(AppConstants.ALL_PRODUCT_URI);
  }
}
