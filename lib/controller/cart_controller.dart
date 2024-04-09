import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/repository/cart_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        if (quantity <= 0) {
          Get.snackbar("Item count", "You can't reduce more",
              margin: EdgeInsets.all(5),
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white);

          totalQuantity = 1;
        } else if (totalQuantity > 10) {
          Get.snackbar("Item count", "The maximum quantity is 10",
              margin: EdgeInsets.all(5),
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white);
          totalQuantity = 10;
        }
        Get.snackbar("Item count", "${quantity} was added to cart");

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

      // update();
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
      // update();
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  void deleteItem(ProductModel product) {
    cartRepo.removeItemsCart(product.id!);
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

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    //print("length of cart items: " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharePreference() {
    cartRepo.removeCartSharePreference();
  }
}
