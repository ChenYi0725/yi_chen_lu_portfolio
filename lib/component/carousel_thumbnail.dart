import 'dart:math';
import 'package:flutter/material.dart';

import '../controller/carousel_controller.dart';

class CarouselThumbnail extends StatelessWidget {
  final List<String> imageList;
  final CarouselProvider provider;

  final double thumbnailWidth;
  final double thumbnailHeight;
  final double screenWidth;

  const CarouselThumbnail({
    super.key,
    required this.imageList,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.screenWidth,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thumbnailHeight * 1.5,
      width: thumbnailWidth * 5.5,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black54),
          BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: -5.0),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _arrowButton(left: true, onTap: provider.goToPrevious),
            SizedBox(
              width: min(3 * thumbnailWidth, screenWidth),
              height: thumbnailHeight,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, i) {
                  int index;
                  if (provider.currentIndex == 0) {
                    index = i;
                  } else if (provider.currentIndex == imageList.length - 1) {
                    index = imageList.length - 3 + i;
                  } else {
                    index = provider.currentIndex - 1 + i;
                  }

                  if (index < 0 || index >= imageList.length) {
                    return SizedBox(width: thumbnailWidth);
                  }

                  return GestureDetector(
                    onTap: () => provider.goToIndex(index),
                    child: Container(
                      width: thumbnailWidth,
                      height: thumbnailHeight,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            imageList[index],
                            width: thumbnailWidth,
                            height: thumbnailHeight,
                            fit: BoxFit.cover,
                          ),
                          if (index != provider.currentIndex)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            _arrowButton(left: false, onTap: provider.goToNext),
          ],
        ),
      ),
    );
  }

  Widget _arrowButton({required bool left, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: thumbnailHeight,
        color: Colors.black12,
        child: Icon(
          left ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ),
    );
  }
}
