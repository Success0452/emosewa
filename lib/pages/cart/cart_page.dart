import 'package:emosewa/controller/cart_controller.dart';
import 'package:emosewa/controller/popular_product_controller.dart';
import 'package:emosewa/pages/home/main_page.dart';
import 'package:emosewa/route/route_helper.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/recommended_product_controller.dart';
import '../../utlis/app_constants.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*2,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: AppIcon(
                      icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size: Dimensions.icon35,
                  ),
                ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.icon35,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size: Dimensions.icon35,
                ),
              ],)),
          Positioned(
            top: Dimensions.height20*4,
              right: Dimensions.width20,
              left: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                // color: Colors.redAccent,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.allItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index){
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20*5,
                            child: Row(
                              children: [
                                //image section
                                GestureDetector(
                                  onTap: (){
                                    var popularIndex= Get.find<PopularProductController>()
                                        .popularProductList.indexOf(_cartList[index].product!);
                                    if(popularIndex >= 0){
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>()
                                          .recommendedProductList.indexOf(_cartList[index].product!);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex));
                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    width: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BaseUrl+AppConstants.Upload+_cartList[index].img!
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                //text container
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.radius20),
                                            bottomRight: Radius.circular(Dimensions.radius20)
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartController.allItems[index].name!),
                                          SizedBox(height: Dimensions.height10,),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: cartController.allItems[index].price.toString(), color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height5, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.height20),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: const Icon(Icons.remove, color: AppColors.signColor,)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartList[index].quantity.toString()),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(_cartList[index].product!, 1);
                                                        },
                                                        child: const Icon(Icons.add, color: AppColors.signColor,)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },)
                )
              )
          )
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            height: Dimensions.bottomHeightBar,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                ),
                color: AppColors.buttonBackgroundColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width10,),
                      BigText(text: "# ${cartController.totalPrice.toString()}"),
                      SizedBox(width: Dimensions.width10,),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                    child: BigText(text: "Check Out", color: Colors.white,),
                  ),
                )
              ],
            ),
          );
        },)
    );
  }
}
