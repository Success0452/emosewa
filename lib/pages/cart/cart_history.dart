import 'package:emosewa/controller/cart_controller.dart';
import 'package:emosewa/utlis/app_constants.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/app_icon.dart';
import 'package:emosewa/widgets/big_text.dart';
import 'package:emosewa/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPreOrder = {};

    for(int i = 0; i < getCartHistoryList.length; i++){
      if(cartItemsPreOrder.containsKey(getCartHistoryList[i])){
        cartItemsPreOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPreOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList(){
      return cartItemsPreOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemPerOrder = cartOrderTimeToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height40),
            height: Dimensions.height10*10,
            width: double.maxFinite,
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor, backgroundColor: AppColors.yellowColor,)
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for(int i =0; i < itemPerOrder.length; i++)
                        Container(
                          height: Dimensions.height30*4,
                          margin: EdgeInsets.only(bottom: Dimensions.height20) ,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Famous'),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children:
                                    List.generate(itemPerOrder[i], (index) {
                                      if(listCounter<getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index<=2?Container(
                                        width: Dimensions.height20*4,
                                        height: Dimensions.height20*4,
                                        margin: EdgeInsets.only(right: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BaseUrl + AppConstants.Upload + getCartHistoryList[listCounter -1].img!
                                                )
                                            )
                                        ),
                                      ) : Container();
                                    }
                                    ),
                                  ),
                                  Container(
                                    height: Dimensions.height20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total", color: AppColors.titleColor,),
                                        BigText(text: itemPerOrder[i].toString() + "Items", color: AppColors.titleColor,),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.width10,
                                              vertical: Dimensions.height10
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                            border: Border.all(width: 1, color: AppColors.mainColor)
                                          ),
                                          child: SmallText(text: 'one more', color: AppColors.mainColor,),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ), )
            ),
          )
        ],
      ),
    );
  }
}
