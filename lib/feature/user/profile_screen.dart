import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/utils/style.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/core/widgets/follower_box.dart';
import 'package:social_app/feature/settings/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final activeUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: fontStyleBold18),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: (){},
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(onPressed: () {navigateToPage(SettingScreen());}, icon: Icon(Icons.settings)),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.h10,
              horizontal: Dimensions.h20,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        "${activeUser.photoURL}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.account_circle, size: 100),
                      ),
                    ),
                  ),
                  verticalHeight(Dimensions.h12),
                  Center(child: Text(activeUser.displayName ?? "User", style: fontStyleBold22)),
                  verticalHeight(Dimensions.h5),
                  Center(child: Text("Software Engineer")),
                  verticalHeight(Dimensions.h5),
                  Center(child: Text("Joined in 2021")),
                  verticalHeight(Dimensions.h20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FollowerBox(upperNumberText: "120", belowText: "Post"),
                      FollowerBox(upperNumberText: "120", belowText: "Followers"),
                      FollowerBox(upperNumberText: "120", belowText: "Following"),
                    ],
                  ),
                  verticalHeight(Dimensions.h20),
                  Row(
                    children: [
                      Expanded(child: LoginButton(onTap: () {}, text: "Edit Profile")),
                      horizontalWidth(Dimensions.w10),
                      Expanded(child: LoginButton(onTap: () {}, text: "Share Profile")),
                    ],
                  ),
                  verticalHeight(Dimensions.h20),
                ],
              ),
            ),
          ),

          // Sticky Post/Story Row
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text("Post", style: fontStyleMedium16.copyWith(color: Colors.blue)), Text("Story")],
                    ),
                    Divider(
                      color: Colors.grey,
                      height: Dimensions.h8,
                    ),
                  ],
                ),
              ),
              height: Dimensions.h40,
            ),
          ),

          // GridView (SliverGrid)
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.h20, vertical: 0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: Dimensions.h8,
              crossAxisSpacing: Dimensions.w8,
              children: List.generate(
                30,
                (index) => Image.asset(AppImage.icAppLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Delegate for Sticky Header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
