import 'package:emosewa/utlis/colors.dart';
import 'package:emosewa/utlis/dimensions.dart';
import 'package:emosewa/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty ?SmallText(height: 1.8, color: AppColors.paraColor, size: Dimensions.font16, text: firstHalf) : Column(
      children: [
        SmallText(height: 1.8, color: AppColors.paraColor, size: Dimensions.font16, text: hiddenText? (firstHalf + "..."): firstHalf + secondHalf),
        InkWell(
          onTap: (){
            setState(() {
              hiddenText = !hiddenText;
            });
          },
          child: Row(
            children: [
              SmallText(text: "Show more", color: AppColors.mainColor,),
              Icon(hiddenText? Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,)
            ],
          ),
        )
      ],
    );
  }
}

