import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/data/api/repository/popular_product_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _isLoaded = true;
      //print("Nhong se yo");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      update();
    } else {
      print("error");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      //print("ok em ee");
      _quantity = checkQuantity(quantity + 1);
      print("so luong sp:" + _quantity.toString());
    } else {
      _quantity = checkQuantity(quantity - 1);
      print("so luong sp:" + _quantity.toString());
    }
    update();
  }

  checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if ((_inCartItems + quantity) > 10) {
      Get.snackbar(
        "Item count",
        "You can only add up to ${10 - _inCartItems} more products ",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 10 - _inCartItems;
    } else {
      return quantity;
    }
  }

  void initialProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existedInCart(product);
    //print("exist or not: " + exist.toString());

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //print("the quantity in cart: " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    //if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      // print("id " +
      //     value.id.toString() +
      //     " quantity " +
      //     value.quantity.toString());
    });
    // } else {
    //  Get.snackbar("Item count", "You should at least add an item in the cart");
    //}
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
