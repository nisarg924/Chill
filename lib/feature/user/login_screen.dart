import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/utils/style.dart';
import 'package:social_app/core/widgets/bottom_nav_bar.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/core/widgets/textfields/login_textfield.dart';
import 'package:social_app/feature/user/connect_to_friends_screen.dart';
import 'cubit/sign_up_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                Text("Login with Email",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
                ).animate().fade(duration: 400.ms),
                verticalHeight(Dimensions.h24),

                  LoginTextfield(
                    controller: _emailController,
                    labelText: "Email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
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
                  onTap: loginEmail,
                  text: "Login",
                  elevation: 0,
                ).animate().fade().slideY(duration: 500.ms),
                verticalHeight(Dimensions.h16),
                const Text("OR", style: TextStyle(fontWeight: FontWeight.w500)),
                verticalHeight(Dimensions.h16),
                ElevatedButton.icon(
                  onPressed: googleSignIn,
                  icon: Image.asset(AppImage.icGoogleLogo, width: Dimensions.w24, height: Dimensions.h24),
                  label: Text("Sign in with Google", style: fontStyleMedium16),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    elevation: 2,
                  ),
                ).animate().fade().scale(duration: 500.ms),
                verticalHeight(Dimensions.h30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style:fontStyleRegular16),
                    horizontalWidth(Dimensions.w5),
                    GestureDetector(
                      onTap: goToSignUp,
                      child: Text(
                        "Sign up",
                        style: fontStyleRegular16.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loginEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    if(auth.currentUser!=null){
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
        final collection = 'users';
        FirebaseFirestore.instance.collection(collection).add(data);
      }
     await navigateToPage(BottomNavBar());
    }
  }
  void goToSignUp(){
    navigateToPage(ConnectToFriendsScreen());
  }

  Future<void> googleSignIn() async {
    final cubit = GoogleAuthCubit(); // or get it from context
    await cubit.signInWithGoogle();

    if (FirebaseAuth.instance.currentUser != null && context.mounted) {
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
      }
      navigateToPage(BottomNavBar());
    }
  }

  // Future<void> _sendOTP() async {
  //   final phone = _phoneController.text.trim();
  //   if (phone.isEmpty) {
  //     Const.toastFail("Please enter a valid phone number");
  //     return;
  //   }
  //
  //   final fullPhone = '$countryCode$phone';
  //
  //   try {
  //     await _phoneAuthCubit.sendOtp(fullPhone);
  //
  //     if (!mounted) return;
  //     navigateToPage( BlocProvider.value(
  //       value: _phoneAuthCubit, // ✅ re-use same cubit instance
  //       child: const OtpVerificationScreen(),
  //     ),
  //     );
  //   } catch (e) {
  //     Const.toastFail("Something went wrong");
  //   }
  // }

}
