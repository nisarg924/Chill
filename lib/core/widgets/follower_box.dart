import 'package:flutter/material.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/style.dart';

class FollowerBox extends StatelessWidget {
  const FollowerBox({super.key, required this.upperNumberText, required this.belowText});

  final String upperNumberText;
  final String belowText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h90,
      width: Dimensions.w90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.r12),
        border: Border.all(width: 1,color: Colors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(upperNumberText,style: fontStyleBold20,),
          Text(belowText,style: fontStyleRegular16,),
        ],
      ),
    );
  }
}
