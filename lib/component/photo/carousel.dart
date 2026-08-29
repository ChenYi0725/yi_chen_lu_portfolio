import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../controller/carousel_controller.dart';
import '../../provider/responsive_provider.dart';
import 'carousel_display_image.dart';
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
    final isMobile = Provider.of<ResponsiveProvider>(
      context,
      listen: false,
    ).isMobile;
    double thumbnailWidth = screenWidth * 0.08;
    double thumbnailHeight = screenWidth * 0.06;
    double displayImageWidth = screenWidth * 0.5;
    double displayImageHeight = screenWidth * 0.3;
    double arrowTapArea = screenWidth < 600 ? 48 : 80;
    return ChangeNotifierProvider<CarouselProvider>(
      create: (_) => CarouselProvider(imageList),
      child: Consumer<CarouselProvider>(
        builder: (context, provider, _) {
          return isMobile
              ? MobileCarousel(
                  imageList: imageList,
                  title: title,
                  detailContent: detailContent,
                  thumbnailWidth: screenWidth * 0.12,
                  thumbnailHeight: screenWidth * 0.09,
                  displayImageWidth: screenWidth * 0.8,
                  displayImageHeight: screenWidth * 0.4,
                  arrowTapArea: arrowTapArea,
                  screenWidth: screenWidth,
                  provider: provider,
                )
              : NormalCarousel(
                  imageList: imageList,
                  title: title,
                  detailContent: detailContent,
                  thumbnailWidth: thumbnailWidth,
                  thumbnailHeight: thumbnailHeight,
                  displayImageWidth: displayImageWidth,
                  displayImageHeight: displayImageHeight,
                  arrowTapArea: arrowTapArea,
                  screenWidth: screenWidth,
                  provider: provider,
                );
        },
      ),
    );
  }
}

class MobileCarousel extends StatelessWidget {
  const MobileCarousel({
    super.key,
    required this.imageList,
    required this.title,
    required this.detailContent,
    required this.provider,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.displayImageWidth,
    required this.displayImageHeight,
    required this.arrowTapArea,
    required this.screenWidth,
  });
  final List<String> imageList;
  final String title;
  final String detailContent;
  final CarouselProvider provider;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final double displayImageWidth;
  final double displayImageHeight;
  final double arrowTapArea;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文字區域
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(title, style: photoDetailTitleStyle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(detailContent, style: photoDetailContentStyle),
            ),
            Expanded(
              child: CarouselDisplayImage(
                displayImageWidth: displayImageWidth,
                displayImageHeight: displayImageHeight,
                provider: provider,
                arrowTapArea: arrowTapArea,
              ),
            ),
            // 縮圖區域
            CarouselThumbnail(
              imageList: imageList,
              provider: provider,
              thumbnailWidth: thumbnailWidth,
              thumbnailHeight: thumbnailHeight,
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}

class NormalCarousel extends StatelessWidget {
  const NormalCarousel({
    super.key,
    required this.imageList,
    required this.title,
    required this.detailContent,
    required this.provider,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.displayImageWidth,
    required this.displayImageHeight,
    required this.arrowTapArea,
    required this.screenWidth,
  });
  final List<String> imageList;
  final String title;
  final String detailContent;
  final CarouselProvider provider;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final double displayImageWidth;
  final double displayImageHeight;
  final double arrowTapArea;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CarouselDisplayImage(
              displayImageWidth: displayImageWidth,
              displayImageHeight: displayImageHeight,
              provider: provider,
              arrowTapArea: arrowTapArea,
            ),
          ),

          // 縮圖
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 文字區域
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(title, style: photoDetailTitleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(detailContent, style: photoDetailContentStyle),
                  ),
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
    );
  }
}
