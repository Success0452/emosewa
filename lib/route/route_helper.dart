import 'package:emosewa/pages/cart/cart_page.dart';
import 'package:emosewa/pages/food/popular_food_details.dart';
import 'package:emosewa/pages/food/recommended_food_detail.dart';
import 'package:emosewa/pages/home/home.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:emosewa/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper{

  static const String initial = "/";
  static const String splashPage = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => "$initial";
  static String getSplashPage() => "$splashPage";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) => "$recommendedFood?pageId=$pageId";
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),

    GetPage(
        name: popularFood,
        page: (){
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetails(pageId: int.parse(pageId!),);
        },
      transition: Transition.fadeIn
    ),

    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage,
        page: () => const CartPage(),
      transition: Transition.fadeIn
    ),

    GetPage(name: splashPage,
        page: () => const SplashPage(),
        transition: Transition.fadeIn
    )
  ];
}