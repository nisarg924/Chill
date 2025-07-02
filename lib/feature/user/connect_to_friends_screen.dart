import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/app_string.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/utils/style.dart';
import 'package:social_app/core/widgets/bottom_nav_bar.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/feature/user/phone_login.dart';
import 'package:social_app/feature/user/sign_up_email_screen.dart';

import 'cubit/sign_up_cubit.dart';
import 'login_screen.dart';

class ConnectToFriendsScreen extends StatefulWidget {
  const ConnectToFriendsScreen({super.key});

  @override
  State<ConnectToFriendsScreen> createState() => _ConnectToFriendsScreenState();
}

class _ConnectToFriendsScreenState extends State<ConnectToFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //top board image
        topImage(),
        //content
        bottomPositionedContent(),
      ]),
    );
  }

  Widget topImage() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          AppImage.icIntroBg,
          width: double.infinity,
        ));
  }

  Widget bottomPositionedContent() {
    return Positioned(
      left: 0,
      right: 0,
      top: Dimensions.h320,
      bottom: Dimensions.h20,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w20,
        ),
        child: SingleChildScrollView(child: contentBelowImage()),
      ),
    );
  }

  Widget contentBelowImage() {
    return Column(
      children: [
        //title text
        Text(AppString.connectWithFriends, style: fontStyleBold32,),
        verticalHeight(Dimensions.h16),

        //subtitle text
        Text(AppString.shareYourMoments, style: fontStyleRegular16,),
        verticalHeight(Dimensions.h16),

        //account signup methods
        LoginButton(onTap: goToSignUpWithEmailScreen, text: AppString.signUpWithEmail),
        verticalHeight(Dimensions.h12),
        LoginButton(onTap: googleSignIn, text: AppString.continueWithGoogle),
        verticalHeight(Dimensions.h20),

        //already have an account login button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppString.alreadyHaveAnAccount,style: fontStyleRegular16),
            horizontalWidth(Dimensions.w5),
            GestureDetector(
              onTap: goToLogin,
              child: Text(
                AppString.login,
                style: fontStyleRegular16.copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void goToSignUpWithEmailScreen() {
    navigateToPage(SignUpEmailScreen());
  }

  void goToSignUpWithPhoneScreen() {
    navigateToPage(PhoneLogin());
  }

  Future<void> googleSignIn() async {
    final cubit = GoogleAuthCubit(); // or get it from context
    await cubit.signInWithGoogle();

    if (FirebaseAuth.instance.currentUser != null && context.mounted) {
      final data =<String ,dynamic>{
        'username': FirebaseAuth.instance.currentUser!.displayName??"user",
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'email': FirebaseAuth.instance.currentUser!.email??"",
        'profileImageUrl': FirebaseAuth.instance.currentUser!.photoURL??"",
        'bio': '',
        'followers': [],
        'following': [],
      };
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(data, SetOptions(merge: true));
      navigateToPage(BottomNavBar());
    }
  }

  void goToLogin() {
    navigateToPage(LoginScreen());
  }
}
