import 'dart:async';

import 'package:emosewa/route/route_helper.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        ()=> {
      Get.toNamed(RouteHelper.getInitial()),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,

              child: Center(child: Image.asset("assets/image/logo part 1.png", width: Dimensions.splashImg,))),
          Center(child: Image.asset("assets/image/logo part 2.png", width: Dimensions.splashImg,))
        ],
      ),
    );
  }
}
