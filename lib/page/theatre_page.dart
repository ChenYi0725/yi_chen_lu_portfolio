import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import '../component/photo/gallery.dart';
import '../component/header_bar.dart';
import '../photo_list.dart';
import 'package:go_router/go_router.dart';

class TheatrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expandIndexStr = GoRouterState.of(
      context,
    ).uri.queryParameters['expandIndex'];
    final expandIndex = expandIndexStr != null
        ? int.tryParse(expandIndexStr)
        : null; //get index
    return Scaffold(
      appBar: HeaderBar(
        currentRoute: '/theatre',
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      backgroundColor: themeColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gallery(photoList: theatrePhoto, initialExpandIndex: expandIndex),
          ],
        ),
      ),
    );
  }
}
