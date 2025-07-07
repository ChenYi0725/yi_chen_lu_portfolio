import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/component/center_in_wide_screen.dart';
import 'package:yi_chen_lu_protfolio/component/photo/gallery.dart';
import 'package:yi_chen_lu_protfolio/component/header_bar.dart';

import '../constant.dart';
import '../component/photo/animated_photo.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [CenterInWideScreen(child: Gallery(photoList: dancePhoto))],
        ),
      ),
    );
  }
}
