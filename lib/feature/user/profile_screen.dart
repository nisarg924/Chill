import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/utils/style.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/core/widgets/follower_box.dart';
import 'package:social_app/feature/settings/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;
  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String _uid;
  bool _showPosts = true;

  @override
  void initState() {
    super.initState();
    _uid = widget.userId ?? FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: fontStyleBold18),
        centerTitle: true,
        elevation: 0,automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => navigateToPage(SettingScreen()),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(_uid).get(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());

          final data = snap.data!.data() as Map<String, dynamic>;
          final username = data['username'] as String? ?? 'User';
          final photoUrl = data['profileImageUrl'] as String?;
          final bio = data['bio'] as String? ?? '';
          final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
          final joined = createdAt != null ? 'Joined in ${createdAt.year}' : '';
          final followers = List.from(data['followers'] ?? []);
          final following = List.from(data['following'] ?? []);

          return CustomScrollView(
            slivers: [
              // Profile Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.h20, vertical: Dimensions.h10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                            ? NetworkImage(photoUrl)
                            : null,
                        child: photoUrl == null ? const Icon(Icons.account_circle, size: 100) : null,
                      ),
                      SizedBox(height: Dimensions.h12),
                      Text(username, style: fontStyleBold22),
                      if (bio.isNotEmpty) ...[
                        SizedBox(height: Dimensions.h5),
                        Text(bio, textAlign: TextAlign.center),
                      ],
                      if (joined.isNotEmpty) ...[
                        SizedBox(height: Dimensions.h5),
                        Text(joined),
                      ],
                      SizedBox(height: Dimensions.h20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FollowerBox(upperNumberText: '0', belowText: 'Posts'),
                          FollowerBox(upperNumberText: '${followers.length}', belowText: 'Followers'),
                          FollowerBox(upperNumberText: '${following.length}', belowText: 'Following'),
                        ],
                      ),
                      SizedBox(height: Dimensions.h20),
                      Row(
                        children: [
                          Expanded(
                            child: LoginButton(
                              text: widget.userId == null ? 'Edit Profile' : 'Follow',
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: Dimensions.w10),
                          Expanded(
                            child: LoginButton(
                              text: 'Share Profile',
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h20),
                    ],
                  ),
                ),
              ),

              // Toggle Tab
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  height: Dimensions.h40,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _showPosts = true),
                          child: Text('Posts',
                              style: fontStyleMedium16.copyWith(
                                  color: _showPosts ? Colors.blue : Colors.grey)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _showPosts = false),
                          child: Text('Stories',
                              style: fontStyleMedium16.copyWith(
                                  color: !_showPosts ? Colors.blue : Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Posts Grid
              if (_showPosts)
                SliverToBoxAdapter(
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('userId', isEqualTo: _uid)
                        .orderBy('createdAt', descending: true)
                        .limit(30)
                        .get(),
                    builder: (context, snap) {
                      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                      final docs = snap.data!.docs;
                      if (docs.isEmpty) return const Center(child: Text('No posts'));

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.h20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: Dimensions.h8,
                          crossAxisSpacing: Dimensions.w8,
                          childAspectRatio: 1,
                        ),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final post = docs[index].data() as Map<String, dynamic>;
                          return Image.network(
                            post['imageUrl'] ?? AppImage.icAppLogo,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                          );
                        },
                      );
                    },
                  ),
                )
              else
              // Stories List
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 110,
                    child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('stories')
                          .where('userId', isEqualTo: _uid)
                          .orderBy('createdAt', descending: true)
                          .get(),
                      builder: (context, snap) {
                        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                        final docs = snap.data!.docs;
                        if (docs.isEmpty) return const Center(child: Text('No stories'));

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final story = docs[index].data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: Dimensions.r30,
                                    backgroundImage: NetworkImage(story['imageUrl'] ?? ''),
                                  ),
                                  SizedBox(height: Dimensions.h6),
                                  const Text('Story'),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _StickyHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: height, child: child); // Fix SliverGeometry issue
  }

  @override
  double get maxExtent => height;
  @override
  double get minExtent => height;
  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate old) => false;
}
