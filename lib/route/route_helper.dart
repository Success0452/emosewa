import 'package:emosewa/pages/cart/cart_page.dart';
import 'package:emosewa/pages/food/popular_food_details.dart';
import 'package:emosewa/pages/food/recommended_food_detail.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:get/get.dart';

class RouteHelper{

  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => "$initial";
  static String getPopularFood(int pageId) => "$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId) => "$recommendedFood?pageId=$pageId";
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainPage()),

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
        page: () => CartPage(),
      transition: Transition.fadeIn
    )
  ];
}