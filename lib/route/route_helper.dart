import 'package:emosewa/pages/food/popular_food_details.dart';
import 'package:emosewa/pages/food/recommended_food_detail.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:get/get.dart';

class RouteHelper{

  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => "$initial";
  static String getPopularFood() => "$popularFood";
  static String getRecommendedFood() => "$recommendedFood";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainPage()),

    GetPage(
        name: popularFood,
        page: () => const PopularFoodDetails(),
      transition: Transition.fadeIn
    ),

    GetPage(
        name: recommendedFood,
        page: () => const RecommendedFoodDetail(),
        transition: Transition.fadeIn
    ),
  ];
}