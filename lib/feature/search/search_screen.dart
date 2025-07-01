import 'package:flutter/material.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/dimensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 36,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey[500],),
              prefixIcon: const Icon(Icons.search,),
              border:OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.r12),borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: 60,
        itemBuilder: (context, index) {
          // placeholder color blocks
          return Container(decoration: BoxDecoration(border: Border.all()),child: Image.asset(AppImage.icIntroBg,fit: BoxFit.cover,),);
        },
      ),
    );
  }
}

