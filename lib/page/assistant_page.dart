import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../component/header_bar.dart';
import '../component/photo/gallery.dart';
import '../constant.dart';
import '../enum.dart';
import '../provider/gallery_provider.dart';
import '../url.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: HeaderBar(
        currentRoute: "/assistant",
        onNavItemSelected: (route) {
          context.go(route);
        },
      ),
      body: ChangeNotifierProvider(
        create: (_) =>
            GalleryProvider(url: assistantUrl, type: GalleryType.url)
              ..fetchPhotos(),
        child: Consumer<GalleryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.photos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(children: [Gallery(photoList: provider.photos)]),
            );
          },
        ),
      ),
    );
  }
}
