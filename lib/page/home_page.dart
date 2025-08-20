import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/url.dart';
import '../constant.dart';
import '../provider/cover_provider.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CoverProvider()..loadPhotos(coverUrl, context), // 這裡就先 fetch
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Timer? _timer;

  void _startAutoFade(int photoCount) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || photoCount == 0) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % photoCount;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoverProvider>(
      builder: (context, provider, child) {
        final photos = provider.photos; // 直接拿 widget list

        if (photos.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 啟動輪播
        _startAutoFade(photos.length);

        final currentPhoto = photos[_currentIndex]; // 已經是 widget
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
                  child: SizedBox(
                    key: ValueKey(_currentIndex),
                    width: double.infinity,
                    height: double.infinity,
                    child: currentPhoto,
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
    );
  }
}
