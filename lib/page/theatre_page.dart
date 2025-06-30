import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import '../component/gallery.dart';
import '../component/header_bar.dart';
import '../photo_list.dart';
import '../component/animated_photo.dart';
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
      body: SingleChildScrollView(
        child: Column(children: [Gallery(photoList: theatrePhoto)]),
      ),
    );
  }
}
