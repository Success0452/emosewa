import 'dart:convert';

import 'package:emosewa/utlis/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addCartToList(List<CartModel> cartModel){
    cart = [];

    cartModel.forEach((element) => cart.add(jsonEncode(element)));

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

}