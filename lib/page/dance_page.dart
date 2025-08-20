import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/component/photo/gallery.dart';
import 'package:yi_chen_lu_protfolio/component/header_bar.dart';

import '../constant.dart';
import '../photo_list.dart';

class DancePage extends StatelessWidget {
  const DancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expandIndexStr = GoRouterState.of(
      context,
    ).uri.queryParameters['expandIndex'];
    final expandIndex = expandIndexStr != null
        ? int.tryParse(expandIndexStr)
        : null; //get index
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
          children: [
            Gallery(photoList: dancePhoto, initialExpandIndex: expandIndex),
          ],
        ),
      ),
    );
  }
}
