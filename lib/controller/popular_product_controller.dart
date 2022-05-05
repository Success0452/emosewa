import 'package:emosewa/controller/cart_controller.dart';
import 'package:emosewa/data/repository/popular_product_repo.dart';
import 'package:emosewa/models/cart_model.dart';
import 'package:emosewa/models/popular_product_model.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList=[];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _cartItems = 0;
  int get cartItems => _cartItems+quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      print("product gotten");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
      _isLoaded = true;
    }else{

    }

  }

  void setQuantity(bool isIncreased){
    if(isIncreased){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }
  
  int checkQuantity(int quantity){
    if((_cartItems+quantity) < 0){
      Get.snackbar(
          "Item Count", "You can't reduce more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 1)
      );

      if(_cartItems > 0){
        _quantity = _cartItems;
        return _quantity;
      }
      return 0;
    }else if((_cartItems+quantity) > 20){
      Get.snackbar(
        "Item Count", "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 1)
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _cartItems = 0;
    _cart = cart;

    var exit = false;
    exit = cart.isExist(product);
    if(exit){
      _cartItems = cart.getQuantity(product);
    }
    print(_cartItems.toString());
  }

  void addItem(ProductModel productModel){
      _cart.addItem(productModel, _quantity);
      _quantity = 0;
      _cartItems = _cart.getQuantity(productModel);

      update();
    }

    int get totalItems{
      return _cart.totalItems;
    }

    List<CartModel> get allItems{
    return _cart.allItems;
    }

  }
