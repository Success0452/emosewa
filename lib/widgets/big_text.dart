import 'package:emosewa/utlis/dimensions.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;

  BigText({
     Key? key,
     required this.text,
     this.color = const Color(0xFF332d2b),
     this.size= 0,
     this.overflow = TextOverflow.ellipsis,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size==0? Dimensions.font20 : size
      ),
    );
  }
}
