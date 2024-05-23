import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderHistoryRepo extends GetxService {
  final ApiClient apiClient;

  OrderHistoryRepo({required this.apiClient});
  Future<Response> getAllOrderHistory() async {
    return await apiClient.getData(AppConstants.ORDER_DETAIL_LIST_URI);
  }
}
