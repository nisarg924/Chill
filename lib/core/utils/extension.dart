import 'package:collection/collection.dart';

import 'dart:io';
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constants/app_color.dart';
import '../constants/const.dart';
import '../constants/dimensions.dart';
import 'date_formats.dart';

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension ListFilter<T> on List<T>? {
  T? firstOrNull(bool Function(T element) test) {
    if (this == null) return null;
    return this?.firstWhereOrNull(test);
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }



  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  bool hasAll(List<T> anotherList) {
    if (isNullOrEmpty()) return false;
    bool containsAllElement = true;
    for (var i = 0; i < this!.length; i++) {
      containsAllElement = anotherList.contains(this![i]);
      if (!containsAllElement) break;
    }
    return containsAllElement;
  }
}
extension EmailValidator on String? {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this!);
  }
}

extension StringNullablity on String? {

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }

  String orEmpty() {
    if (isNullOrEmpty()) return "";
    return this!;
  }

  String orDash() {
    if (isNullOrEmpty())
      {return "-";}
    else
      {return this!;}
  }

  String ifEmpty(String another) {
    if (isNullOrEmpty()) {
      return another;
    } else {
      return this!;
    }
  }

  String removeExtras() {
    if (isNullOrEmpty()) return "";
    var trimmedString = this!.trim();
    var firstReplacedString = trimmedString.replaceAll("-", "");
    var finalReplacedString = firstReplacedString.replaceAll("+", "");
    return finalReplacedString;
  }

  bool isEqualIgnoreCase(String? another) {
    if (isNullOrEmpty() || another.isNullOrEmpty()) return this == another;
    return this!.toLowerCase() == another!.toLowerCase();
  }

  String withColon(dynamic value) {
    return "$this: ${value.toString()}";
  }

  String withEndSpace() {
    return "$this ";
  }

  String withComma(dynamic value) {
    return "$this, ${value.toString()}";
  }

  String withEndDot() {
    return "$this.";
  }

  String withAnother(dynamic value) {
    if (value != null) {
      return "$this ${value.toString()}";
    } else {
      return "$this ";
    }
  }

  String addEndSpace() {
    return "$this ";
  }

  String withBrackets(dynamic value) {
    if (isNullOrEmpty()) return "(${value.toString()})";
    return "$this (${value.toString()})";
  }
}


bool notNull(String? data) {
  return data.isNotNullOrEmpty();
}

String orEmpty(String? data) {
  return data.orEmpty();
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension FileExtention on FileSystemEntity {
  String get name {
    return path.split("/").last ?? "";
  }
}

extension WidgetPaddingExtension on Widget {
  Widget toOnlyPadding({double? top, double? left, double? bottom, double? right}) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0),
      child: this,
    );
  }

  Widget toHorizontalPadding(double? val) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: val ?? 0),
      child: this,
    );
  }

  Widget toVerticalPadding(double? val) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: val ?? 0),
      child: this,
    );
  }
}

extension DoubleDigit on int? {
  String toDoubleDigit() {
    if (this == null) {
      return "0";
    }
    return toString().padLeft(2, '0');
  }

  String toMonthName() {
    if (this == null) {
      return "";
    }

    DateTime date = DateTime(2023, this!, 1);
    return DateFormat.MMM().format(date);
  }

  String toWeekName() {
    if (this == null) {
      return "";
    }
    List<String> weeklyChartData = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weeklyChartData[this!];
  }
}

extension CircuitFormat on int? {
  bool isActive() {
    if (this == null) return false;
    return this! == 1;
  }
}

extension DateFormater on String? {
  String toDateTime() {
    DateTime inputDate = DateTime.now();
    if (toString().isNotNullOrEmpty()) {
      inputDate = DateFormat(DateFormats.dateFormatServer).parse(toString());
    }
    return DateFormat(DateFormats.dateFormatYYYYMMSSHHMMSS).format(inputDate);
  }
}

extension GraphFormat on double? {
  String toDirection() {
    if (this == null) {
      return "ltr";
    }
    if (this! > 0) {
      return "ltr";
    } else {
      return "rtl";
    }
  }
}

extension GraphDataFormater on String? {
  String toDailyGraphHrsFormat() {
    if (isNullOrEmpty()) return "";
    return changeDateFormat(this!, DateFormats.dateFormatYYYYMMSSTHHMMSS, DateFormats.dateFormatHH);
  }

  String toWeekGraphHrsFormat() {
    if (isNullOrEmpty()) return "";
    return changeDateFormat(this!, DateFormats.dateFormatYYYYMMSSTHHMMSS, DateFormats.dateFormatEEE);
  }

  String toMonthGraphHrsFormat() {
    if (isNullOrEmpty()) return "";
    return changeDateFormat(this!, DateFormats.dateFormatYYYYMMSSTHHMMSS, DateFormats.dateFormatDD);
  }

  String toYearGraphHrsFormat() {
    if (isNullOrEmpty()) return "";
    return changeDateFormat(this!, DateFormats.dateFormatYYYYMMSSTHHMMSS, DateFormats.dateFormatMMM);
  }
}


Widget gradientContainer(BuildContext context, {List<Color>? gradientColors}) {
  return Container(
    height: MediaQuery.of(context).size.height / 2,
    width: double.infinity,
    decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColors ?? [])),
  );
}

extension UIThemeExtension on BuildContext {
  /// New font style here

  TextStyle? get fontStyleBoldRed37 => Theme.of(this).textTheme.bodyLarge?.copyWith(
    fontWeight: FontAsset.bold,
    fontSize: Dimensions.sp37,
    color: ColorConst.textGradientRedColor,
  );

  TextStyle? get fontStyleRegularDarkBlue19 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.regular,
    fontSize: Dimensions.sp19,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleRegularDarkBlue18 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.regular,
    fontSize: Dimensions.sp18,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleSemiBoldDarkBlue18 => Theme.of(this).textTheme.bodyLarge?.copyWith(
    fontWeight: FontAsset.semiBold,
    fontSize: Dimensions.sp18,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleRegularDarkBlue14 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.regular,
    fontSize: Dimensions.sp14,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleRegularDarkBlue16 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.regular,
    fontSize: Dimensions.sp16,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleMediumDarkBlue14 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.medium,
    fontSize: Dimensions.sp14,
    color: ColorConst.textDarkBlueColor,
  );

  TextStyle? get fontStyleMediumDarkBlue =>
      Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textDarkBlueColor);

  TextStyle? get fontStyleMediumRed32 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.medium,
    fontSize: Dimensions.sp32,
    color: ColorConst.textGradientRedColor,
  );

  TextStyle? get fontStyleMediumRed22 => Theme.of(this).textTheme.bodyMedium?.copyWith(
    fontWeight: FontAsset.medium,
    fontSize: Dimensions.sp22,
    color: ColorConst.textGradientRedColor,
  );

  TextStyle? get fontStyleSemiBold10 => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.semiBold);

  TextStyle? get fontStyleSemiBold11 =>
      Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.semiBold, fontSize: Dimensions.sp11);

  TextStyle? get fontStyleSemiBold12 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.semiBold);

  TextStyle? get fontStyleSemiBold14 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.semiBold);

  TextStyle? get fontStyleSemiBold14White =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.semiBold, color: ColorConst.whiteColor);

  TextStyle? get fontStyleSemiBold16 =>
      Theme.of(this).textTheme.headlineMedium?.copyWith(fontWeight: FontAsset.semiBold);

  TextStyle? get fontStyleSemiBold15 =>
      Theme.of(this).textTheme.headlineMedium?.copyWith(fontWeight: FontAsset.semiBold, fontSize: Dimensions.sp15);

  TextStyle? get fontStyleSemiBold20 =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.semiBold, fontSize: Dimensions.sp20);

  TextStyle? get fontStyleSemiBold22 =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.semiBold, fontSize: Dimensions.sp22);

  TextStyle? get fontStyleSemiBold22White => Theme.of(this).textTheme.bodyLarge?.copyWith(
    fontWeight: FontAsset.semiBold,
    fontSize: Dimensions.sp22,
    color: ColorConst.whiteColor,
  );

  TextStyle? get fontStyleSemiBold18 =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.semiBold, fontSize: Dimensions.sp18);

  TextStyle? get fontStyleRegular10 => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.regular);

  TextStyle? get fontStyleRegular12 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.regular);

  TextStyle? get fontStyleRegular14 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.regular);

  TextStyle? get fontStyleMedium10 => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.medium);

  TextStyle? get fontStyleMedium12 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.medium);

  TextStyle? get fontStyleMedium14 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium);

  TextStyle? get fontStyleMedium14Red =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textRedColor);

  TextStyle? get fontStyleMedium13 =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium, fontSize: Dimensions.sp13);

  TextStyle? get fontStyleMedium16 => Theme.of(this).textTheme.headlineMedium?.copyWith(fontWeight: FontAsset.medium);

  TextStyle? get fontStyleMedium10Grey =>
      Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textGreyColor);

  TextStyle? get fontStyleMedium12Grey =>
      Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textGreyColor);

  TextStyle? get fontStyleMedium14Grey =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textGreyColor);

  TextStyle? get fontStyleMedium14GreyAppbar =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textGreyColor2);

  TextStyle? get fontStyleMedium16Grey => Theme.of(this).textTheme.bodyLarge?.copyWith(
    fontWeight: FontAsset.medium,
    color: ColorConst.textGreyColor,
    fontSize: Dimensions.sp16,
  );

  TextStyle? get fontStyleMedium14Hint =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.medium, color: ColorConst.textHintColor);

  TextStyle? get fontStyleBold10 => Theme.of(this).textTheme.bodySmall?.copyWith(fontWeight: FontAsset.bold);

  TextStyle? get fontStyleBold12 => Theme.of(this).textTheme.bodyMedium?.copyWith(fontWeight: FontAsset.bold);

  TextStyle? get fontStyleBold14 => Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.bold);

  TextStyle? get fontStyleBold16 =>
      Theme.of(this).textTheme.bodyLarge?.copyWith(fontWeight: FontAsset.bold, fontSize: Dimensions.sp16);


  // TextStyle? get pButton => Theme.of(this).primaryTextTheme.button;

  Color? get containerColor => Theme.of(this).colorScheme.primaryContainer;
}

extension GradientExtensions on List<Color> {
  LinearGradient get scrollBarGradient =>
      LinearGradient(colors: [last, first, last], begin: Alignment.bottomCenter, end: Alignment.topCenter);
}

extension GradientExtension on BuildContext {
  LinearGradient get commonGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ColorConst.textGradientYellowColor,
      ColorConst.primaryColor,
      ColorConst.primaryColor,
      ColorConst.primaryColor,
      ColorConst.primaryColor,
      ColorConst.primaryColor,
    ],
  );

  RadialGradient get morningQuotesGradient => RadialGradient(
    colors: [ColorConst.textGradientYellowColor, ColorConst.textGradientOrangeColor],
    stops: [0.1, 0.5],
    center: Alignment(0.5, 0.0),
    radius: 2.0,
    tileMode: TileMode.clamp,
  );

  RadialGradient get afternoonQuotesGradient => RadialGradient(
    colors: [ColorConst.textGradientYellowColor, ColorConst.textGradientGreenColor],
    stops: [0.1, 0.5],
    center: Alignment(0.5, 0.0),
    // radius: 2.5,
    radius: 2.0,
    tileMode: TileMode.clamp,
  );

  RadialGradient get eveningQuotesGradient => RadialGradient(
    colors: [ColorConst.primaryColor, ColorConst.textGradientBlueColor],
    stops: [0.1, 0.5],
    center: Alignment(0.5, 0.0),
    // radius: 2.3,
    radius: 2.0,
    tileMode: TileMode.clamp,
  );
}

extension SystemUIExtension on BuildContext {
  SystemUiOverlayStyle get darkSystemUIStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  );

  SystemUiOverlayStyle get lightSystemUIStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );
}

extension TimeFormattingExtension on TimeOfDay {
  String formatTimeOfDay({String pattern = 'h:mm a'}) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(pattern).format(dateTime);
  }
}

extension AnimationExtensions on Widget {
  Widget slideFromBottom({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
  }) {
    final animation = Tween<Offset>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(position: animation, child: this);
  }

  Widget slideFromTop({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
  }) {
    final animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(position: animation, child: this);
  }

  Widget slideFromLeft({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
  }) {
    final animation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(position: animation, child: this);
  }

  Widget slideFromRight({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
  }) {
    final animation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(position: animation, child: this);
  }

  Widget fadeIn({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeIn,
    double begin = 0.0,
    double end = 1.0,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return FadeTransition(opacity: animation, child: this);
  }

  Widget fadeOut({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
    double begin = 0.0,
    double end = 1.0,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return FadeTransition(opacity: animation, child: this);
  }

  Widget scaleIn({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.elasticOut,
    double begin = 0.0,
    double end = 1.0,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return ScaleTransition(scale: animation, child: this);
  }

  Widget rotateIn({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve curve = Curves.easeOut,
    double begin = 0.0,
    double end = 1.0,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return RotationTransition(turns: animation, child: this);
  }

  Widget slideAndFade({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 800),
    Curve slideCurve = Curves.easeOut,
    Curve fadeCurve = Curves.easeIn,
    Offset slideBegin = const Offset(0, 1),
    Offset slideEnd = Offset.zero,
    double fadeBegin = 0.0,
    double fadeEnd = 1.0,
  }) {
    final slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: slideEnd,
    ).animate(CurvedAnimation(parent: controller, curve: slideCurve));

    final fadeAnimation = Tween<double>(
      begin: fadeBegin,
      end: fadeEnd,
    ).animate(CurvedAnimation(parent: controller, curve: fadeCurve));

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: this),
    );
  }

  Widget bounceIn({
    required AnimationController controller,
    Duration duration = const Duration(milliseconds: 1200),
    Curve curve = Curves.bounceOut,
  }) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));

    return ScaleTransition(scale: animation, child: this);
  }

  // ✅ NEW: Pulse animation (grow/shrink continuously)
  Widget pulse({required AnimationController controller, Curve curve = Curves.easeInOut}) {
    final scale = Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(parent: controller, curve: curve));
    return ScaleTransition(scale: scale, child: this);
  }

  // ✅ NEW: Flash (repeated fade in/out)
  Widget flash({required AnimationController controller, Curve curve = Curves.linear}) {
    final opacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: controller, curve: curve));

    return FadeTransition(opacity: opacity, child: this);
  }

  // ✅ NEW: Fade + Slide Up
  Widget fadeSlideUp({required AnimationController controller, Curve curve = Curves.easeOut}) {
    final offsetAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    final fadeAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(
      position: offsetAnim,
      child: FadeTransition(opacity: fadeAnim, child: this),
    );
  }

  // ✅ NEW: Fade + Slide Down
  Widget fadeSlideDown({required AnimationController controller, Curve curve = Curves.easeOut}) {
    final offsetAnim = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    final fadeAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: curve));

    return SlideTransition(
      position: offsetAnim,
      child: FadeTransition(opacity: fadeAnim, child: this),
    );
  }

  // ✅ NEW: Hover effect (grow on hover/tap)
  Widget hoverIn({
    required AnimationController controller,
    Curve curve = Curves.easeInOut,
    double begin = 1.0,
    double end = 1.05,
  }) {
    final animation = Tween<double>(begin: begin, end: end).animate(CurvedAnimation(parent: controller, curve: curve));

    return ScaleTransition(scale: animation, child: this);
  }

  // ✅ NEW: Pop-in (zoom with bounce)
  Widget popIn({required AnimationController controller, Curve curve = Curves.bounceOut}) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));
    return ScaleTransition(scale: animation, child: this);
  }

  // ✅ NEW: Drop In from top with bounce
  Widget dropIn({required AnimationController controller, Curve curve = Curves.bounceOut}) {
    final offset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
    return SlideTransition(position: offset, child: this);
  }

  // ✅ NEW: Scale + Rotate together
  Widget scaleRotate({required AnimationController controller, Curve curve = Curves.easeInOut}) {
    final scale = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));
    final rotate = Tween<double>(begin: -0.5, end: 0.0).animate(CurvedAnimation(parent: controller, curve: curve));
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scale.value,
          child: Transform.rotate(angle: rotate.value, child: this),
        );
      },
    );
  }

  // ✅ Heartbeat (continuous bounce)
  Widget heartbeat({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(scale: animation.value, child: this);
      },
    );
  }

  // ✅ Rotate once (icon only)
  Widget rotateOnce({required AnimationController controller, Curve curve = Curves.easeOut}) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(angle: animation.value * 2 * 3.1416, child: this);
      },
    );
  }

  Widget spiralEffect({
    required AnimationController controller,
    double rotationMultiplier = 1.0,
    double opacityMin = 0.3,
    double opacityMax = 1.0,
  }) {
    final Animation<double> spiralAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic));

    return AnimatedBuilder(
      animation: spiralAnimation,
      builder: (context, child) {
        final double progress = spiralAnimation.value / (2 * pi);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(spiralAnimation.value * 0.1 * rotationMultiplier)
            ..rotateY(spiralAnimation.value * 0.1 * rotationMultiplier)
            ..rotateZ(spiralAnimation.value * 0.05 * rotationMultiplier),
          child: Opacity(opacity: (progress.clamp(opacityMin, opacityMax)), child: this),
        );
      },
    );
  }

  Widget instagramZoom({
    required AnimationController controller,
    double minScale = 1.0,
    double maxScale = 1.3,
    Curve curve = Curves.easeInBack,
  }) {
    final Animation<double> zoomAnimation = Tween<double>(
      begin: minScale,
      end: maxScale,
    ).animate(CurvedAnimation(parent: controller, curve: curve));

    return AnimatedBuilder(
      animation: zoomAnimation,
      builder: (context, child) {
        return Transform.scale(scale: zoomAnimation.value, child: this);
      },
    );
  }

  // Shake animation
  Widget shake({required AnimationController controller}) {
    final animation = Tween<double>(begin: 0, end: 8).chain(CurveTween(curve: Curves.elasticIn)).animate(controller);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(sin(animation.value) * 5, 0), child: this);
      },
    );
  }

  // Flip Y-axis
  Widget flipY({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(alignment: Alignment.center, transform: Matrix4.rotationY(animation.value), child: this);
      },
    );
  }

  // Flip X-axis
  Widget flipX({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(alignment: Alignment.center, transform: Matrix4.rotationX(animation.value), child: this);
      },
    );
  }

  // Jelly effect
  Widget jelly({required AnimationController controller}) {
    final scale = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 0.9, end: 1.05), weight: 20),
      TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.scale(scale: scale.value, child: this),
    );
  }

  // Fade + scale
  Widget fadeScale({required AnimationController controller, Curve curve = Curves.easeOutBack}) {
    final scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));
    final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: curve));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.scale(scale: scale.value, child: this),
        );
      },
    );
  }

  // Wobble
  Widget wobble({required AnimationController controller}) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final angle = sin(progress * pi * 4) * 0.1;
        final offset = Offset(sin(progress * pi * 4) * 5, 0);

        return Transform.translate(
          offset: offset,
          child: Transform.rotate(angle: angle, child: this),
        );
      },
    );
  }

  // Stretch X
  Widget stretchX({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.scale(scaleX: animation.value, scaleY: 1.0, child: this),
    );
  }

  // Stretch Y
  Widget stretchY({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.scale(scaleX: 1.0, scaleY: animation.value, child: this),
    );
  }

  Widget bounceY({required AnimationController controller}) {
    final Animation<double> animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0).chain(CurveTween(curve: Curves.easeOut)), weight: 25),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0).chain(CurveTween(curve: Curves.bounceOut)), weight: 25),
      // TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0).chain(CurveTween(curve: Curves.easeOut)), weight: 25),
      // TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0).chain(CurveTween(curve: Curves.bounceOut)), weight: 25),
    ]).animate(controller);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, animation.value), child: child);
      },
      child: this,
    );
  }

  Widget crackers({required AnimationController controller}) {
    final scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 0.9).chain(CurveTween(curve: Curves.easeInOut)), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)), weight: 40),
    ]).animate(controller);

    final rotationAnimation = Tween(
      begin: 0.0,
      end: 0.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: Transform.scale(scale: scaleAnimation.value, child: child),
        );
      },
      child: this,
    );
  }

  Widget popBounce({required AnimationController controller}) {
    final animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)), weight: 50),
    ]).animate(controller);

    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Transform.scale(scale: animation.value, child: child),
      child: this,
    );
  }

  /// Pop + pulse combo when a favourite is tapped
  Widget popFavourite({required AnimationController controller}) {
    final scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.6), weight: 0.4),
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 0.9), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 0.3),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    return AnimatedBuilder(
      animation: scale,
      builder: (_, child) => Transform.scale(scale: scale.value, child: child),
      child: this,
    );
  }

  /// Twinkle Star (for star-like favourites)
  Widget twinkle({required AnimationController controller}) {
    final scale = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 0.8), weight: 0.3),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 0.4),
    ]).animate(controller);
    final rotate = Tween<double>(begin: 0.0, end: math.pi / 12).animate(controller);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: rotate.value,
          child: Transform.scale(scale: scale.value, child: child),
        );
      },
      child: this,
    );
  }

  /// Favourite flicker – subtle shake and opacity blink
  Widget favouriteFlicker({required AnimationController controller}) {
    final shake = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: -5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -5.0, end: 5.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 5.0, end: 0.0), weight: 1),
    ]).animate(controller);

    final opacity = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Opacity(
        opacity: opacity.value,
        child: Transform.translate(offset: Offset(shake.value, 0), child: child),
      ),
      child: this,
    );
  }

  // Blinking effect
  Widget blink({required AnimationController controller}) {
    final animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    return FadeTransition(opacity: animation, child: this);
  }

  /// Radiant burst – scale + glow ring around the icon
  Widget radiantBurst({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 0.8,
      end: 1.4,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    final opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Container(
              width: 48 * scale.value,
              height: 48 * scale.value,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellowAccent.withOpacity(opacity.value)),
            );
          },
        ),
        this,
      ],
    );
  }

  /// Firecracker scale + rotation burst
  Widget crackleBurst({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 0.5,
      end: 1.4,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    final rotation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: rotation.value * math.pi,
          child: Transform.scale(scale: scale.value, child: child),
        );
      },
      child: this,
    );
  }

  /// Favourite sparkle particles (wrap this in a Stack)
  Widget sparkleParticles({required AnimationController controller, Color color = Colors.amber}) {
    final size = Tween<double>(begin: 0.0, end: 30.0).animate(controller);
    final opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    return Stack(
      children: List.generate(6, (index) {
        final angle = index * math.pi / 3;
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final dx = size.value * math.cos(angle);
            final dy = size.value * math.sin(angle);
            return Positioned(
              left: 24.0 + dx,
              top: 24.0 + dy,
              child: Opacity(
                opacity: opacity.value,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Firework scale & glow effect (bursting out)
  Widget fireworkBurst({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 0.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    final opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Interval(0.3, 1.0)));

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scale.value,
          child: Opacity(opacity: opacity.value, child: child),
        );
      },
      child: this,
    );
  }

  // Pulse glow (icon breathes light)
  Widget glowPulse({required AnimationController controller}) {
    final colorTween = ColorTween(begin: Colors.transparent, end: Colors.yellowAccent.withOpacity(0.5));
    final animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorTween.evaluate(animation) ?? Colors.transparent,
                blurRadius: 16.0,
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: child,
        );
      },
      child: this,
    );
  }

  /// 💫 Rotate Ping – rotates slightly and scales
  Widget rotatePing({required AnimationController controller}) {
    final rotate = Tween<double>(
      begin: 0.0,
      end: math.pi * 2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    final scale = Tween<double>(begin: 0.8, end: 1.2).animate(controller);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: rotate.value,
          child: Transform.scale(scale: scale.value, child: child),
        );
      },
      child: this,
    );
  }

  /// 🔥 Fireburst scale + opacity burst
  Widget fireburst({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 0.5,
      end: 2.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    final opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return Transform.scale(
              scale: scale.value,
              child: Opacity(
                opacity: opacity.value,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [Color(0xffF8DD5B), Color(0xffFAA41E)]),
                  ),
                ),
              ),
            );
          },
        ),
        this,
      ],
    );
  }

  /// 🎉 Favourite bounce with subtle side shake
  Widget bounceWiggle({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    final wiggle = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 4.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: -4.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0), weight: 1),
    ]).animate(controller);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(wiggle.value, 0),
          child: Transform.scale(scale: scale.value, child: child),
        );
      },
      child: this,
    );
  }

  /// ✨ Sparkle pulse – glow pulse loop
  Widget sparklePulse({required AnimationController controller}) {
    final glow = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Transform.scale(scale: glow.value, child: child),
      child: this,
    );
  }

  /// 📸 Bounce Flash – like an instant snapshot flash
  Widget bounceFlash({required AnimationController controller}) {
    final scale = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutExpo));
    final fade = Tween<double>(begin: 1.0, end: 0.3).animate(controller);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.scale(
          scale: scale.value,
          child: Opacity(opacity: fade.value, child: child),
        );
      },
      child: this,
    );
  }

  /// ❤️‍🔥 Pulse Glow – good for liked or hearted state
  Widget pulseGlow({required AnimationController controller}) {
    final pulse = Tween<double>(
      begin: 1.0,
      end: 1.25,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.pinkAccent.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)],
        ),
        child: Transform.scale(scale: pulse.value, child: child),
      ),
      child: this,
    );
  }
}
