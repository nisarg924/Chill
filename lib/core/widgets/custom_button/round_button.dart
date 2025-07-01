import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.bgColor,
    this.bgHeight,
    this.bgWidth,
    this.imageHeight,
    this.imageWidth,
    required this.isPadding,
  });

  final VoidCallback onTap;
  final String image;
  final Color bgColor;
  final double? bgHeight;
  final double? bgWidth;
  final double? imageHeight;
  final double? imageWidth;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bgHeight ?? Dimensions.h48,
      width: bgWidth ?? Dimensions.w48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        padding: isPadding ? EdgeInsets.zero : EdgeInsets.all(Dimensions.h8),
        icon: Image.asset(
          image,
          height: imageHeight ?? Dimensions.h32,
          width: imageWidth ?? Dimensions.w32,
        ),
      ),
    );
  }
}
