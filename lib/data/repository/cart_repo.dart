import 'dart:convert';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // print("cart list: " + cartList.toString());
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);

    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    print("cart store: " +
        sharedPreferences.getStringList(AppConstants.CART_LIST).toString());
    getCartList();
    // print("Cart List: " + getCartList().toString());
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      //print("inside cart" + carts.toString());
    }
    List<CartModel> cartList = [];
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (int i = 0; i < cart.length; i++) {
      print("history list" + cart[i].toString());
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    // print("there are " + getCartHistoryList().length.toString());
    // for (int j = 0; j < getCartHistoryList().length; j++) {
    //   print(
    //       "the time of order is: " + getCartHistoryList()[j].time.toString()!);
    // }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  // void removeCartHistory() {
  //   cartHistory = [];
  //   sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  // }

  void removeItemsCart(int id) {
    //print("id received: " + id.toString());
    List<String>? cartList =
        sharedPreferences.getStringList(AppConstants.CART_LIST);

    if (cartList != null) {
      // find id
      int indexToRemove = cartList.indexWhere((element) {
        CartModel cartModel = CartModel.fromJson(jsonDecode(element));
        return cartModel.id == id;
      });

      if (indexToRemove != -1) {
        // delete
        cartList.removeAt(indexToRemove);

        List<String> updatedCartList = [];

        // update list
        cartList.forEach((element) {
          updatedCartList.add(jsonEncode(element));
        });

        sharedPreferences.setStringList(
            AppConstants.CART_LIST, updatedCartList);
        print("Item with id $id has been removed.");
      } else {
        print("Item with id $id not found in the cartList.");
      }
    } else {
      print("CartList is null.");
    }
  }
}
