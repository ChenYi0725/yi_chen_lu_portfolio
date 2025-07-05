import 'package:flutter/material.dart';

import '../constant.dart';
import 'carousel.dart';
import '../model/photo_model.dart';
import '../photo_list.dart';
import 'gallery.dart';

class PhotoDetail extends StatelessWidget {
  final Photo photo;
  final double indicatorOffset;
  final detailColor = Colors.grey[800];

  PhotoDetail({super.key, required this.photo, required this.indicatorOffset});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: photoDetailHeight,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: detailColor),
          child: Carousel(
            imageList: homePagePhotoList,
            title: photo.title,
            detailContent: '${photo.title} detail',
          ),
        ),
        Positioned(
          top: 1,
          left: indicatorOffset,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(width: 25, height: 15, color: detailColor),
          ),
        ),
      ],
    );
  }
}
