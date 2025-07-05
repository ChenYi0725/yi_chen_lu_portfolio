import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../controller/carousel_controller.dart';
import 'dart:math';

import 'carousel_thumbnail.dart';

class Carousel extends StatelessWidget {
  final List<String> imageList;
  final String title;
  final String detailContent;
  const Carousel({
    super.key,
    required this.imageList,
    required this.title,
    required this.detailContent,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double thumbnailWidth = screenWidth * 0.08;
    double thumbnailHeight = screenWidth * 0.06;
    double displayImageWidth = screenWidth * 0.5;
    double displayImageHeight = screenWidth * 0.3;
    double arrowSize = screenWidth < 600 ? 32 : 48;
    double arrowTapArea = screenWidth < 600 ? 48 : 80;
    return ChangeNotifierProvider<CarouselProvider>(
      create: (_) => CarouselProvider(imageList),
      child: Consumer<CarouselProvider>(
        builder: (context, provider, _) {
          return Center(
            child: Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  // 縮圖
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 文字區域
                          Text(title, style: photoDetailTitleStyle),
                          Text(detailContent, style: photoDetailContentStyle),
                          Spacer(),
                          // 縮圖區域
                          CarouselThumbnail(
                            imageList: imageList,
                            provider: provider,

                            thumbnailWidth: thumbnailWidth,
                            thumbnailHeight: thumbnailHeight,
                            screenWidth: screenWidth,
                          ),

                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
