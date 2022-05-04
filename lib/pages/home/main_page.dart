import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/big_text.dart';
import 'package:emosewa/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'food_page_body.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    print("current Page Height" + MediaQuery.of(context).size.width.toString() );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //showing the header
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height5, bottom: Dimensions.height15),
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Nigeria", color: AppColors.mainColor,),
                        Row(
                          children: [
                            SmallText(text: "Ibadan"),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor
                      ),
                      child: Icon(Icons.search,color: Colors.white, size: Dimensions.icon24,),
                    )
                  ],
                ),
              ),
            ),
            //showing the body
            const Expanded(
                child: SingleChildScrollView(
                    child: FoodPageBody()
                )
            ),
          ],
        ),
      ),
    );
  }
}
