import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/api/repository/cart_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (quantity < 1) {
      Get.snackbar("Item count", "You should add at least 1 item to the cart",
          margin: EdgeInsets.all(5),
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
    }

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        // print("so luong dang co trong gio hàng: " + value.quantity.toString());
        // print("so luong moi: " + quantity.toString());
        // print("total item id ${product.id!} in cart is " +
        //     totalQuantity.toString());

        // Hạn chế số lượng tối đa là 10
        if (totalQuantity >= 10) {
          Get.snackbar("Item count", "The maximum quantity is 10",
              margin: EdgeInsets.all(5),
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white);
          totalQuantity = 10;
        }

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: totalQuantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity < 1) {
        Get.snackbar("Item count", "You can't reduce more",
            margin: EdgeInsets.all(5),
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
        totalQuantity = 1;
      }
    } else {
      if (quantity > 0 && quantity <= 10) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("Item count", "Quantity should be between 1 and 10",
            margin: EdgeInsets.all(5),
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white);
      }
    }
    update();
  }

  void deleteItem(ProductModel product) {
    _items.remove(product.id);
    update();
  }

  bool existedInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      //totalQuantity = totalQuantity + value.quantity!;
      totalQuantity = totalQuantity + 1;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
