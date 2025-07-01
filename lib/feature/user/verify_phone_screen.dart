import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/widgets/bottom_nav_bar.dart';

import 'cubit/sign_up_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneAuthCubit>();
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        border: Border.all(color: Colors.teal.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter the 6-digit OTP sent to your phone",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Pinput(
              controller: _otpController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              keyboardType: TextInputType.number,
              onCompleted: (pin) async {
                await cubit.verifyOtp(pin);
                if (mounted && FirebaseAuth.instance.currentUser != null) {
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
                    await navigateToPage(const BottomNavBar());
                  }
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await cubit.verifyOtp(_otpController.text.trim());
                if (mounted && FirebaseAuth.instance.currentUser != null) {
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
                    await navigateToPage(const BottomNavBar());
                  }
                }
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
