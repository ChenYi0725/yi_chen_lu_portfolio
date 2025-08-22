import 'package:flutter/material.dart';
import 'package:yi_chen_lu_protfolio/controller/carousel_controller.dart';

class CarouselDisplayImage extends StatelessWidget {
  const CarouselDisplayImage({
    super.key,
    required this.displayImageWidth,
    required this.displayImageHeight,
    required this.provider,
    required this.arrowTapArea,
  });
  final double displayImageWidth;
  final double displayImageHeight;
  final CarouselProvider provider;
  final double arrowTapArea;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 3000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: SizedBox(
              width: displayImageWidth,
              height: displayImageHeight,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.network(
                    provider.currentImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    key: ValueKey(provider.currentImage),
                    height: displayImageHeight,
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
              child: SizedBox(width: arrowTapArea),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: provider.goToNext,
              child: SizedBox(width: arrowTapArea),
            ),
          ),
        ],
      ),
    );
  }
}
