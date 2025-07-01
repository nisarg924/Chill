import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  Loader._();

  static final instance = Loader._();

  init() {
    print("Inside loader init");
    // EasyLoading.init();
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
    // ..indicatorWidget=  Lottie.asset(ImageAsset.icLoader,height: 50,width: 50)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..indicatorSize = 60
      ..maskType = EasyLoadingMaskType.black
      ..dismissOnTap = false
      ..textColor = Colors.transparent
      ..boxShadow = <BoxShadow>[]
      ..userInteractions = false;
  }
}
