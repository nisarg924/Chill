import 'package:flutter/material.dart';
import 'package:social_app/core/constants/dimensions.dart';

import '../constants/app_color.dart';

class GradientContainer extends StatelessWidget {
   GradientContainer({
    super.key,
    required this.child,
    this.isScrolled = false,
    this.colors,
    this.image,
    this.imageHeight,
    this.imageWidth,
    this.imageAlignment,
    this.isNameIntroScreen =false,
     this.isIntroScreen =false
  });

  final Widget child;
  final bool? isScrolled;
  final List<Color>? colors;

  final String? image;
  final double? imageHeight;
  final double? imageWidth;
  final AlignmentGeometry? imageAlignment;
  final bool isNameIntroScreen;
  final bool isIntroScreen;
  // final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors ?? [AppColors.yellowGradientColor, AppColors.yellowGradientColor.withAlpha(0), AppColors.lightYellowGradientColor.withAlpha(0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.19, 1],
          ),
        ),
      ),
      if (image != null)
        Positioned(
          bottom: 0,
          left: isNameIntroScreen?0:Dimensions.w10,
          right: isNameIntroScreen?null:0,
          child: Image.asset(
            image!,
            height: imageHeight ?? Dimensions.h300,
            width: imageWidth ?? Dimensions.w281,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),

      // Positioned(bottom: Dimensions.h276,child: ArrowButton(onTap: (){},isShadow: true,),left: Dimensions.w163,right: Dimensions.w163,),
      Positioned.fill(bottom: isIntroScreen?0:kBottomNavigationBarHeight,top: isIntroScreen?0:tHeight,
        child: child,
      )
    ]);
  }
  final double tHeight = Dimensions.h115;
}
