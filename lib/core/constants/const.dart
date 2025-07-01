import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import 'app_color.dart';


String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

Brightness isItDarkTheme(){
  return Brightness.dark;
}

void snackBar(String text,BuildContext context){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}
BoxShadow boxShadow(){
  return BoxShadow();
}

CircularProgressIndicator loader(){
  return CircularProgressIndicator(
    color: AppColors.primary,
  );
}

Widget verticalHeight(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalWidth(double width) {
  return SizedBox(
    width: width,
  );
}

class Const {
  static const int appId= 1049202539;
  static const String appSign = "13787b67728a5984f5bfdbfc37084480f7350fe7fc5d4c86c15521b835620c5b";

  String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  Pattern phonePattern = r'(^[0-9 ]*$)';

  String getUniqueName() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  bool validateEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  static String? toastSuccess(val) {
    if (kDebugMode) {
      Fluttertoast.showToast(
          msg: val,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.textColorBlack,
          fontSize: 16.0);
    }

    print(val);
  }

  static String? toastFail(val) {
    Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.whiteColor,
        textColor: AppColors.textColorBlack,
        fontSize: 16.0);
  }
  static final List<List<Color>> gradients = [
    [AppColors.yellowGradientColor, AppColors.lightYellowGradientColor],
    [AppColors.yellowGradientColor, AppColors.greenGradientColor],
    [AppColors.scaffoldBgColor, AppColors.blueGradientColor],
  ];

  static final List<String> greetingText =[
    "Good Morning",
    "Good Afternoon",
    "Good Evening"
  ];
}

class FontAsset {
  static const String mulish = "Mulish";

  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String getGreeting() {
  final int hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

/// Returns a RadialGradient tuned to the time of day
RadialGradient getTimeOfDayGradient() {
  final int hour = DateTime.now().hour;
  //DateTime.now().hour
  if (hour < 12) {
    // Morning: warm sunrise
    return RadialGradient(
      center: Alignment(0.0, 0.0),
      radius: 1.2,
      stops: [0.0, 1.0],
      colors: [
        AppColors.yellowGradientColor,
        AppColors.lightYellowGradientColor,
      ],
    );
  } else if (hour < 17) {
    // Afternoon: bright sky
    return RadialGradient(
      center: Alignment(0.0, 0.0),
      radius: 1.2,
      stops: [0.0, 1.0],
      colors: [
        AppColors.yellowGradientColor,
        AppColors.greenGradientColor
      ],
    );
  } else {
    // Evening: dusky purple
    return RadialGradient(
      center: Alignment(0.0, 0.0),
      radius: 1.2,
      stops: [0.0, 1.0],
      colors: [
        AppColors.scaffoldBgColor,
        AppColors.blueGradientColor
      ],
    );
  }
}