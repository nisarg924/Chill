import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/feature/user/login_screen.dart';

import '../../core/utils/style.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting", style: fontStyleBold18),
        centerTitle: true,  ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Log Out"),
            IconButton(onPressed: () async {
              FirebaseAuth.instance.signOut();
              final GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              await navigateToPage(LoginScreen());
              Const.toastSuccess("Successfully Logged Out.");
            }, icon: Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }
}
