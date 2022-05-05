import 'package:emosewa/controller/cart_controller.dart';
import 'package:emosewa/controller/popular_product_controller.dart';
import 'package:emosewa/data/api/api_client.dart';
import 'package:emosewa/data/repository/cart_repo.dart';
import 'package:emosewa/data/repository/popular_product_repo.dart';
import 'package:emosewa/utlis/app_constants.dart';
import 'package:get/get.dart';

import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{

  // Apiclient injection
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BaseUrl));

  //Repositories injection
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //Controllers injection
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}