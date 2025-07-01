import 'package:flutter/material.dart';

import '../../constants/app_color.dart';
import '../../utils/enum.dart';

class ModelThemesTypes {
  String? title = "";
  AppThemesType? themesType = AppThemesType.dark;
  String? themesName = "";
  Color? themeColor = ColorConst.whiteColor;
  Color? textColor = ColorConst.textColorBlack;

  ModelThemesTypes({this.title, this.themesType, this.themesName, this.themeColor, this.textColor});
}
