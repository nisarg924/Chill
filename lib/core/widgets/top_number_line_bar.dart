import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/const.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';

class TopNumberLineBar extends StatelessWidget {
  const TopNumberLineBar({super.key,required this.axisAlignment, required this.text, required this.isLast, required this.isMiddle});
  final MainAxisAlignment axisAlignment;
  final String text;
  final bool isLast;
  final bool isMiddle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalHeight(Dimensions.h10),
        Row(
          mainAxisAlignment: axisAlignment,
          children: [
            if(isLast)
              Container(
              width: MediaQuery.of(context).size.width*0.45,
              height: Dimensions.h2dot5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.blueTextColor.withAlpha(0),AppColors.blueTextColor],stops: [0,1])
              ),
              child: Text(""),
            ),
            //circle number
            Container(
              height: Dimensions.h32,
              width: Dimensions.w32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.redGradientColor,
              ),alignment: Alignment.center,
              child: Text(text,style: fontStyleMedium14.copyWith(color: AppColors.whiteColor),),
            ),
            if(isMiddle)Container(
              width: MediaQuery.of(context).size.width*0.46,
              height: Dimensions.h2dot5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.blueTextColor,AppColors.blueTextColor.withAlpha(0)],stops: [0,1])
              ),
              child: Text(""),
            )
          ],
        ),
      ],
    );
  }
}
