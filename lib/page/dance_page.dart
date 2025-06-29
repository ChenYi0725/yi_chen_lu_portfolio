import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/component/header_bar.dart';

import '../constant.dart';
import '../model/photo_grid.dart';
import '../photo_list.dart';

class DancePage extends StatelessWidget {
  const DancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: HeaderBar(
        currentRoute: "/dance",
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: dancePhoto.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3欄
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return PhotoGridItem(photo: dancePhoto[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
