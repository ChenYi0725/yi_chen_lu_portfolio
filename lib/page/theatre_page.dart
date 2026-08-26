import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';
import 'package:yi_chen_lu_protfolio/enum.dart';
import 'package:yi_chen_lu_protfolio/provider/gallery_provider.dart';
import 'package:yi_chen_lu_protfolio/url.dart';
import '../component/photo/gallery.dart';
import '../component/header_bar.dart';
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
      body: ChangeNotifierProvider(
        create: (_) =>
            GalleryProvider(url: theatreUrl, type: GalleryType.gallery)
              ..fetchPhotos(),
        child: Consumer<GalleryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.photos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Gallery(
                    photoList: provider.photos,
                    initialExpandIndex: expandIndex,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
