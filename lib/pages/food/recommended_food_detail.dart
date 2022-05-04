import 'package:emosewa/route/route_helper.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/app_icon.dart';
import 'package:emosewa/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:  () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                    child: AppIcon(icon: Icons.cancel)),
                AppIcon(icon: Icons.add_shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child: Center(child: BigText(size: Dimensions.font20, text: "Chinese Side",))
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/image/food0.png",
              width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: const ExpandableText(text: "Famous is always with his system at the very end on the run with a small ink of grace, "
                      "Famous is always with his system at the very end on the run with a small ink of grace, "
                      "Famous is always with his system at the very end on the run with a small ink of grace"
                      "Famous is always with his system at the very end on the run with a small ink of grace"),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width30 * 3,
                right: Dimensions.width30 * 3,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.remove,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                size: Dimensions.icon24,
                ),
                BigText(color: AppColors.mainBlackColor, size: Dimensions.font26 ,text: " #54,000 " + " X " + " O "),
                AppIcon(icon: Icons.add,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size: Dimensions.icon24,
                ),
              ],
            ),
          ),
          Container(
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
                  child: const Center(
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
