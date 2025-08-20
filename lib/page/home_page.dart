import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../provider/cover_provider.dart';
import '../url.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoverProvider()..fetchPhotos(coverUrl),
      child: Consumer<CoverProvider>(
        builder: (context, provider, child) {
          final photos = provider.photoUrls;
          if (photos.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final imageUrl = photos[provider.currentIndex];
          final screenWidth = MediaQuery.of(context).size.width;

          return Scaffold(
            backgroundColor: themeColor,
            body: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child: Image.network(
                      imageUrl,
                      key: ValueKey(imageUrl),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.black12,
                        child: const Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenWidth * 0.03,
                  left: screenWidth * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YICHEN  LU',
                        style: homePageNameStyle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'LIGHTING DESIGN',
                        style: homePageCareerStyle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => context.go('/theatre'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.0),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            'EXPLORE',
                            style: homePageEnterStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
