import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({
    Key? key, required this.icon, required this.text, required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.icon24,),
        const SizedBox(width: 5.0,),
        SmallText(text: text)
      ],
    );
  }
}
