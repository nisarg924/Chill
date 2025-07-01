import 'package:flutter/material.dart';
import 'package:social_app/feature/home/home_screen.dart';

import '../../feature/post/add_post_screen.dart';
import '../../feature/search/search_screen.dart';
import '../../feature/shop/shop_screen.dart';
import '../../feature/user/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  ValueNotifier<int> currentIndex = ValueNotifier(0);
  final List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const ShopScreen(),
    const ProfileScreen(),
  ];

  bool _isNavBarVisible = true;
  double _lastOffset = 0;

  void _handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final currentOffset = notification.metrics.pixels;

      if (currentOffset > _lastOffset && _isNavBarVisible) {
        // scrolling down
        setState(() => _isNavBarVisible = false);
      } else if (currentOffset < _lastOffset && !_isNavBarVisible) {
        // scrolling up
        setState(() => _isNavBarVisible = true);
      }

      _lastOffset = currentOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _handleScroll(notification);
          return false;
        },
        child: ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context,index,_) {
            return pages[index];
          }
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, _) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isNavBarVisible ? kBottomNavigationBarHeight : 0,
            child: Wrap(
              children:[BottomNavigationBar(
                currentIndex: index,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined),activeIcon: Icon(Icons.home),label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.search_outlined),activeIcon: Icon(Icons.search),label: "Search"),
                  BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined),activeIcon:Icon(Icons.add_box),label: "Add"),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),activeIcon: Icon(Icons.shopping_bag),label: "Shop"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline),activeIcon: Icon(Icons.person),label: "Profile"),
                ],onTap:(index){currentIndex.value =index;},type: BottomNavigationBarType.fixed,),]
            ),
          );
        }
      ),
    );
  }
}
