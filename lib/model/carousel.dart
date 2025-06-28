import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/carousel_controller.dart';
import 'dart:math';

class Carousel extends StatelessWidget {
  final List<String> imageList;

  const Carousel({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double thumbnailWidth = screenWidth * 0.06;
    double thumbnailHeight = screenWidth * 0.04;
    double displayImageWidth = screenWidth * 0.6;
    double displayImageHeight = screenWidth * 0.3;
    double arrowSize = screenWidth < 600 ? 32 : 48;
    double arrowTapArea = screenWidth < 600 ? 48 : 80;
    return ChangeNotifierProvider<CarouselProvider>(
      create: (_) => CarouselProvider(imageList),
      child: Consumer<CarouselProvider>(
        builder: (context, provider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 3000),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                      child: SizedBox(
                        width: displayImageWidth,
                        height: displayImageHeight,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              provider.currentImage,
                              key: ValueKey(provider.currentImage),
                              width: displayImageWidth,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: provider.goToPrevious,
                        child: SizedBox(
                          width: arrowTapArea,
                          child: Icon(Icons.arrow_left, size: arrowSize),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: provider.goToNext,
                        child: SizedBox(
                          width: arrowTapArea,
                          child: Icon(Icons.arrow_right, size: arrowSize),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 縮圖
                Center(
                  child: SizedBox(
                    height: thumbnailHeight,
                    width: min(
                      imageList.length * (thumbnailWidth),
                      screenWidth,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => provider.goToIndex(index),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: thumbnailWidth,
                                height: thumbnailHeight,
                                // color: Colors.black,
                                child: ClipRect(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      imageList[index],
                                      width: thumbnailWidth,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              if (index != provider.currentIndex)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
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
