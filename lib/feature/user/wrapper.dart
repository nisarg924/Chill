import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/feature/user/connect_to_friends_screen.dart';

import '../../core/widgets/bottom_nav_bar.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
   Stream<User?> stream = FirebaseAuth.instance.authStateChanges();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: stream, builder: (context, snapshot){
      if(snapshot.hasData){
        return BottomNavBar();
      }
      else{
        return ConnectToFriendsScreen();
      }
    });
  }
}
