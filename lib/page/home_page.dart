import 'package:flutter/material.dart';
import '../homepage_photo_list.dart';
import '../model/homepage_photo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3欄
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return PhotoGridItem(photo: photos[index]);
          },
        ),
      ),
    );
  }
}
