import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/feature/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_color.dart';
import '../constants/app_image.dart';
import '../constants/const.dart';
import '../constants/dimensions.dart';
import '../utils/navigation_manager.dart';
import 'custom_button/round_button.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key,this.onTap});
  final String url = 'https://purepositive.com/';
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: AppColors.transparentColor),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparentColor,
      leadingWidth: Dimensions.w60,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Row(
        children: [
          horizontalWidth(Dimensions.w20),
          RoundButton(onTap: _launchURL,image: AppImage.icAppLogo,bgColor: AppColors.whiteColor,bgHeight: Dimensions.h40,bgWidth: Dimensions.w40, imageHeight: Dimensions.h32,imageWidth: Dimensions.w28,isPadding: true),
        ],
      ),
      actions: [
        RoundButton(onTap: onTap??()=>goToSettings(context),image:AppImage.icAppLogo,bgColor:AppColors.redTextColor,bgHeight: Dimensions.h40,bgWidth: Dimensions.w40 ,imageHeight: Dimensions.h24,imageWidth: Dimensions.w24,isPadding: true),
        horizontalWidth(Dimensions.h20),
      ],
    );
  }
  Future<void> goToSettings(BuildContext context) async{
    await navigateWithAnimation(context, HomeScreen());
  }

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);

    if (Platform.isAndroid) {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication,)) {
        throw 'Could not launch $url';
      }
    } else if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
