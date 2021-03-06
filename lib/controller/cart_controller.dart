import 'package:emosewa/data/repository/cart_repo.dart';
import 'package:emosewa/models/cart_model.dart';
import 'package:emosewa/models/popular_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utlis/colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  List<CartModel> storageItems = [];

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity!+quantity;
        return CartModel(
          id : value.id,
          name : value.name,
          price : value.price,
          img : value.img,
          isExit: true,
          quantity : value.quantity!+quantity,
          time : DateTime.now().toString(),
          product: product,
        );
      });
      if(totalQuantity <= 0){
        _items.remove(product.id);
      }
    }else{
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () => CartModel(
          id : product.id,
          name : product.name,
          price : product.price,
          img : product.img,
          quantity : quantity,
          isExit : true,
          time : DateTime.now().toString(),
          product: product,
        ));
      }else{
        Get.snackbar(
            "Item Count", "at least one item is needed!",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white,
            duration: const Duration(seconds: 1)
        );
      }
    }
    cartRepo.addCartToList(allItems);
    update();
  }

  bool isExist(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity =0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get allItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  void historyList(){
    cartRepo.addCartHistoryList();
    clear();
  }
  void clear(){
    _items = {};
    update();
  }

  int get totalPrice{
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

  set setCart(List<CartModel> items){
    storageItems = items;

    for(int i = 0; i < storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

}
