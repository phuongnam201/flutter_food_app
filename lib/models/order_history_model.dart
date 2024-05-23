import 'dart:convert';

class OrderDetail {
  int id;
  int orderId;
  int foodId;
  int price;
  Map<String, dynamic> foodDetails; // Change to Map<String, dynamic>
  int quantity;
  int taxAmount;
  dynamic test;
  DateTime createdAt;
  DateTime updatedAt;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.foodId,
    required this.price,
    required this.foodDetails,
    required this.quantity,
    required this.taxAmount,
    this.test,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      orderId: json['order_id'],
      foodId: json['food_id'],
      price: json['price'],
      foodDetails: jsonDecode(json['food_details']), // Parse JSON string to Map
      quantity: json['quantity'],
      taxAmount: json['tax_amount'],
      test: json['test'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'food_id': foodId,
      'price': price,
      'food_details': jsonEncode(foodDetails), // Convert Map to JSON string
      'quantity': quantity,
      'tax_amount': taxAmount,
      'test': test,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class OrderDetailsResponse {
  List<OrderDetail> results;

  OrderDetailsResponse({
    required this.results,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      results: List<OrderDetail>.from(
          json['results'].map((x) => OrderDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<dynamic>.from(results.map((x) => x.toJson())),
    };
  }
}
