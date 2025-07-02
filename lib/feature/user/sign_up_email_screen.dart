import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/widgets/bottom_nav_bar.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/core/widgets/textfields/login_textfield.dart';

import 'cubit/sign_up_cubit.dart';

class SignUpEmailScreen extends StatefulWidget {
  const SignUpEmailScreen({super.key});

  @override
  State<SignUpEmailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpEmailScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  final SignUpWithEmailPassword signUpEmailCubit = SignUpWithEmailPassword();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.icAppLogo,
                  width: Dimensions.w80,
                  height: Dimensions.h80,
                ).animate().fadeIn(begin: 0, duration: Duration(milliseconds: 500)),
                verticalHeight(Dimensions.h24),
                Text(
                  "SignUp with Email",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
                ).animate().fade(duration: 400.ms),
                verticalHeight(Dimensions.h24),
                LoginTextfield(
                  controller: _emailController,
                  labelText: "Email",
                  prefixIcon: Icons.email_outlined,
                  autofillHints: [AutofillHints.email],
                ),
                verticalHeight(Dimensions.h16),
                LoginTextfield(
                  controller: _passwordController,
                  labelText: "Password",
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
                verticalHeight(Dimensions.h24),
                LoginButton(
                  onTap: _sigUpEmailPassword,
                  text: "Sign Up",
                  elevation: 0,
                ).animate().fade().slideY(duration: 500.ms),
                verticalHeight(Dimensions.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sigUpEmailPassword() async {
    try {
      await signUpEmailCubit.signUpWithEmail(_emailController.text, _passwordController.text);
      if (FirebaseAuth.instance.currentUser != null && context.mounted) {
        final data = <String, dynamic>{
          'username': FirebaseAuth.instance.currentUser!.displayName ?? "user",
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'email': FirebaseAuth.instance.currentUser!.email ?? "",
          'profileImageUrl': FirebaseAuth.instance.currentUser!.photoURL ?? "",
          'bio': '',
          'followers': [],
          'following': [],
        };
        final uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(data, SetOptions(merge: true));
        await navigateToPage(BottomNavBar());
      }
    } on Exception catch (e) {
      Const.toastFail("Something went wrong");
    }
  }
}
