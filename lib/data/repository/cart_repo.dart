import 'dart:convert';

import 'package:emosewa/utlis/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addCartToList(List<CartModel> cartModel){
    var time = DateTime.now().toString();
    cart = [];

    cartModel.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CartList, cart);
    var sharedP = sharedPreferences.getStringList(AppConstants.CartList);
    print(sharedP);
  }

  List<CartModel> getCartList(){

    List<String> cart = [];
    if(sharedPreferences.containsKey(AppConstants.CartList)){
      cart = sharedPreferences.getStringList(AppConstants.CartList)!;
    }
    List<CartModel> cartList = [];

    cart.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  void addCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CartHistoryList)){
      sharedPreferences.getStringList(AppConstants.CartHistoryList);
    }
    for(int i =0; i < cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CartHistoryList, cartHistory);
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CartList);
  }

  List<CartModel> getCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.CartHistoryList)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CartHistoryList)!;
    }
    List<CartModel> cartModel = [];
    for (var element in cartHistory) {
      cartModel.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartModel;
  }

}