import 'package:flutter/material.dart';

class HalfBoxGradient extends StatelessWidget {
  const HalfBoxGradient({super.key,this.width,this.height,required  this.gradientColor1,required  this.gradientColor2});

  final double? width;
  final double? height;
  final Color gradientColor1;
  final Color gradientColor2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? double.infinity,
      height: height??MediaQuery.of(context).size.height/2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientColor1,
            gradientColor2,
          ],
        ),
      ),
    );
  }
}
