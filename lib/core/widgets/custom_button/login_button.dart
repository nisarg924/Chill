import 'package:flutter/material.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/style.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap, required this.text, this.elevation, this.minHeight, this.minWidth});
  final VoidCallback onTap;
  final String text;
  final double? elevation;
  final double? minHeight;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth??double.infinity, minHeight??Dimensions.h50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w20, vertical: Dimensions.h12),
        elevation: elevation??0,
      ),
      child: Text(text, style: fontStyleMedium16),
    );
  }
}
