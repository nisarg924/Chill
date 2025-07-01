import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../constants/dimensions.dart';
import '../../utils/style.dart';

class TappableText extends StatelessWidget {
  const TappableText({super.key,required this.text,required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,style: fontStyleMedium22.copyWith(color: AppColors.redTextColor),),
          line(),
        ],
      ),
    );
  }
}

Widget line(){
  return Container(
    height: Dimensions.h1,
    width: Dimensions.w150,
    color: AppColors.blueTextColor,
    child: Text(""),
  );
}