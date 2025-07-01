import 'package:flutter/material.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/style.dart';

import '../../core/constants/app_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text('Chill'),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // Top horizontal avatars
            SliverToBoxAdapter(
              child: SizedBox(
                height: Dimensions.h110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:  EdgeInsets.symmetric(horizontal: Dimensions.w10 ),
                  children: const [
                    _StoryItem(name: 'Sophia', image: AppImage.icStoryImage),
                    _StoryItem(name: 'Ethan', image: AppImage.icStoryImage),
                    _StoryItem(name: 'Olivia', image: AppImage.icStoryImage),
                    _StoryItem(name: 'Noah', image: AppImage.icStoryImage),
                    _StoryItem(name: 'Ava', image: AppImage.icStoryImage),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w16),
              sliver: SliverList(delegate: SliverChildBuilderDelegate(childCount: 10,(context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post header
                    Row(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.r20,
                          backgroundImage: AssetImage(AppImage.icStoryImage),
                        ),
                        horizontalWidth(Dimensions.w14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Liam Carter',
                                style: fontStyleMedium16,
                              ),
                              verticalHeight(Dimensions.h5),
                              Text(
                                '2d',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Post text
                    Text(
                      'Enjoying a beautiful day at the park with friends! #parklife #goodtimes',
                      style: fontStyleRegular16,
                    ),
                    verticalHeight(Dimensions.h12),
                    // Post image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.r8),
                      child: Image.asset(
                        AppImage.icIntroBg,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: Dimensions.h200,
                      ),
                    ),
                    verticalHeight(Dimensions.h12),
                    // Post actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _PostAction(icon: Icons.favorite_border, count: 23),
                        _PostAction(icon: Icons.chat_bubble_outline, count: 5),
                        _PostAction(icon: Icons.send, count: 2),
                      ],
                    ),
                    verticalHeight(Dimensions.h20)
                  ],
                );
              },)),
            )
            // Single post,
          ],
        ),
    );
  }
}

// Widget for story avatars
class _StoryItem extends StatelessWidget {
  final String name;
  final String image;

  const _StoryItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: Dimensions.r30,
            backgroundImage: AssetImage(image),
          ),
          verticalHeight(Dimensions.h6),
          Text(
            name,
            style: fontStyleMedium16,
          ),
        ],
      ),
    );
  }
}

// Widget for post actions
class _PostAction extends StatelessWidget {
  final IconData icon;
  final int count;

  const _PostAction({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        horizontalWidth(Dimensions.w5),
        Text(
          '$count',
          style: fontStyleRegular14,
        ),
      ],
    );
  }
}
