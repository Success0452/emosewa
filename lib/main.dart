import 'package:emosewa/controller/cart_controller.dart';
import 'package:emosewa/controller/popular_product_controller.dart';
import 'package:emosewa/pages/food/popular_food_details.dart';
import 'package:emosewa/pages/food/recommended_food_detail.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:emosewa/route/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/recommended_product_controller.dart';
import 'helper/dependecies.dart' as dependency;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<CartController>().getCartData();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
