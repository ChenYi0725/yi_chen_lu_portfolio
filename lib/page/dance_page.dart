import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/component/photo/gallery.dart';
import 'package:yi_chen_lu_protfolio/component/header_bar.dart';
import 'package:yi_chen_lu_protfolio/url.dart';
import '../constant.dart';
import '../enum.dart';
import '../provider/gallery_provider.dart';

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
      body: ChangeNotifierProvider(
        create: (_) =>
            GalleryProvider(url: danceUrl, type: GalleryType.gallery)
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
