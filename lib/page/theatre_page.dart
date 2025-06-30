import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import '../component/header_bar.dart';
import '../photo_list.dart';
import '../model/photo_grid.dart';
import 'package:go_router/go_router.dart';

class TheatrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/theatre',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: theatrePhoto.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3欄
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return PhotoGridItem(photo: theatrePhoto[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
