import 'package:emosewa/controller/popular_product_controller.dart';
import 'package:emosewa/controller/recommended_product_controller.dart';
import 'package:emosewa/route/route_helper.dart';
import 'package:emosewa/utlis/app_constants.dart';
import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/big_text.dart';
import 'package:emosewa/widgets/icon_and_text_widget.dart';
import 'package:emosewa/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/popular_product_model.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currentValue = 0.0;
  var _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      [
        //slider section
        GetBuilder<PopularProductController>(
            builder: (popularProducts){
              return popularProducts.isLoaded?
              GestureDetector(
                onTap: () {
                  // Get.toNamed(RouteHelper.getPopularFood());
                },
                child: Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position){
                        return _buildPage(position, popularProducts.popularProductList[position]);
                      }
                  ),
                ),
              ): const CircularProgressIndicator(
                color: AppColors.mainColor,
              );
            }),
    //Dots section
    GetBuilder<PopularProductController>(
        builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
            position: _currentValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30, ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height2),
                child: SmallText(text: "Food pairing",),
              )
            ],
          ),
        ),
        //list of food and images
        SizedBox(height: Dimensions.height30,),
        GetBuilder<RecommendedProductController>(builder: (recommendedProductList){
          return recommendedProductList.isLoaded ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProductList.recommendedProductList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          height: Dimensions.listViewImg,
                          width: Dimensions.listViewImg,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BaseUrl+AppConstants.Upload+recommendedProductList.recommendedProductList[index].img!
                                  )
                              )
                          ),
                        ),
                        //text container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20),
                                    bottomRight: Radius.circular(Dimensions.radius20)
                                )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProductList.recommendedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "With nigeria characteristic"),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }) :
          const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })
      ],
    );
  }

  Widget _buildPage(int index, ProductModel popularProductList){
    Matrix4 matrix4 = Matrix4.identity();
    if(index == _currentValue.floor()){
      var currentScale = 1-(_currentValue-index) * (1-_scaleFactor);
      var currentTrans = _height * (1 - currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else if(index == (_currentValue.floor() + 1)){
      var currentScale = _scaleFactor+(_currentValue-index+1)* (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }else if(index == (_currentValue.floor() - 1)){
      var currentScale = 1-(_currentValue-index) * (1-_scaleFactor);
      var currentTrans = _height * (1 - currentScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child: Container(
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? const Color(0xFF89dad0) : const Color(0xFFccc7c5),
              image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BaseUrl +AppConstants.Upload+popularProductList.img!
                  ),
                  fit: BoxFit.cover
              )
          ),
      ),
        ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width40, right: Dimensions.width40, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0)
                  ),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0)
                  ),
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15,),
                child: AppColumn(text: popularProductList.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
