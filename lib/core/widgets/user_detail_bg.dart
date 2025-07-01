import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/core/widgets/top_number_line_bar.dart';

import '../constants/app_color.dart';
import '../constants/app_string.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';
import 'intro_container.dart';

class UserDetailBg extends StatefulWidget {
  const UserDetailBg({
    super.key,
    required this.image,
    this.imageHeight,
    this.imageWidth,
    required this.children,
    this.appBarAlignment,
    this.appBarText,
    this.isLastSetUpScreen,
    this.isMiddleSetUpScreen,
    this.titleText,
    this.bodyAlignment,
  });

  final String image;
  final double? imageHeight;
  final double? imageWidth;
  final List<Widget> children;
  final MainAxisAlignment? appBarAlignment;
  final MainAxisAlignment? bodyAlignment;
  final String? appBarText;
  final String? titleText;
  final bool? isLastSetUpScreen;
  final bool? isMiddleSetUpScreen;

  @override
  State<UserDetailBg> createState() => _UserDetailBgState();
}

class _UserDetailBgState extends State<UserDetailBg> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> isScrolled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset > 20 && !isScrolled.value) {
        isScrolled.value = true;
      } else if (offset <= 20 && isScrolled.value) {
        isScrolled.value = false;
      }
    });
  }

  @override
  void dispose() {
    isScrolled.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.h14),
          child: Text(
            widget.titleText ?? AppString.login,
            style: fontStyleMedium14.copyWith(color: AppColors.blueTextColor),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColors.transparentColor,
        ),
        titleSpacing: 0,
        title: TopNumberLineBar(
          axisAlignment: widget.appBarAlignment ?? MainAxisAlignment.end,
          text: widget.appBarText ?? AppString.login,
          isLast: widget.isLastSetUpScreen ?? false,
          isMiddle: widget.isMiddleSetUpScreen ?? true,
        ),
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: Dimensions.h70,
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isScrolled,
        builder: (context, scrolled, _) {
          return GradientContainer(
            isNameIntroScreen: !(widget.isLastSetUpScreen ?? true),
            image: widget.image,
            imageHeight: widget.imageHeight,
            imageWidth: widget.imageWidth,
            colors: [
              scrolled
                  ? AppColors.darkYellowGradientColor
                  : AppColors.yellowGradientColor,
              AppColors.yellowGradientColor.withAlpha(0),
              AppColors.lightYellowGradientColor.withAlpha(0),
            ],
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w4,
                vertical: Dimensions.h50,
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                  widget.bodyAlignment ?? MainAxisAlignment.center,
                  children: widget.children,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

