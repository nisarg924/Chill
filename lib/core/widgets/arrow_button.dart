import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/app_image.dart';
import '../constants/dimensions.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key, required this.onTap, this.image,this.isShadow = false});

  final VoidCallback onTap;
  final String? image;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h48,
        width: Dimensions.w48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isShadow?AppColors.scaffoldBgColor:AppColors.transparentColor,
          border: Border.all(
            color: AppColors.redTextColor,width: Dimensions.w2
          ),
          boxShadow: isShadow?[BoxShadow(color: AppColors.textColorBlack.withOpacity(0.25),offset: Offset(0, 4),blurRadius: 4,spreadRadius: 0)]:[],
        ),
        child: IconButton(
            onPressed: onTap,
            icon: Image.asset(
              image??AppImage.icAppLogo,width: Dimensions.w10,height: Dimensions.h20,color: AppColors.redTextColor,
            ),
        ),
    );
  }
}
