import 'dart:convert';

import 'package:food_app/data/repository/order_history_repo.dart';
import 'package:food_app/models/order_history_model.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final OrderHistoryRepo orderHistoryRepo;

  OrderHistoryController({required this.orderHistoryRepo});

  List<OrderDetail> _orderHistoryList = [];
  List<OrderDetail> get orderHistoryList => _orderHistoryList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    getOrderHistoryList();
  }

  Future<void> getOrderHistoryList() async {
    _isLoading = true;
    update(); // Notify listeners that loading has started

    Response response = await orderHistoryRepo.getAllOrderHistory();
    if (response.statusCode == 200) {
      _orderHistoryList = [];
      var jsonResponse = response.body;

      // Ensure jsonResponse is a Map<String, dynamic>
      if (jsonResponse is Map<String, dynamic>) {
        var orderDetailsResponse = OrderDetailsResponse.fromJson(jsonResponse);
        _orderHistoryList.addAll(orderDetailsResponse.results);

        if (_orderHistoryList.isNotEmpty) {
          print("First Order Details: ${_orderHistoryList[0].foodDetails}");
        }
      } else {
        print("Error: JSON response is not a Map<String, dynamic>");
      }
    } else {
      // Handle errors, you might want to set an error state or log the error
      print("Error: Unable to fetch order history");
    }
    _isLoading = false;
    update(); // Notify listeners that loading has finished
  }
}
