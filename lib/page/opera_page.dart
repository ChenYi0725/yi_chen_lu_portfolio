import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../component/header_bar.dart';
import '../component/photo/gallery.dart';
import '../constant.dart';
import '../enum.dart';
import '../provider/gallery_provider.dart';
import '../url.dart';

class OperaPage extends StatelessWidget {
  const OperaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final expandIndexStr = GoRouterState.of(
      context,
    ).uri.queryParameters['expandIndex'];
    final expandIndex = expandIndexStr != null
        ? int.tryParse(expandIndexStr)
        : null;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: HeaderBar(
        currentRoute: "/opera",
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      body: ChangeNotifierProvider(
        create: (_) =>
            GalleryProvider(url: operaUrl, type: GalleryType.gallery)
              ..fetchPhotos(),
        child: Consumer<GalleryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.photos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Gallery(
              photoList: provider.photos,
              initialExpandIndex: expandIndex,
            );
          },
        ),
      ),
    );
  }
}
